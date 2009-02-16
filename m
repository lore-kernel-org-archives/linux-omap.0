From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: RE: [pacth] I2C bug fixes for L-O and L-Z
Date: Mon, 16 Feb 2009 09:02:04 +0200
Message-ID: <1234767724.16827.7.camel@eenurkka-desktop>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61632 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbZBPHD7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2009 02:03:59 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1G73bgl024995
	for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2009 09:03:55 +0200
Received: from [172.23.118.146] (ouped118146.nmp.nokia.com [172.23.118.146])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n1G73Tio024704
	for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2009 09:03:29 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Could you please also address the question of the load on the SCL line?

In my understanding, many boards are using the experimental values
from TRM for SCLL, SCLH, HSSCLL and HSSCLH. I have notices that those
"default" values fail to provide a standard I2C clock for, at least,
boards that I have tested. Should those values be board specific and
taken off from the I2C driver? Or should a note be added there saying
"These values are board specific and they depend on the load on the SCL
line. Please measure and validate correct values for your board".


