From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/2] ARM: omap: hwmod: Make omap_hwmod_softreset wait
 for reset status
Date: Wed, 11 Apr 2012 12:59:00 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204111251100.29473@utopia.booyaka.com>
References: <1331659524-7635-1-git-send-email-rnayak@ti.com> <1331659524-7635-3-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1204101803020.20894@utopia.booyaka.com> <4F8565C7.4080506@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33131 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760903Ab2DKS7B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 14:59:01 -0400
In-Reply-To: <4F8565C7.4080506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anand Gadiyar <gadiyar@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

Hi Rajendra,

On Wed, 11 Apr 2012, Rajendra Nayak wrote:

> The changes were done to fix up random L3 interconnect errors that
> Anand G was seeing(during i2c reset operation) on some customer platforms.

Okay.

> I seem to have completely overlooked the I2C_EN programming part done in 
> omap_i2c_reset() function when I did the patch.

No worries.

> While the patch did fix the issue for Anand, I guess it
> was because of the additional delay post reset, waiting on the
> RESETDONE bit and timing out, before accessing the i2c_con register.
> So looks like this patch should certainly be reverted but atleast some
> platforms/modules (the issue was seen on OMAP4/i2c) will need some
> delay between the omap_hwmod_softreset() call and any subsequent module
> register accesses.
> The patch from Fernando [1] can be quite useful if we can use the
> 'srst_udelay' field to populate the appropriate delay needed which can
> then be used up in omap_hwmod_softreset() function.
> I am out sick today, but I can try some on these lines tomorrow once
> I am in office, if the approach seems fine to you.

Sorry to hear that - I hope you feel better soon.

That approach sounds fine to me, but I don't think Fernando's patch will 
help with I2C..  Since it uses a custom reset function omap_i2c_reset(), 
the delay will actually need to go there.

Another option though is that it might be possible to generalize the 
_ocp_softreset() function to handle the I2C/HDQ cases, so they wouldn't 
need custom reset functions.  I'd guess that's probably 3.5 material, 
though.

> Btw, is [1] queued already by you/Benoit to go upstream or are there
> issues with it?
> 
> [1]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/086713.html

Tony pulled it:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commit;h=b8a633451951d149494076393698880453bf6bfe

Not sure when he plans to send it upstream, but I now think it should go 
up sooner as part of v3.4-rc fixes, to avoid any potential OCP bus errors.


- Paul
