From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 00/09] OMAP:GPIO:Implement GPIO in HWMOD way
Date: Fri, 7 May 2010 12:27:37 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5387A73@dbde02.ent.ti.com>
References: <1271951720-21714-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52174 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499Ab0EGG5o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 02:57:44 -0400
In-Reply-To: <1271951720-21714-1-git-send-email-charu@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony/ Kevin,

> -----Original Message-----
> From: Varadarajan, Charulatha
> Sent: Thursday, April 22, 2010 9:25 PM
> To: linux-omap@vger.kernel.org
> Cc: Nayak, Rajendra; paul@pwsan.com; tony@atomide.com;
> khilman@deeprootsystems.com; Varadarajan, Charulatha
> Subject: [PATCH 00/09] OMAP:GPIO:Implement GPIO in HWMOD way
> 
> This patch series implements GPIO as an early platform driver.
> It makes OMAP2PLUS specific GPIO to get adapted to HWMOD FW.
> OMAP1 specific GPIO is implemented as early platform device.
> 
> This patch series is created on "origin/pm-wip/hwmods". 

Planning to send few more patches for adapting some other
drivers to HWMOD FW. 
Which tree should those patches be created on?
LO mainline? or hwmods branch? or runtime branch?

-V Charulatha
