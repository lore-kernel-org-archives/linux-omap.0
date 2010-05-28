From: "Stephen Schwarm, CSDP" <w3eve@earthlink.net>
Subject: simple sd card performance bug fix on OMAP
Date: Fri, 28 May 2010 15:05:00 -0400
Message-ID: <4C0013DC.6060601@earthlink.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030502080906080409030806"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:38356 "EHLO
	elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752631Ab0E1TkK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 May 2010 15:40:10 -0400
Received: from [173.14.164.189] (helo=[192.168.3.100])
	by elasmtp-dupuy.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <w3eve@earthlink.net>)
	id 1OI4rd-0008WB-9J
	for linux-omap@vger.kernel.org; Fri, 28 May 2010 15:05:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030502080906080409030806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have not had time to make a formal patch for this but I thought it was 
significant enough just to send it out.  The problem is on omap systems 
that use omap_hsmmc.c to run sd or mmc cards.  If the system you are 
using has an 8 wire interface, it will only use a one wire interface to 
4 wire cards (eg, sd class 4 and sd class 6).

In the file driver/mmc/omap_hsmmc.c in the function omap_hsmmc_probe:
at about line 1739 change:

    if (mmc_slot(host).wires >= 8)
        mmc->caps |= MMC_CAP_8_BIT_DATA;
    else if (mmc_slot(host).wires >= 4)
        mmc->caps |= MMC_CAP_4_BIT_DATA;

to:

    if (mmc_slot(host).wires >= 8)
        mmc->caps |= MMC_CAP_8_BIT_DATA;
    if (mmc_slot(host).wires >= 4)
        mmc->caps |= w;

just delete the word "else".  This sets the MMC_CAP_4_BIT_DATA bit on 
interfaces that have 8 wire interfaces.

We have seen a BIG performance improvement on our systems.

Steve Schwarm



--------------030502080906080409030806
Content-Type: text/x-vcard; charset=utf-8;
 name="w3eve.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="w3eve.vcf"

begin:vcard
fn:Stephen  Schwarm, CSDP
n:Schwarm, CSDP;Stephen 
adr;dom:;;30 Hayden Woods;Wrentham;MA;02093
email;internet:schwarm@ieee.org
tel;home:508-384-7697
tel;cell:508-922-9688
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------030502080906080409030806--
