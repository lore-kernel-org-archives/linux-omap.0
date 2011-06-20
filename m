From: Leigh Brown <leigh@solinno.co.uk>
Subject: [PATCH] input: keypad: lm8323: use level triggered interrupts
Date: Mon, 20 Jun 2011 20:02:27 +0100
Message-ID: <3f659cd53ac25c98701c2bb3a453ab06@doppler.thel33t.co.uk>
References: <1307999812-3802-1-git-send-email-balbi@ti.com>
 <a07cbd61db83c3308dd76f7c0f481477@doppler.thel33t.co.uk>
 <20110619195604.GC14262@legolas.emea.dhcp.ti.com>
 <694a51cff83de55276b804b23668447e@doppler.thel33t.co.uk>
 <20110620082605.GE14262@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from doppler.thel33t.co.uk ([193.110.88.198]:41834 "EHLO
	doppler.thel33t.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965Ab1FTTCa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jun 2011 15:02:30 -0400
In-Reply-To: <20110620082605.GE14262@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

This patch, which should be applied on top of Felipe's
"input: keypad: lm8323: convert to threaded IRQ" patch, fixes the issue
of the Nokia N810 keypad stopping responding if multiple key events 
occur
in quick succession.

Signed-off-by: Leigh Brown <leigh@solinno.co.uk>
---
  drivers/input/keyboard/lm8323.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/lm8323.c 
b/drivers/input/keyboard/lm8323.c
index 3b21f42..ab0acaf 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -734,7 +734,7 @@ static int __devinit lm8323_probe(struct i2c_client 
*client,
  	}

  	err = request_threaded_irq(client->irq, NULL, lm8323_irq,
-			  IRQF_TRIGGER_FALLING, "lm8323", lm);
+			  IRQF_TRIGGER_LOW|IRQF_ONESHOT, "lm8323", lm);
  	if (err) {
  		dev_err(&client->dev, "could not get IRQ %d\n", client->irq);
  		goto fail4;

