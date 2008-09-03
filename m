From: "Arun KS" <getarunks@gmail.com>
Subject: Re: Reset unused clocks during boot causing problem on 5912 OSK
Date: Wed, 3 Sep 2008 22:57:59 +0530
Message-ID: <dfeb90390809031027h4e0de05s2126a65984d648ae@mail.gmail.com>
References: <dfeb90390809030702o40710b8cpab328466dac3a4a@mail.gmail.com>
	 <20080903140921.GF16796@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:60219 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbYICR2C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 13:28:02 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1720470tic.23
        for <linux-omap@vger.kernel.org>; Wed, 03 Sep 2008 10:28:00 -0700 (PDT)
In-Reply-To: <20080903140921.GF16796@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org

Hi Balbi,

That clk_enable() is for sys_clkout, which is the MCLK for the CODEC.

I am following n810.c file itself.

But I m talking about omap_mcbsp_request(0), which will only be called when
we do an aplay, by the platform driver of the omap(sound/soc/omap/ompa-mcbsp.c).
But before this the unused clocks are switched off by clock.c in
arch/arm/mach-omap1/clocks.c.
And when i call the omap_mcbsp_request(), the entire system hangs...

Arun

On Wed, Sep 3, 2008 at 7:39 PM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> On Wed, Sep 03, 2008 at 07:32:51PM +0530, ext Arun KS wrote:
>> Hi all,
>>
>> I am trying to write an ASOC driver for tlv320aic23 on 5912osk.
>> When i do an aplay, the system is hanging.
>> Later i found that it is hanging when mcbsp1 is requested in funcion
>> omap_mcbsp_dai_startup in file sound/soc/omap/omap-mcbsp.c
>>
>> The reason is that the unused clocks are switched off during booting.
>>
>> So i decided to disable the option (reset unused clocks during boot) from
>> system type -> TI OMAP Implementations in menuconfig.
>>
>> But still its not working.
>>
>> When i give omap_mcbsp_request(0) in init function of my machine
>> driver, i m able
>> to get the requested mcbsp.
>
> Take a look at sound/soc/omap/n810.c, under n810_startup() it calls
> clk_enable().
>
> Maybe you should do the same. But since tlv320aic23 is used by more than
> one machine you could make the clk_enable be board specific.
>
> But one step at a time, take a look here:
>
>  71 static int n810_startup(struct snd_pcm_substream *substream)
>  72 {
>  73         struct snd_soc_pcm_runtime *rtd = substream->private_data;
>  74         struct snd_soc_codec *codec = rtd->socdev->codec;
>  75
>  76         n810_ext_control(codec);
>  77         return clk_enable(sys_clkout2);
>  78 }
>
> --
> balbi
>
