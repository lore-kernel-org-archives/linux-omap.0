From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP4: dma: Correct CPU version check for dma_common_ch_end
Date: Thu, 23 Feb 2012 14:12:57 +0530
Message-ID: <CAMQu2gxhQNVoKWQ_gGS12U9WN9iOUdGgERiV95o4s1Bgpp+rJg@mail.gmail.com>
References: <1329470706-29682-1-git-send-email-peter.ujfalusi@ti.com>
 <20120222230714.GV18185@atomide.com> <4F45EAC1.5070309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:56050 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752282Ab2BWInS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 03:43:18 -0500
Received: by mail-qw0-f43.google.com with SMTP id g1so8215861qab.16
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 00:43:17 -0800 (PST)
In-Reply-To: <4F45EAC1.5070309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Thu, Feb 23, 2012 at 12:59 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> Hi Tony,
>
> On 02/23/2012 01:07 AM, Tony Lindgren wrote:
>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [120217 00:54]:
>>> CCDN is the last common channel register in all OMAP4 versions. Use
>>> cpu_is_omap44xx() instead of the cpu_is_omap4430() - which is anyway not
>>> doing what it supposed to do.
>>
>> This is a bit unclear.. Which is not doing what is supposed to do?
>> DMA driver? Or one of the cpu_is_omap?
>
> The cpu_is_omap4430() returns 0 unconditionally. Because of this the
> dma_common_ch_end is wrongly configured on OMAP4 (even on OMAP4430).
>
>> If this should be queued as a fix, then we need some kind of
>> description here what breaks.
>
> I will resend the patch with a better commit message. This is a bug for
> sure, but I'm not sure how severe it is. At best we are not clearing the
> registers between CCFN, and CCDN on OMAP4.
>
The bug is not severe. Infact these registers are needed for
descriptor loading sDMA feature which never made it to mainline :)
So nothing should get impacted.

Regards
Santosh
