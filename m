From: "Varadarajan, Charu Latha" <charu@ti.com>
Subject: RE: [PATCH v2] OMAP3 : Fix I2C lockup during timeout/error cases
Date: Thu, 10 Dec 2009 19:58:04 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC0A88E0@dbde02.ent.ti.com>
References: <1260451164-9459-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50135 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752294AbZLJO2C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 09:28:02 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBAES6EQ025729
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Dec 2009 08:28:08 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBAES5rT006486
	for <linux-omap@vger.kernel.org>; Thu, 10 Dec 2009 19:58:05 +0530 (IST)
In-Reply-To: <1260451164-9459-1-git-send-email-manjugk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Menon, Nishanth" <nm@ti.com>, "Sonasath, Moiz" <m-sonasath@ti.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "George, Harith" <harith@ti.com>

 

>-----Original Message-----
>From: G, Manjunath Kondaiah 
>Sent: Thursday, December 10, 2009 6:49 PM
>To: linux-omap@vger.kernel.org
>Cc: G, Manjunath Kondaiah; Menon, Nishanth; Sonasath, Moiz; 
>Krishnamoorthy, Balaji T; Varadarajan, Charu Latha; George, Harith
>Subject: [PATCH v2] OMAP3 : Fix I2C lockup during timeout/error cases
>
>Current OMAP3 I2C driver code does not follow the correct 
>sequence for soft
>reset. Due to this, lock up issues are reported during 
>timeout/error cases.
>
>This patch fixes above issue by disabling I2C controller as 
>per OMAP3430 TRM
>for soft reset. As per TRM, I2C controller needs to be 
>disabled as a first
>step during soft reset.
>
>Here is correct soft reset sequence:
>a. Ensure that the module is disabled
>(clear the I2Ci.I2C_CON[15] I2C_EN bit to 0).
>b. Set the I2Ci.I2C_SYSC[1] SRST bit to 1.
>c. Enable the module by setting I2Ci.I2C_CON[15] I2C_EN bit to 1.
>d. Check the I2Ci.I2C_SYSS[0] RDONE bit until it is set to 1 to
>indicate the software reset is complete.
>
>v1 : Initital version
>v2 : Removed delay since time taken for disabling I2C 
>controller is zero
>     jiffies
>
>Tested on Zoom2 and Zoom3 
>
>Signed-off-by: Manjunatha GK <manjugk@ti.com>
>Signed-off-by: George, Harith<harith@ti.com>

Tested on 3430SDP too.
Acked-by: Charulatha V <charu@ti.com>

