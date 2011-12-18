From: "Palande, Ameya" <ameya.palande@ti.com>
Subject: Re: [PATCH] davinci-cpdma: fix locking issue in cpdma_chan_stop
Date: Sun, 18 Dec 2011 15:45:50 -0800
Message-ID: <CAHFNHeUK3exXwrcjA8f6qWyasbCv_SPdJKco45jVBe7uBtuM3g@mail.gmail.com>
References: <1324238524-21330-1-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:42531 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751991Ab1LRXpv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 18 Dec 2011 18:45:51 -0500
In-Reply-To: <1324238524-21330-1-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org

Tested-by: Ameya Palande <2ameya@gmail.com>

On Sun, Dec 18, 2011 at 12:02 PM, Ilya Yanok <yanok@emcraft.com> wrote:
> Free the channel lock before calling __cpdma_chan_process to prevent
> dead lock.
>
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
> =A0drivers/net/ethernet/ti/davinci_cpdma.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/et=
hernet/ti/davinci_cpdma.c
> index dca9d33..c97d2f5 100644
> --- a/drivers/net/ethernet/ti/davinci_cpdma.c
> +++ b/drivers/net/ethernet/ti/davinci_cpdma.c
> @@ -836,11 +836,13 @@ int cpdma_chan_stop(struct cpdma_chan *chan)
> =A0 =A0 =A0 =A0chan_write(chan, cp, CPDMA_TEARDOWN_VALUE);
>
> =A0 =A0 =A0 =A0/* handle completed packets */
> + =A0 =A0 =A0 spin_unlock_irqrestore(&chan->lock, flags);
> =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D __cpdma_chan_process(chan);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0} while ((ret & CPDMA_DESC_TD_COMPLETE) =3D=3D 0);
> + =A0 =A0 =A0 spin_lock_irqsave(&chan->lock, flags);
>
> =A0 =A0 =A0 =A0/* remaining packets haven't been tx/rx'ed, clean them=
 up */
> =A0 =A0 =A0 =A0while (chan->head) {
> --
> 1.7.6.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
