From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: [PATCH 0/3] [OMAP:I2C] Small bug fixes and errata 1.153
Date: Tue, 21 Jul 2009 10:13:20 -0500
Message-ID: <CD8CC2B65FEE304DA95744A5472698F202958D2F85@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49618 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755251AbZGUPN2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 11:13:28 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


This patch includes the following:
- Bug in reading the RXSTAT/TXSTAT values from I2C_BUFFSTAT
- In case of a NACK|ARDY|AL interrupts return from the ISR
- OMAP3430 silicon errata 1.153

Signed-off-by: Moiz Sonasath<m-sonasath@ti.com> 
Signed-off-by: Vikram pandita<vikram.pandita@ti.com>

Moiz Sonasath (3):
  [OMAP:I2C]Bug in reading the RXSTAT/TXSTAT values from the
    I2C_BUFFSTAT register
  [OMAP:I2C]In case of a NACK|ARDY|AL return from the ISR
  [OMAP:I2C]OMAP3430 Silicon Errata 1.153

 drivers/i2c/busses/i2c-omap.c |   42 +++++++++++++++++++++++++++++++++-------
 1 files changed, 34 insertions(+), 8 deletions(-)

