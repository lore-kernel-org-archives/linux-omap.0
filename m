From: felipe.balbi@nokia.com
Subject: [RFC PATCH 13/37] cbus: add kerneldoc
Date: Wed,  7 Apr 2010 19:04:04 +0300
Message-ID: <1270656268-7034-14-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62352 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932885Ab0DGQFd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:33 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G5Psn007673
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 11:05:32 -0500
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

trivial patch, no functional changes.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/cbus.c |   43 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index bae7b3e..527780f 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -58,6 +58,12 @@ struct cbus_host {
 
 static struct cbus_host *cbus_host;
 
+/**
+ * cbus_send_bit - sends one bit over the bus
+ * @host: the host we're using
+ * @bit: one bit of information to send
+ * @input: whether to set data pin as input after sending
+ */
 static int cbus_send_bit(struct cbus_host *host, unsigned bit,
 		unsigned input)
 {
@@ -75,6 +81,13 @@ static int cbus_send_bit(struct cbus_host *host, unsigned bit,
 	return ret;
 }
 
+/**
+ * cbus_send_data - sends @len amount of data over the bus
+ * @host: the host we're using
+ * @data: the data to send
+ * @len: size of the transfer
+ * @input: whether to set data pin as input after sending
+ */
 static int cbus_send_data(struct cbus_host *host, unsigned data, unsigned len,
 		unsigned input)
 {
@@ -92,6 +105,10 @@ out:
 	return ret;
 }
 
+/**
+ * cbus_receive_bit - receives one bit from the bus
+ * @host: the host we're using
+ */
 static int cbus_receive_bit(struct cbus_host *host)
 {
 	int ret;
@@ -106,6 +123,11 @@ out:
 	return ret;
 }
 
+/**
+ * cbus_receive_data - receives @len data from the bus
+ * @host: the host we're using
+ * @len: the length of data to receive
+ */
 static int cbus_receive_data(struct cbus_host *host, unsigned len)
 {
 	int ret = 0;
@@ -125,6 +147,14 @@ out:
 	return ret;
 }
 
+/**
+ * cbus_transfer - transfers data over the bus
+ * @host: the host we're using
+ * @rw: read/write flag
+ * @dev: device address
+ * @reg: register address
+ * @data: if @rw == 0 data to send otherwise 0
+ */
 static int cbus_transfer(struct cbus_host *host, unsigned rw, unsigned dev,
 		unsigned reg, unsigned data)
 {
@@ -192,8 +222,10 @@ out:
 	return ret;
 }
 
-/*
- * Read a given register from the device
+/**
+ * cbus_read_reg - reads a given register from the device
+ * @dev: device address
+ * @reg: register address
  */
 int cbus_read_reg(unsigned dev, unsigned reg)
 {
@@ -201,8 +233,11 @@ int cbus_read_reg(unsigned dev, unsigned reg)
 }
 EXPORT_SYMBOL(cbus_read_reg);
 
-/*
- * Write to a given register of the device
+/**
+ * cbus_write_reg - writes to a given register of the device
+ * @dev: device address
+ * @reg: register address
+ * @val: data to be written to @reg
  */
 int cbus_write_reg(unsigned dev, unsigned reg, unsigned val)
 {
-- 
1.7.0.rc0.33.g7c3932

