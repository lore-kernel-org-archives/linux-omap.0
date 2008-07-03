From: Tony Lindgren <tony@atomide.com>
Subject: Re: [resend][PATCH 0/3] Adding ethernet support on omap2evm
Date: Thu, 3 Jul 2008 13:23:30 +0300
Message-ID: <20080703102327.GJ14276@atomide.com>
References: <dfeb90390806300804h6694c981h751ec9f4c5d5d832@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50780 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbYGCMc3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:32:29 -0400
Content-Disposition: inline
In-Reply-To: <dfeb90390806300804h6694c981h751ec9f4c5d5d832@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arun KS <getarunks@gmail.com>
Cc: linux-omap@vger.kernel.org

* Arun KS <getarunks@gmail.com> [080630 18:04]:
> Hi all,
> 
> The following set of patches add ethernet support for omap2evm
> I have incorporated the comments form Tony and Felipe.
> 
> *  0001-OMAP2EVM-Adding-ethernet-support.patch
>        This patch modifies the board files for supporting smc9115
> *  0002-net-smc911x-Modify-driver-to-also-work-with-omap24xx.patch
>        This patch modifies the driver files to add support for
> omap24xx platforms
>         I will be sent this patch to linux-netdev also.
> *  0003-Added-ethernet-driver-support-in-defconfig.patch

Pushing this series today to linux-omap. Please remember to follow up
on the smc911x changes on the netdev list!

Regards,

Tony


> 
> Best Regards,
> Arun KS
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
