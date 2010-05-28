From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: simple sd card performance bug fix on OMAP
Date: Sat, 29 May 2010 01:24:30 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032162380F@dbde02.ent.ti.com>
References: <4C0013DC.6060601@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40241 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756549Ab0E1Tyf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 15:54:35 -0400
In-Reply-To: <4C0013DC.6060601@earthlink.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stephen Schwarm, CSDP" <w3eve@earthlink.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Stephen Schwarm, CSDP wrote:
> 
> I have not had time to make a formal patch for this but I thought it was
> significant enough just to send it out.  The problem is on omap systems
> that use omap_hsmmc.c to run sd or mmc cards.  If the system you are
> using has an 8 wire interface, it will only use a one wire interface to
> 4 wire cards (eg, sd class 4 and sd class 6).
> 
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

Thanks for reporting this.

A similar patch was posted a while ago and is currently marked as "awaiting upstream", although it looks like it got lost again.

<https://patchwork.kernel.org/patch/78713/>

- Anand
