From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [Omapandroid-discussion] Difference between twl4030_hsmmc_infoand omap_mmc_platform_data
Date: Thu, 14 Oct 2010 19:35:02 -0500
Message-ID: <D58C32AF65DF4230854FDE33410E0C61@am.dhcp.ti.com>
References: <DB759C09-975B-4088-B334-79F9010573F8@mac.com><4CB78AA1.40909@ti.com> <470C7B61-2724-4777-ADF2-341E61056008@mac.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43377 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab0JOAfG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 20:35:06 -0400
In-Reply-To: <470C7B61-2724-4777-ADF2-341E61056008@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Elvis Dowson' <elvis.dowson@mac.com>, 'Nishanth Menon' <nm@ti.com>
Cc: 'Linux OMAP Mailing List' <linux-omap@vger.kernel.org>, omapandroid-discussion@omapzoom.org



> -----Original Message-----
> From: omapandroid-discussion-bounces@gforge.ti.com [mailto:omapandroid-
> discussion-bounces@gforge.ti.com] On Behalf Of Elvis Dowson
> Sent: Thursday, October 14, 2010 6:19 PM
> To: Nishanth Menon
> Cc: Linux OMAP Mailing List; omapandroid-discussion@omapzoom.org
> Subject: Re: [Omapandroid-discussion] Difference between
> twl4030_hsmmc_infoand omap_mmc_platform_data
> 
> Hi,
> 
> On Oct 15, 2010, at 2:56 AM, Nishanth Menon wrote:
> >
> > mainline does it this way:
> > board files report using omap2_hsmmc_info[2] to hsmmc.c using
> omap2_hsmmc_init[3] - hsmmc.c converts them to required datastructures
> that omap_hsmmc.c uses..
> 
> What is the relationship between twl4030 and hsmmc controller in this
> chain,
> especially with respect to MMC2?
> 

Twl4030 is the power chip. Its LDOs are modeled through the regulator
framework used by MMC1 and MMC2. On OMAP3 the card detect is from the GPIO
module of twl4030.

Regards,
Madhu

> Best regards,
> 
> Elvis
> 
> _______________________________________________
> Omapandroid-discussion mailing list
> Omapandroid-discussion@gforge.ti.com
> https://gforge.ti.com/mailman/listinfo/omapandroid-discussion

