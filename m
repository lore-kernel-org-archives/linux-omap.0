From: Dave Hylands <dhylands@gmail.com>
Subject: Re: SDHC card affected by preemption model in 2.6.35
Date: Mon, 21 Feb 2011 18:43:46 -0700
Message-ID: <AANLkTi=UMbOYFORyTvicCvAMEd=dig7xaROMLdkcfhGW@mail.gmail.com>
References: <4D62523D.5080203@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47773 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab1BVBnr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 20:43:47 -0500
Received: by iwn34 with SMTP id 34so78584iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 17:43:47 -0800 (PST)
In-Reply-To: <4D62523D.5080203@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Johannes Reif <reif@corscience.de>
Cc: "S, Venkatraman" <svenkatr@ti.com>, Mathieu Poirier <mathieu.poirier@canonical.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi guys,

On Mon, Feb 21, 2011 at 4:53 AM, Johannes Reif <reif@corscience.de> wro=
te:
> Hello Venkat, Hello Mathieu,
>
>> =A0No. I was working on some other things lately. What card are you =
using
>> and
>> =A0how often are you seeing this ?
>>
>> =A0Regards,
>> =A0Venkat.
>
> We get the timeout Problem every time:
> [ =A0 =A01.888732] Waiting for root device /dev/mmcblk0p2...
> [ =A0 =A04.193603] mmc0: error -110 whilst initialising SD card
>
> Right now the issue occurs with following cards CONFIG_PREEMPT=3Dy en=
abled:

There is a bug in the kernel workqueues. I observed it in 2.6.36.3 (it
seems to have been introduced in 2.6.36 and is still in 2.6.37.1), One
of my colleagues was investigating and contacted the author of the
workqueue code (Tejun Heo). Tejun sent us the following patch:

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 11869fa..90a17ca 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2047,6 +2047,15 @@ repeat:
 				move_linked_works(work, scheduled, &n);

 		process_scheduled_works(rescuer);
+
+		/*
+		 * Leave this gcwq.  If keep_working() is %true, notify a
+		 * regular worker; otherwise, we end up with 0 concurrency
+		 * and stalling the execution.
+		 */
+		if (keep_working(gcwq))
+			wake_up_worker(gcwq);
+
 		spin_unlock_irq(&gcwq->lock);
 	}


=46or us, this was causing card insertion events to not be processed.
=46or us it was a race condition and depended on when the timer tick
occured in relation to other processing, and since you're talking
about PREEMPTION making a difference, I thought I would throw this out
as maybe being relevant.

Dave Hylands
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
