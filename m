From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Question about patch "i2c: omap: resize fifos before each message"
Date: Wed, 3 Dec 2014 18:11:18 +0300
Message-ID: <A20987D6-DEEC-488D-9655-36A4D186599B@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Felipe,

Question about the patch[1].

I want to change the code in a way to not touch fifo thresholds for each message.
Because:
1. dev->threshold is valid only with checking of transfer direction.
   So, if last transfer was transmission and ISR get RRDY interrupt from slave receiver,
   then dev->threshold is invalid. We must read threshold value from BUF register, to
   process correctly.
2. I want to avoid changing fifos before message submission, because IP can start receiving
   message in a slave mode (race).
3. dev->threshold is changed in range 1-fifo_size/2. So instead of RDR we get RRDY and
   for messages larger then fifo_size/2 we still get RRDY and RDR.

Felipe, do you have in mind why do you want to avoid RDR and XDR events?
Something about errata?

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/i2c/busses/i2c-omap.c?id=dd74548ddece4b9d68e5528287a272fa552c81d0
