From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: simple sd card performance bug fix on OMAP
Date: Fri, 28 May 2010 14:53:02 -0500
Message-ID: <006801cafe9f$6209e030$544ff780@am.dhcp.ti.com>
References: <4C0013DC.6060601@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48562 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755774Ab0E1TxF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 May 2010 15:53:05 -0400
In-Reply-To: <4C0013DC.6060601@earthlink.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'Stephen Schwarm, CSDP'" <w3eve@earthlink.net>, linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Stephen Schwarm, CSDP
> Sent: Friday, May 28, 2010 2:05 PM
> To: linux-omap@vger.kernel.org
> Subject: simple sd card performance bug fix on OMAP
> 
> I have not had time to make a formal patch for this but I thought it was
> significant enough just to send it out.  The problem is on omap systems
> that use omap_hsmmc.c to run sd or mmc cards.  If the system you are
> using has an 8 wire interface, it will only use a one wire interface to
> 4 wire cards (eg, sd class 4 and sd class 6).
> 
A patch to fix this was already posted on LO by Kishore.

Regards,
Madhu

> In the file driver/mmc/omap_hsmmc.c in the function omap_hsmmc_probe:
> at about line 1739 change:
> 
>     if (mmc_slot(host).wires >= 8)
>         mmc->caps |= MMC_CAP_8_BIT_DATA;
>     else if (mmc_slot(host).wires >= 4)
>         mmc->caps |= MMC_CAP_4_BIT_DATA;
> 
> to:
> 
>     if (mmc_slot(host).wires >= 8)
>         mmc->caps |= MMC_CAP_8_BIT_DATA;
>     if (mmc_slot(host).wires >= 4)
>         mmc->caps |= w;
> 
> just delete the word "else".  This sets the MMC_CAP_4_BIT_DATA bit on
> interfaces that have 8 wire interfaces.
> 
> We have seen a BIG performance improvement on our systems.
> 
> Steve Schwarm
> 


