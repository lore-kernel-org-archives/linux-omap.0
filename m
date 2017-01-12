From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] dmaengine: cppi41: Fix oops in cppi41_runtime_resume
Date: Thu, 12 Jan 2017 17:42:28 -0600
Message-ID: <aafe7afb-6d8a-2fef-acdd-bd331151d16a@ti.com>
References: <20170112213016.19367-1-tony@atomide.com>
 <927792da-2e90-b2ae-1206-8fcb504d7551@ti.com>
 <20170112221933.GM2630@atomide.com>
 <1c8967b7-d59b-e53d-feeb-80c71464fb94@ti.com>
 <20170112230456.GS2630@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170112230456.GS2630-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On 01/12/2017 05:04 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [170112 14:53]:
>>
>>
>> On 01/12/2017 04:19 PM, Tony Lindgren wrote:
>>> * Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [170112 13:54]:
>>>> On 01/12/2017 03:30 PM, Tony Lindgren wrote:
>>>>
>>>> Sry, but even if it looks better it might still race with PM runtime :(
>>>>
>>>>> -	if (likely(pm_runtime_active(cdd->ddev.dev)))
>>>>> +	if (likely(atomic_read(&cdd->active)))
>>>>>  		push_desc_queue(c);
>>>>>  	else
>>>>
>>>>
>>>> - CPU is here (-EINPROGRESS and active == 0) and then preempted 
>>>> - PM runtime will finish cppi41_runtime_resume and clean-up pending descs
>>>> - CPU return here and adds desc to the pending queue
>>>> - oops
>>>>
>>>> Am I wrong?
>>>
>>> We had cppi41_dma_issue_pending() getting called from atomic contex and
>>> cppi41_runtime_resume() getting preempted where cppi41_dma_issue_pending()
>>> would add to the queue.
>>
>> Again, I can be mistaken but cppi41_configure_channel() seems not atomic.
>> cppi41_configure_channel()->dma_async_issue_pending()
>> + documentation says "This function can be called in an interrupt context"
>>
>> And definitely it will be preemptive on RT :(
> 
> Hmm OK. So are you thinking we should add a spinlock around the
> test in cppi41_dma_issue_pending() and when modifying cdd->active?

in general yes.

> 
> Something like:
> 
> spin_lock_irqsave(&cdd->lock, flags);
> if (likely(cdd->active))
> 	push_desc_queue(c);
> else
> 	list_add_tail(&c->node, &cdd->pending);
> spin_unlock_irqrestore(&cdd->lock, flags);
> 
> Or do you have something better in mind?

I've come up with smth like below. *Not tested*
But may be it can be done more simpler.

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index d5ba43a..41a8768 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -153,6 +153,7 @@ struct cppi41_dd {
 
        /* context for suspend/resume */
        unsigned int dma_tdfdq;
+       int is_suspended;
 };
 
 #define FIST_COMPLETION_QUEUE  93
@@ -317,12 +318,6 @@ static irqreturn_t cppi41_irq(int irq, void *data)
 
                while (val) {
                        u32 desc, len;
-                       int error;
-
-                       error = pm_runtime_get(cdd->ddev.dev);
-                       if (error < 0)
-                               dev_err(cdd->ddev.dev, "%s pm runtime get: %i\n",
-                                       __func__, error);
 
                        q_num = __fls(val);
                        val &= ~(1 << q_num);
@@ -343,9 +338,6 @@ static irqreturn_t cppi41_irq(int irq, void *data)
                        c->residue = pd_trans_len(c->desc->pd6) - len;
                        dma_cookie_complete(&c->txd);
                        dmaengine_desc_get_callback_invoke(&c->txd, NULL);
-
-                       pm_runtime_mark_last_busy(cdd->ddev.dev);
-                       pm_runtime_put_autosuspend(cdd->ddev.dev);
                }
        }
        return IRQ_HANDLED;
@@ -457,38 +449,36 @@ static void push_desc_queue(struct cppi41_channel *c)
        cppi_writel(reg, cdd->qmgr_mem + QMGR_QUEUE_D(c->q_num));
 }
 
-static void pending_desc(struct cppi41_channel *c)
+static void cppi41_dma_issue_pending(struct dma_chan *chan)
 {
+       struct cppi41_channel *c = to_cpp41_chan(chan);
        struct cppi41_dd *cdd = c->cdd;
+       int error;
+       struct cppi41_channel *_c;
        unsigned long flags;
 
        spin_lock_irqsave(&cdd->lock, flags);
        list_add_tail(&c->node, &cdd->pending);
-       spin_unlock_irqrestore(&cdd->lock, flags);
-}
-
-static void cppi41_dma_issue_pending(struct dma_chan *chan)
-{
-       struct cppi41_channel *c = to_cpp41_chan(chan);
-       struct cppi41_dd *cdd = c->cdd;
-       int error;
 
        error = pm_runtime_get(cdd->ddev.dev);
-       if ((error != -EINPROGRESS) && error < 0) {
+       if (error < 0) {
                pm_runtime_put_noidle(cdd->ddev.dev);
                dev_err(cdd->ddev.dev, "Failed to pm_runtime_get: %i\n",
                        error);
-
+               spin_unlock_irqrestore(&cdd->lock, flags);
                return;
        }
 
-       if (likely(pm_runtime_active(cdd->ddev.dev)))
-               push_desc_queue(c);
-       else
-               pending_desc(c);
+       if (!cdd->is_suspended) {
+               list_for_each_entry_safe(c, _c, &cdd->pending, node) {
+                       push_desc_queue(c);
+                       list_del(&c->node);
+               };
+       }
 
        pm_runtime_mark_last_busy(cdd->ddev.dev);
        pm_runtime_put_autosuspend(cdd->ddev.dev);
+       spin_lock_irqsave(&cdd->lock, flags);
 }
 
 static u32 get_host_pd0(u32 length)
@@ -1150,10 +1140,20 @@ static int __maybe_unused cppi41_resume(struct device *dev)
 static int __maybe_unused cppi41_runtime_suspend(struct device *dev)
 {
        struct cppi41_dd *cdd = dev_get_drvdata(dev);
+       int ret;
+       unsigned long flags;
 
-       WARN_ON(!list_empty(&cdd->pending));
+       spin_lock_irqsave(&cdd->lock, flags);
+       if (!list_empty(&cdd->pending)) {
+               WARN_ON(!list_empty(&cdd->pending));
+               ret = -EBUSY;
+       } else {
+               /* ... suspend the device ... */
+               cdd->is_suspended = 1;
+       }
+       spin_unlock_irqrestore(&cdd->lock, flags);
 
-       return 0;
+       return ret;
 }
 
 static int __maybe_unused cppi41_runtime_resume(struct device *dev)
@@ -1163,6 +1163,8 @@ static int __maybe_unused cppi41_runtime_resume(struct device *dev)
        unsigned long flags;
 
        spin_lock_irqsave(&cdd->lock, flags);
+       cdd->is_suspended = 0;
+
        list_for_each_entry_safe(c, _c, &cdd->pending, node) {
                push_desc_queue(c);
                list_del(&c->node);


-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
