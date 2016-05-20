From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [OOPS] cppi41_dma_channel_program: Unable to handle kernel NULL
 pointer dereference
Date: Fri, 20 May 2016 15:10:19 -0500
Message-ID: <20160520201019.GA3432@uda0271908>
References: <1463750386-6259-1-git-send-email-matwey@sai.msu.ru>
 <CAJs94EZjWi0KGn_siyXNGvjO2DTh2aXtYqKzy7Km7mA_bYTeKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJs94EZjWi0KGn_siyXNGvjO2DTh2aXtYqKzy7Km7mA_bYTeKg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Matwey V. Kornilov" <matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org>
Cc: Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, May 20, 2016 at 04:32:06PM +0300, Matwey V. Kornilov wrote:
> 2016-05-20 16:19 GMT+03:00  <matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org>:
> > Hello,
> >
> > I am running 4.6-rc3 on BealgeBone Black and when I try to interract
> > with pwc webcam attached to usb port the following kernel panic
> > happening.
> 
> Please note, that the same is happening with 4.6.0 release.

Please apply the following patch and reproduce the oops, I'd like to
check if the oops is caused by NULL of hw_ep->in_qh.

Regards,
-Bin.

---8<-------
diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index e499b86..3492c6e 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -489,8 +489,11 @@ static int cppi41_dma_channel_program(struct dma_channel *channel,
        if (is_host_active(cppi41_channel->controller->musb)) {
                if (cppi41_channel->is_tx)
                        hb_mult = cppi41_channel->hw_ep->out_qh->hb_mult;
-               else
+               else {
+                       if (!cppi41_channel->hw_ep->in_qh)
+                               dev_err(NULL, "->in_qh is NULL\n");
                        hb_mult = cppi41_channel->hw_ep->in_qh->hb_mult;
+               }
        }
 
        channel->status = MUSB_DMA_STATUS_BUSY;
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
