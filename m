From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 0/5] Convert I2C driver to use omap_device/runtime PM
Date: Mon, 9 Aug 2010 20:05:57 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401D5CE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41425 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756684Ab0HIOgE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 10:36:04 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi,

This series makes I2C device registration use hwmod
and omap_device api's and converts the I2C driver to use
runtime PM api's.

Patches apply on the pm-wip/hwmods-omap4 branch from Kevin's tree.

Patches are tested on OMAP3 and OMAP4 SDP platforms.

regards,
Rajendra

Paul Walmsley (2):
  OMAP2xxx: hwmod: add I2C hwmods for OMAP2420, 2430
  OMAP: I2C: split device registration; convert OMAP2+ to omap_device

Rajendra Nayak (3):
  OMAP4: runtime: Enable PM runtime core for OMAP4
  OMAP3: hwmod: add I2C hwmods for OMAP3430
  OMAP: I2C: Convert i2c driver to use PM runtime api's
  
