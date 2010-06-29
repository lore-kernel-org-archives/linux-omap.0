From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: Boot fail on OMAP3430SDP
Date: Tue, 29 Jun 2010 19:05:48 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305A40F8A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36406 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752564Ab0F2Nfy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 09:35:54 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5TDZocG025119
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 29 Jun 2010 08:35:53 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o5TDZo7M017199
	for <linux-omap@vger.kernel.org>; Tue, 29 Jun 2010 19:05:50 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I am observing that image built using omap3_pm_defconfig on Kevin's pm branch does not seem to boot on OMAP3430 SDP board. It just stops after printing "Uncompressing Linux... done, booting the kernel". I am using console=ttyS0 as part of my bootargs. Any hints?

Vishwa
