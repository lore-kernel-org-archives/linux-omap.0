From: "santosh.shilimkar@oralce.com" <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 1/5] ARM: OMAP3: Fix errors for omap_l3_smx when booted
 with device tree
Date: Wed, 05 Nov 2014 12:16:45 -0800
Message-ID: <545A85AD.3030309@oracle.com>
References: <1415212550-24692-1-git-send-email-tony@atomide.com> <1415212550-24692-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:48168 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbaKEUQH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2014 15:16:07 -0500
In-Reply-To: <1415212550-24692-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <ssantosh@kernel.org>



On 11/05/2014 10:35 AM, Tony Lindgren wrote:
> When booting omap3 in device tree mode, we're currently getting
> the following errors:
>
> omap_l3_smx omap_l3_smx.0: couldn't request debug irq
> omap_l3_smx: probe of omap_l3_smx.0 failed with error -22
>
> This is because we don't have handling in the driver for the
> compatible property and instead assume platform data being
> passed.
>
> Note that this binding is already documented, and implemented
> for the related omap_l3_noc driver for omap4 and later. Looks
> like the binding somehow never got never implemented for this
> omap_l3_smx driver though.
>
> Let's also remove __exit_p to allow binding and unbinding
> of the driver while at it.
>
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
