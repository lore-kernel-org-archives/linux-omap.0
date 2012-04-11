From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: omap: hwmod: Make omap_hwmod_softreset wait
 for reset status
Date: Wed, 11 Apr 2012 16:36:47 +0530
Message-ID: <4F8565C7.4080506@ti.com>
References: <1331659524-7635-1-git-send-email-rnayak@ti.com> <1331659524-7635-3-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1204101803020.20894@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:53252 "EHLO
	na3sys009amx257.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756270Ab2DKLG6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 07:06:58 -0400
Received: by ghrr18 with SMTP id r18so399876ghr.0
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 04:06:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204101803020.20894@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: b-cousson@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anand Gadiyar <gadiyar@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

Hi Paul,

On Wednesday 11 April 2012 05:41 AM, Paul Walmsley wrote:
> Just noticed that this change results in I2C softreset failed messages on
> OMAP2/3/4 on v3.4-rc2.  For example, on 2420:
>
> [    0.200378] omap_hwmod: i2c1: softreset failed (waited 10000 usec)
> [    0.222076] omap_hwmod: i2c2: softreset failed (waited 10000 usec)
>
> Looking more closely at the code, I think the intention of the original
> code was basically correct.  HDQ and I2C both need to execute some custom
> reset code after the SOFTRESET bit is set, but before the RESETDONE bit is
> tested.  After this patch, the internal hwmod code tries to wait for
> RESETDONE to change, before the custom code runs -- and that is going to
> fail.
>
> Just out of curiosity, was the change in this patch prompted by some code
> that needed the change?  Or was this a theoretical problem, driven by a
> code review?

The changes were done to fix up random L3 interconnect errors that
Anand G was seeing(during i2c reset operation) on some customer 
platforms. I seem to have completely overlooked the I2C_EN programming 
part done in omap_i2c_reset() function when I did the patch.

While the patch did fix the issue for Anand, I guess it
was because of the additional delay post reset, waiting on the
RESETDONE bit and timing out, before accessing the i2c_con register.
So looks like this patch should certainly be reverted but atleast some
platforms/modules (the issue was seen on OMAP4/i2c) will need some
delay between the omap_hwmod_softreset() call and any subsequent module
register accesses.
The patch from Fernando [1] can be quite useful if we can use the
'srst_udelay' field to populate the appropriate delay needed which can
then be used up in omap_hwmod_softreset() function.
I am out sick today, but I can try some on these lines tomorrow once
I am in office, if the approach seems fine to you.
Btw, is [1] queued already by you/Benoit to go upstream or are there
issues with it?

regards,
Rajendra

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/086713.html
