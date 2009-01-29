From: Krishna Kishore <krishna.kishore@sasken.com>
Subject: [DSPBridge driver] bridgedriver: Unknown symbol __bad_func_type
Date: Thu, 29 Jan 2009 10:49:57 +0530
Message-ID: <F9F1042FDECC134ABFBF4EC5EBEC88DAB3600F@EXGZ02.sasken.com>
References: <27F9C60D11D683428E133F85D2BB4A5303F7EA4D94@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mta-blr1.sasken.com ([203.200.200.72]:31036 "EHLO
	mta-blr1.sasken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbZA2FUB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 00:20:01 -0500
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

 
Hi,

   We are successful in building and using bridge driver with opensource
linux kernel 
   (with kernel provided in CSSD 23.3,23.7 and 23.11 packages).

   But, when we build bridge driver with a different kernel
(Montavista), we are getting 
         "bridgedriver: Unknown symbol __bad_func_type"
   when we install bridgedriver.ko.

   Why is this problem occuring with one specific linux kernel?

Regards,
Kishore.
SASKEN BUSINESS DISCLAIMER
-------------------------
This message may contain confidential, proprietary or legally privileged information. In 
case you are not the original intended Recipient of the message, you must not, directly or 
indirectly, use, Disclose, distribute, print, or copy any part of this message and you are 
requested to delete it and inform the sender. Any views expressed in this message are 
those of the individual sender unless otherwise stated. Nothing contained in this message 
shall be construed as an offer or acceptance of any offer by Sasken Communication 
Technologies Limited ("Sasken") unless sent with that express intent and with due 
authority of Sasken. Sasken has taken enough precautions to prevent the spread of 
viruses. However the company accepts no liability for any damage caused by any virus 
transmitted by this email

