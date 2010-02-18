From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 3/6] Mailbox: change mailbox version print to pr_debug
Date: Thu, 18 Feb 2010 09:16:01 +0200 (EET)
Message-ID: <20100218.091601.228961325.Hiroshi.DOYU@nokia.com>
References: <496565EC904933469F292DDA3F1663E602AA7C18D9@dlee06.ent.ti.com>
	<20100217.171348.223468508.Hiroshi.DOYU@nokia.com>
	<496565EC904933469F292DDA3F1663E602CA2B9B1E@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Thu_Feb_18_09_16_01_2010_454)--"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30433 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab0BRHQY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 02:16:24 -0500
In-Reply-To: <496565EC904933469F292DDA3F1663E602CA2B9B1E@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x0095840@ti.com
Cc: linux-omap@vger.kernel.org

----Next_Part(Thu_Feb_18_09_16_01_2010_454)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Fernando,

From: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 3/6] Mailbox: change mailbox version print to pr_debug
Date: Thu, 18 Feb 2010 07:22:03 +0100

> 
> 
>>-----Original Message-----
>>From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
>>Sent: Wednesday, February 17, 2010 9:14 AM
>>To: Guzman Lugo, Fernando
>>Cc: linux-omap@vger.kernel.org
>>Subject: Re: [PATCH 3/6] Mailbox: change mailbox version print to pr_debug
>>
>>Hi Fernand,
>>
>>From: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
>>Subject: [PATCH 3/6] Mailbox: change mailbox version print to pr_debug
>>Date: Sat, 13 Feb 2010 02:40:41 +0100
>>
>>> From 60e21e76773de379deb41ff166f9679b7078276f Mon Sep 17 00:00:00 2001
>>> From: Fernando Guzman Lugo <x0095840@ti.com>
>>> Date: Wed, 10 Feb 2010 17:08:20 -0600
>>> Subject: [PATCH] Mailbox: change mailbox version print to pr_debug
>>>
>>> it is not useful printing the version every time mailbox is used
>>> instead change it to pr_debug in case someone needs to see the
>>> version can enable the print.
>>
>>I just found that, if you put the line printing version into debug
>>mode, then "mbox_read_reg(MAILBOX_REVISION)" should be also done only
>>in debug mode. This value wouldn't be necessary if it didn't print.
>>
>>Considering this printing again, this prints a message only when H/W
>>initialization is done correctly, most likely only *once* at
>>booting. This informs us of the result that a mailbox H/W itself is
>>set up and some mailbox related modules are loaded successfully. So
>>keeping this makes sense a little bit more rather than shutting this
>>completely silence.
> 
> The thing was that the tests I ran does a lot of install and
> uninstall bridge module that why I saw a lot of this print, but yes
> you are right in normal operation it should be printed once. On the
> other hand if this is used to state loaded successfully maybe the
> print should be changed to more meaningfully like
> "mailbox revision4.0 running or loaded"
> 
> But, let drop this patch in this moment. I will send all the patches
> again.

Agreed.

When you resend them again, then please include mine [5/6] attached
too. It's much easier.

I ack'ed all of them.

----Next_Part(Thu_Feb_18_09_16_01_2010_454)--
Content-Type: Text/X-Patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="5.patch"

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Fri, 29 Jan 2010 17:12:24 -0600
Subject: omap mailbox: fix sleep-inside-spinlock at startup

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Originally Fernando Guzman Lugo has found and pointed out this probelm.

"mboxes_lock" is not related "->ops->startup()" and "->ops->startup()"
is sleep'able which cannot be used with spin lock held. So a new mutex
lock is introduced.

Reported-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---


diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 8e90633..19530de 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -32,6 +32,7 @@ static struct omap_mbox *mboxes;
 static DEFINE_RWLOCK(mboxes_lock);
 
 static int mbox_configured;
+static DEFINE_MUTEX(mbox_configured_lock);
 
 /* Mailbox FIFO handle functions */
 static inline mbox_msg_t mbox_fifo_read(struct omap_mbox *mbox)
@@ -247,16 +248,16 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	struct omap_mbox_queue *mq;
 
 	if (likely(mbox->ops->startup)) {
-		write_lock(&mboxes_lock);
+		mutex_lock(&mbox_configured_lock);
 		if (!mbox_configured)
 			ret = mbox->ops->startup(mbox);
 
 		if (unlikely(ret)) {
-			write_unlock(&mboxes_lock);
+			mutex_unlock(&mbox_configured_lock);
 			return ret;
 		}
 		mbox_configured++;
-		write_unlock(&mboxes_lock);
+		mutex_unlock(&mbox_configured_lock);
 	}
 
 	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
@@ -302,11 +303,11 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 	free_irq(mbox->irq, mbox);
 
 	if (unlikely(mbox->ops->shutdown)) {
-		write_lock(&mboxes_lock);
+		mutex_lock(&mbox_configured_lock);
 		if (mbox_configured > 0)
 			mbox_configured--;
 		if (!mbox_configured)
 			mbox->ops->shutdown(mbox);
-		write_unlock(&mboxes_lock);
+		mutex_unlock(&mbox_configured_lock);
 	}
 }

----Next_Part(Thu_Feb_18_09_16_01_2010_454)----
