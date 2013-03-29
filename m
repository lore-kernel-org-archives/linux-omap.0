From: "Gupta, Pekon" <pekon@ti.com>
Subject: NAND: ecc-opt=hw-romcode == OMAP_ECC_HAMMING_CODE_HW_ROMCODE
Date: Fri, 29 Mar 2013 10:27:10 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9A5B14@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33177 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab3C2K1P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Mar 2013 06:27:15 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id r2TARDTk008329
	for <linux-omap@vger.kernel.org>; Fri, 29 Mar 2013 05:27:14 -0500
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id r2TARCQq018950
	for <linux-omap@vger.kernel.org>; Fri, 29 Mar 2013 15:57:12 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Just wanted to enquire,
if someone has used following configuration with earlier OMAP devices.

ti,nand-ecc-opt = "hw-romcode";

Documentation/devicetree/bindings/mtd/gpmc-nand.txt
	"hw-romcode"	gpmc hamming mode method & romcode layout


which in earlier non-DT kernels would map to:
ecc_opt == ' OMAP_ECC_HAMMING_CODE_HW_ROMCODE'


with regards, pekon
