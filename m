From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Subject: [PATCH] cbus-tahvo: Add tahvo_write_reg locking
Date: Sat, 5 Nov 2011 17:19:54 +0100
Message-ID: <20111105171954.230d12fb@milhouse>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bues.ch ([80.190.117.144]:35211 "EHLO bues.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804Ab1KEQUE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 5 Nov 2011 12:20:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

tahvo_write_reg() needs to take the mutex to avoid a race
condition with tahvo_set_clear_reg_bits:

tahvo_set_clear_reg_bits():   |  tahvo_write_reg():
    __tahvo_read_reg()        |
                              |      __tahvo_write_reg() <-- race here
    __tahvo_write_reg()       |

Signed-off-by: Michael Buesch <m@bues.ch>

---

Index: linux-3.1/drivers/cbus/tahvo.c
===================================================================
--- linux-3.1.orig/drivers/cbus/tahvo.c	2011-11-05 17:03:39.598846119 +0100
+++ linux-3.1/drivers/cbus/tahvo.c	2011-11-05 17:04:36.274768324 +0100
@@ -104,7 +104,9 @@ void tahvo_write_reg(struct device *chil
 {
 	struct tahvo		*tahvo = dev_get_drvdata(child->parent);
 
+	mutex_lock(&tahvo->mutex);
 	__tahvo_write_reg(tahvo, reg, val);
+	mutex_unlock(&tahvo->mutex);
 }
 EXPORT_SYMBOL(tahvo_write_reg);
 


-- 
Greetings, Michael.
