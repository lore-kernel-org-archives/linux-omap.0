From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH -pm 1/2] SDRC: check for stuck DLL state machine and kick
Date: Thu, 18 Jun 2009 13:55:18 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038E2ACBC9@dlee02.ent.ti.com>
References: <1245105775-28844-1-git-send-email-khilman@deeprootsystems.com>
	 <1245105775-28844-2-git-send-email-khilman@deeprootsystems.com>
 <8bb80c380906181142m54f543c2v626849983f4507b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46036 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbZFRSz3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 14:55:29 -0400
In-Reply-To: <8bb80c380906181142m54f543c2v626849983f4507b4@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mike Chan <mikechan@google.com>

Mike,

>From: Mike Chan [mailto:mike@android.com]
>Sent: Thursday, June 18, 2009 1:42 PM
>
>
>+        /* Kick DLL state machine if lock not started */
>+kick_dll:
>+       ldr     r4, sdrc_dlla_ctrl      /* get dlla addr */
>+       ldr     r5, [r4]                /* grab value */
>+       mov     r6, r5                  /* save value */
>
>Richard, could this be done in one instruction, eliminating the need for the r5 >temporary register? Or was this done intentionally?

Its on purpose I suppose, perhaps there is an optimization.

Above I want to make sure I restore the value I came in with for dlla_ctrl.  I save off value in r5 for this.

Below I clear and set dllidle bit.  I don't take the time to figure out if it was set or not coming into function.  I saved off value in r5 to allow for this.  It is legal for it to be set or cleared in normal operation.

The below set/clear needs to happen as 2 writes.  The 3rd write is a restore.  You could be mindful of input value and perhaps not do a 3rd write but my guess is that will take more code then it saves.

>+       orr     r6, r6, #0x10           /* dllidle on */
>+       str     r6, [r4]
>+       dsb
>+       bic     r6, #0x10               /* dllidle off */
>+       str     r6, [r4]
>+       dsb
>+       str     r6, [r4]                /* restore old value */
>+       b wait_dll_lock_timed
>+

Regards,
Richard W.
