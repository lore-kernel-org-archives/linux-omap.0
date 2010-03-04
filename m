From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 2/2] arm: omap: ehci: avoid compiler error with touchbook
Date: Thu, 4 Mar 2010 18:33:15 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321CBCDFE@dbde02.ent.ti.com>
References: <20100304074434.GI15954@nokia.com>
 <1267688753-6344-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50879 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154Ab0CDNDY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 08:03:24 -0500
In-Reply-To: <1267688753-6344-1-git-send-email-felipe.balbi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>

felipe.balbi@nokia.com wrote:
> 
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> the early_param() call in board-omap3touchbook.c expands to:
> 
> static const char __setup_str_early_touchbook_revision[]
> 	__section(.init.rodata) _aligned(1) = tbr;
> [...]
> 
> and we have a non-const variable being added to the
> same section:
> 
> static struct ehci_hcd_omap_platform_data ehci_pdata
> __section(.init.rodata);
> 
> because of that, gcc generates a section type conflict
> which can (and actually should) be avoided by marking
> const every variable marked with __initconst.
> 
> This patch fixes that for the ehci_hdc_omap_platform_data.
> 

should be ehci_hcd_omap_platform_data ;)

BTW, this breaks compile for omap3-evm.
Could you please build with omap3_defconfig and check.

- Anand
