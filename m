From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Reset unused clocks during boot causing problem on 5912 OSK
Date: Wed, 3 Sep 2008 17:09:21 +0300
Message-ID: <20080903140921.GF16796@gandalf.research.nokia.com>
References: <dfeb90390809030702o40710b8cpab328466dac3a4a@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:33189 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968AbYICOJa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 10:09:30 -0400
Content-Disposition: inline
In-Reply-To: <dfeb90390809030702o40710b8cpab328466dac3a4a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Arun KS <getarunks@gmail.com>
Cc: linux-omap@vger.kernel.org

On Wed, Sep 03, 2008 at 07:32:51PM +0530, ext Arun KS wrote:
> Hi all,
> 
> I am trying to write an ASOC driver for tlv320aic23 on 5912osk.
> When i do an aplay, the system is hanging.
> Later i found that it is hanging when mcbsp1 is requested in funcion
> omap_mcbsp_dai_startup in file sound/soc/omap/omap-mcbsp.c
> 
> The reason is that the unused clocks are switched off during booting.
> 
> So i decided to disable the option (reset unused clocks during boot) from
> system type -> TI OMAP Implementations in menuconfig.
> 
> But still its not working.
> 
> When i give omap_mcbsp_request(0) in init function of my machine
> driver, i m able
> to get the requested mcbsp.

Take a look at sound/soc/omap/n810.c, under n810_startup() it calls
clk_enable().

Maybe you should do the same. But since tlv320aic23 is used by more than
one machine you could make the clk_enable be board specific.

But one step at a time, take a look here:

 71 static int n810_startup(struct snd_pcm_substream *substream)
 72 {
 73         struct snd_soc_pcm_runtime *rtd = substream->private_data;
 74         struct snd_soc_codec *codec = rtd->socdev->codec;
 75 
 76         n810_ext_control(codec);
 77         return clk_enable(sys_clkout2);
 78 }

-- 
balbi
