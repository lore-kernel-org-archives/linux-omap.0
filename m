From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: [PATCH 0/1] DSPBRIDGE Fix for image autoload
Date: Thu, 12 Mar 2009 11:01:31 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A8F2BED2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54618 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbZCLFcU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 01:32:20 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2C5WCTJ007464
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 00:32:18 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2C5WBSv021166
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:02:12 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Menon, Nishanth" <nm@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

All,
This patch set fixes an issue with dsp image autoloading while bridgedriver module
intialization.
This can be applied along with the other DSPBRIDGE patches, validated on OMAP3430 SDP.

 drivers/dsp/bridge/rmgr/drv_interface.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

Regards
Ramesh Gupta G