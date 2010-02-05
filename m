From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [APPLIED] [PATCH 2/4-V1] AM3517: Enable TSC2004 driver support
 for AM3517EVM
Date: Fri, 5 Feb 2010 11:03:41 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A775FEA@dbde02.ent.ti.com>
References: <1263190802-1101-3-git-send-email-hvaibhav@ti.com>
 <notify-1265331939@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42371 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005Ab0BEFds convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 00:33:48 -0500
In-Reply-To: <notify-1265331939@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Friday, February 05, 2010 6:35 AM
> To: linux-omap@vger.kernel.org
> Subject: [APPLIED] [PATCH 2/4-V1] AM3517: Enable TSC2004 driver
> support for AM3517EVM
> 
> This patch has been applied to the linux-omap
> by youw fwiendly patch wobot.
> 
[Hiremath, Vaibhav] Tony,

Please revert this single commit. Actually I had a discussion with Dmitry Torokhov and the conclusion is, as of now for TSC2004 we can reuse TSC2007, and once they start diverging we can split them. I will be submitting patches for this support shortly.

So please revert hits commit.

Thanks,
Vaibhav

> Branch in linux-omap: for-next
> 
> Initial commit ID (Likely to change):
> 5fcad6b119b8760f817dbf2f2d6331ee0cee442f
> 
> PatchWorks
> http://patchwork.kernel.org/patch/72102/
> 
> Git (Likely to change, and takes a while to get mirrored)
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-
> 2.6.git;a=commit;h=5fcad6b119b8760f817dbf2f2d6331ee0cee442f
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
