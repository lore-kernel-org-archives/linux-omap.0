From: Manoj Kotnala <kotnala@TechMahindra.com>
Subject: Problem in Flashing uboot on OSK5912c
Date: Thu, 26 Mar 2009 18:54:30 +0530
Message-ID: <1264B6775E17104A8413A429BBA3A4A96570813E66@SINPUNMBX001.TechMahindra.com>
References: <1237981895-9269-1-git-send-email-Hiroshi.DOYU@nokia.com><8F7AF8
	0515AF0D4D93307E594F3CB40E2349AE08@dlee03.ent.ti.com><20090325.151129.02294
	438.Hiroshi.DOYU@nokia.com><20090326.142359.186318746.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx8.techmahindra.com ([202.67.5.147]:10798 "EHLO
	MX8.TechMahindra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbZCZNrv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2009 09:47:51 -0400
In-Reply-To: <20090326.142359.186318746.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi Experts,

Sorry this query is not specific to the kernel but to the OMAP/OSK so am posting it here.

I am having OSK5912 board (rev C).
I am not getting any boot messages on it.
I tried the Flash Recovery Utility for OMAP from http://www.celinuxforum.org/CelfPubWiki/FlashRecoveryUtility
But I am not able to install the respective driver in WinXP.
I also tried OSTBoot ver 2.5 from
http://focus.ti.com/download/wtbu/OSTTools_NoSource_v2_5.zip
but couldn't succeed.
It is waiting at "Waiting for USB device to connect" message.

Next I tried the (Open source) OMAP Flash Loader  omapfl from
http://www.celinuxforum.org/CelfPubWiki/FlashRecoveryUtility?action=AttachFile&do=view&target=omapfl-1.0.tar.gz

Again Failed.

I inserted debug messages in omapfl source
It seems that OSK Board is not even throwing/publishing VendorID and Product ID from the board.

Could anyone tell me how recover the board from this stage?

Thanks in Advance,

Manoj Kotnala


============================================================================================================================

 
Disclaimer:

This message and the information contained herein is proprietary and confidential and subject to the Tech Mahindra policy statement, you may review the policy at <a href="http://www.techmahindra.com/Disclaimer.html">http://www.techmahindra.com/Disclaimer.html</a> externally and <a href="http://tim.techmahindra.com/Disclaimer.html">http://tim.techmahindra.com/Disclaimer.html</a> internally within Tech Mahindra.

============================================================================================================================
