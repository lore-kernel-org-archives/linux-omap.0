From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [gadiyar@ti.com: [PATCH] watchdog: fix typo in omap_wdt.c]
Date: Mon, 29 Sep 2008 13:23:46 +0300
Message-ID: <20080929102346.GA13245@gandalf.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59162 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbYI2KX7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 06:23:59 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tony,

i think you'd like to apply this to your tree as well (it's already with
Wim) to avoid any bug when people try tro use omap_wdt.c

-- 
balbi

--C7zPtVaVf+AK4Oqc
Content-Type: message/rfc822
Content-Disposition: inline

Received: from vaebe111.noe.nokia.com [10.160.244.80]
	by gandalf.research.nokia.com with IMAP (fetchmail-6.3.8)
	for <underline@localhost> (single-drop); Mon, 29 Sep 2008 07:24:26 +0300 (EEST)
Received: from esebh102.NOE.Nokia.com ([172.21.138.183]) by vaebe111.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Sep 2008 07:24:15 +0300
Received: from esebh107.NOE.Nokia.com ([172.21.143.143]) by esebh102.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Sep 2008 07:24:15 +0300
Received: from mgw-mx01.nokia.com ([192.100.122.228]) by esebh107.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Sep 2008 07:24:14 +0300
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by mgw-mx01.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8T4OBN2022856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <felipe.balbi@nokia.com>; Mon, 29 Sep 2008 07:24:13 +0300
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m8T4O0qx021183
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 28 Sep 2008 23:24:07 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id m8T4NxmA020507;
	Mon, 29 Sep 2008 09:54:00 +0530 (IST)
Received: from dbde02.ent.ti.com ([172.24.170.145]) by dbde70.ent.ti.com
 ([172.24.170.148]) with mapi; Mon, 29 Sep 2008 09:53:59 +0530
From: "ext Gadiyar, Anand" <gadiyar@ti.com>
To: Wim Van Sebroeck <wim@iguana.be>
CC: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Date: Mon, 29 Sep 2008 09:53:57 +0530
Subject: [PATCH] watchdog: fix typo in omap_wdt.c
Thread-Topic: [PATCH] watchdog: fix typo in omap_wdt.c
Thread-Index: Ackh6zDybnIZWUDwTPCIMVKMKojn/g==
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC9704@dbde02.ent.ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Nokia-AV: Clean
X-pstn-spam: W
X-Spam-Score: 0.00%
Return-Path: gadiyar@ti.com
X-OriginalArrivalTime: 29 Sep 2008 04:24:15.0525 (UTC) FILETIME=[3B73DD50:01C921EB]

From: Anand Gadiyar <gadiyar@ti.com>

Fix typo in omap_wdt.c introduced by a recent change

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 drivers/watchdog/omap_wdt.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: tony/drivers/watchdog/omap_wdt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- tony.orig/drivers/watchdog/omap_wdt.c	2008-09-25 16:45:08.000000000 +05=
30
+++ tony/drivers/watchdog/omap_wdt.c	2008-09-26 21:14:48.059042569 +0530
@@ -283,7 +283,7 @@ static int __init omap_wdt_probe(struct=20
 	}
=20
 	if (omap_wdt_dev) {
-		ret - EBUSY;
+		ret =3D -EBUSY;
 		goto err_busy;
 	}
 =

--C7zPtVaVf+AK4Oqc--
