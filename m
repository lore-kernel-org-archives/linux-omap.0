From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 02/19] ARM: OMAP4: Add SAR ROM base address
Date: Mon, 21 May 2012 11:28:45 +0300
Message-ID: <1337588925.2149.371.camel@sokoban>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	 <1336990730-26892-3-git-send-email-t-kristo@ti.com> <87zk98dlq6.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59700 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656Ab2EUI2x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 May 2012 04:28:53 -0400
In-Reply-To: <87zk98dlq6.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Wed, 2012-05-16 at 11:28 -0700, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > Added in preparation for device off mode. SAR ROM contains the mapping
> > from SAR RAM to IO registers, and this will eventually be parsed during
> > init time to do the reverse before device off.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> This should be combined with the patch that uses the #define.

Okay sounds good.

-Tero

> 
> Kevin
> 
> > ---
> >  arch/arm/plat-omap/include/plat/omap44xx.h |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
> > index c0d478e..1a45700 100644
> > --- a/arch/arm/plat-omap/include/plat/omap44xx.h
> > +++ b/arch/arm/plat-omap/include/plat/omap44xx.h
> > @@ -46,6 +46,7 @@
> >  #define OMAP44XX_MCPDM_BASE		0x40132000
> >  #define OMAP44XX_MCPDM_L3_BASE		0x49032000
> >  #define OMAP44XX_SAR_RAM_BASE		0x4a326000
> > +#define OMAP44XX_SAR_ROM_BASE		0x4a05e000
> >  
> >  #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
> >  #define OMAP44XX_HSUSB_OTG_BASE		(L4_44XX_BASE + 0xAB000)


