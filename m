From: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Subject: [PATCH 1/2] Input: tsc2007: fix locking method against the current rc
	kernel
Date: Mon, 11 May 2009 20:41:35 +0900
Message-ID: <483a38b80905110441t703adbd6sab31bcf19b507fc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thierry Reding <thierry.reding@avionic-design.de>
Cc: Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

The following patch fixes bug in tsc2007.
It is not working correctly in the current rc kernels.
IMHO, this patch should go in the 2.6.30

Can you advise me about "From: email" part?
I splited Thierry's patch. So the original "From: email" is followed:

From: Thierry Reding <thierry.reding@avionic-design.de>

Thank you,
Kwangwoo Lee

>From 749ee3a4a2c2fe1f41601481e47cb26d8ccec20d Mon Sep 17 00:00:00 2001
From: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Date: Mon, 11 May 2009 20:00:01 +0900
Subject: [PATCH 1/2] Input: tsc2007: fix locking method against the
current rc kernel.

Without this patch, current driver will emit panic message below:
Kernel panic - not syncing: Fatal exception in interrupt.

The original patch is written by Thierry.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
Signed-off-by: Kwangwoo Lee <kwangwoo.lee@gmail.com>
---
 drivers/input/touchscreen/tsc2007.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.c
b/drivers/input/touchscreen/tsc2007.c
index 536668f..948e167 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -200,8 +200,9 @@ static int tsc2007_read_values(struct tsc2007 *tsc)
 static enum hrtimer_restart tsc2007_timer(struct hrtimer *handle)
 {
 	struct tsc2007 *ts = container_of(handle, struct tsc2007, timer);
+	unsigned long flags;

-	spin_lock_irq(&ts->lock);
+	spin_lock_irqsave(&ts->lock, flags);

 	if (unlikely(!ts->get_pendown_state() && ts->pendown)) {
 		struct input_dev *input = ts->input;
@@ -222,7 +223,7 @@ static enum hrtimer_restart tsc2007_timer(struct
hrtimer *handle)
 		tsc2007_send_event(ts);
 	}

-	spin_unlock_irq(&ts->lock);
+	spin_unlock_irqrestore(&ts->lock, flags);

 	return HRTIMER_NORESTART;
 }
-- 
1.5.6.5
