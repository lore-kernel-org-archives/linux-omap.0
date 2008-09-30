From: "Arun KS" <arunks@mistralsolutions.com>
Subject: Re: [PATCH 3/5] [RFC] ALSA ASOC Adds DSP DAI format support for platform driver
Date: Tue, 30 Sep 2008 12:11:45 +0530
Message-ID: <dfeb90390809292341l2264ff52m80830952b38ea25f@mail.gmail.com>
References: <dfeb90390809290250x7c9d3aafh232fbcbe8ae77d7e@mail.gmail.com>
	 <20080929141540.e6ae8ead.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:17167 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbYI3Gls (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 02:41:48 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2703195rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 29 Sep 2008 23:41:47 -0700 (PDT)
In-Reply-To: <20080929141540.e6ae8ead.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, alsa-devel@vger.kernel.org, felipe.balbi@nokia.com

On Mon, Sep 29, 2008 at 4:45 PM, Jarkko Nikula <jarkko.nikula@nokia.com> wrote:
> On Mon, 29 Sep 2008 15:20:12 +0530
> "ext Arun KS" <arunks@mistralsolutions.com> wrote:
>
>> Enables DSP DAI format for mcbsp in omap platform driver
>>
>> Signed-off-by: Arun KS <arunks@mistralsolutions.com>
>> ---
>>  sound/soc/omap/omap-mcbsp.c |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
>> index 3a4cc4b..1c024aa 100644
>> --- a/sound/soc/omap/omap-mcbsp.c
>> +++ b/sound/soc/omap/omap-mcbsp.c
>> @@ -292,6 +292,12 @@ static int omap_mcbsp_dai_set_dai_fmt(struct
>> snd_soc_dai *cpu_dai,
>>               regs->rcr2      |= RDATDLY(1);
>>               regs->xcr2      |= XDATDLY(1);
>>               break;
>> +     case SND_SOC_DAIFMT_DSP_A:
>> +             /* 0-bit data delay */
>> +             regs->rcr2      |= RDATDLY(0);
>> +             regs->xcr2      |= XDATDLY(0);
>> +             break;
>> +
>>       default:
>
> I think this is not enough. The word clock length equals to one BCLK
> cycle in DSP mode. Not n channel bit BCLK cycles like in I2S.
>

In DSP Mode, Frame sync is followed by two data words.
I tested this patch and its working. Am i missing something ?

>
> Jarkko
> --
> To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
