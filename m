From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Git tree updated to 2.6.19-rc2
Date: Tue, 24 Oct 2006 18:16:53 +0200
Message-ID: <453E3C75.6060605@gmail.com>
References: <20061023203925.GC11967@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090702020801010907070805"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061023203925.GC11967@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------090702020801010907070805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tony Lindgren wrote:
> - CONFIG_DEBUG_LL hangs system

For reference see

http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008025.html

and

http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008054.html

for an ugly workaround if you really need it. I really have
no clue what is broken here.

> - BUG in omap1_mbox_enable_irq

I think you mean

Unbalanced enable for IRQ 10
BUG: warning at kernel/irq/manage.c:118/enable_irq()

printed in bootmessages.

I spent some minutes for this as well. It is MPU "dsp"
interrupt which is enabled in omap1_mbox_enable_irq() by

enable_irq(mbox->irq);

In kernel/irq/manage.c function enable_irq() checks for
desc->depth and if it is 0 it prints above message. Seems
that desc->depth has to be >= 1.

The comment tells us

*	Undoes the effect of one call to disable_irq().  If this
*	matches the last disable, processing of interrupts on this
*	IRQ line is re-enabled.

so seems that before calling enable_irq() at least one
disable_irq() is needed.

I don't know if patch in attachment is a valid patch or only
a workaround. What do you think?

Best regards

Dirk


--------------090702020801010907070805
Content-Type: text/plain;
 name="mailbox_irq_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mailbox_irq_patch.txt"

--- arch/arm/plat-omap/mailbox.c_orig	2006-10-24 18:08:06.000000000 +0200
+++ arch/arm/plat-omap/mailbox.c	2006-10-24 18:10:58.000000000 +0200
@@ -237,6 +237,7 @@ static int omap_mbox_init(struct omap_mb
 		       "failed to register mailbox interrupt:%d\n", ret);
 		goto fail1;
 	}
+	disable_mbox_irq(mbox, IRQ_RX);
 	enable_mbox_irq(mbox, IRQ_RX);
 
 	spin_lock_init(&mbox->lock);


--------------090702020801010907070805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090702020801010907070805--
