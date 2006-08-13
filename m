From: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@solidboot.com>
Subject: Re: Suspending with keypad bug (RFC)
Date: Sun, 13 Aug 2006 12:36:41 +0300
Message-ID: <20060813093641.GA20466@mail.solidboot.com>
References: <fb249edb0608041633y58eef1b8we6f00cccf69c99a0@mail.gmail.com>
	<44D6423F.3070001@solidboot.com>
	<fb249edb0608092155r20c17f5dl6397c3d9d191105b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0608092155r20c17f5dl6397c3d9d191105b@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Aug 10, 2006 at 06:55:26AM +0200, andrzej zaborowski wrote:

> Thanks for help! I'm attaching the corrected version, it works nicely.

+       unsigned long flags;
+       spin_lock_irqsave(&omap_kp->suspend_lock, flags);
+
+       if (omap_kp->suspended)
+               return IRQ_HANDLED;
+
+       spin_unlock_irqrestore(&omap_kp->suspend_lock, flags);

Here you are returning with the lock held and IRQs disabled.  It should be
like this:

       spin_lock_irqsave(&omap_kp->suspend_lock, flags);
       if (omap_kp->suspended) {
               spin_unlock_irqrestore(&omap_kp->suspend_lock, flags);
               return IRQ_HANDLED;
       }
       spin_unlock_irqrestore(&omap_kp->suspend_lock, flags);

Cheers,
Juha
