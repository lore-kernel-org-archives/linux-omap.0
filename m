From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 3/3] dma: cppi41: move -EAGAIN in tear_down
Date: Wed, 2 Oct 2013 10:29:14 +0200
Message-ID: <20131002082914.GA16680@linutronix.de>
References: <1380634271-27588-1-git-send-email-zonque@gmail.com>
 <1380634271-27588-4-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380634271-27588-4-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Daniel Mack | 2013-10-01 15:31:11 [+0200]:

>In cppi41_tear_down_chan(), bail out earlier in case td_seen is unset
>instead of popping another descriptor when td_desc_seen is also unset.
>
>My system ran into WARN() condition multiple times when
>cppi41_tear_down_chan() was called for channels that had all of
>td_queued, td_seen and td_seen set to false.

Which one?

>Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>---
> drivers/dma/cppi41.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
>index 7747bf7..6decf34 100644
>--- a/drivers/dma/cppi41.c
>+++ b/drivers/dma/cppi41.c
>@@ -586,6 +586,9 @@ static int cppi41_tear_down_chan(struct cppi41_channel *c)
> 			}
> 			c->td_seen = 1;
> 		}
>+
>+		if (c->td_retry)
>+			return -EAGAIN;

So you return right away since the retry counter should be > 0 here. And
then you want to get the TDDOWN bit set and retry. Hmmm.
Let me answer to you 0/3 on this.

> 	}
> 	if (!c->td_desc_seen) {
> 		desc_phys = cppi41_pop_desc(cdd, c->q_comp_num);
>@@ -606,8 +609,6 @@ static int cppi41_tear_down_chan(struct cppi41_channel *c)
> 	 * descriptor before the TD we fetch it from enqueue, it has to be
> 	 * there waiting for us.
> 	 */
>-	if (!c->td_seen && c->td_retry)
>-		return -EAGAIN;
> 
> 	WARN_ON(!c->td_retry);
> 	if (!c->td_desc_seen) {

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
