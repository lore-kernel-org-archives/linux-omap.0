From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: [PATCH 0/3] [OMAP:I2C] Small bug fixes and errata 1.153
Date: Tue, 14 Jul 2009 16:15:53 -0500
Message-ID: <CD8CC2B65FEE304DA95744A5472698F202957C7AF6@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39751 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbZGNVQM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 17:16:12 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, Paul Walmsley <paul@pwsan.com>


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

