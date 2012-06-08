From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [CFT 01/11] dmaengine: add OMAP DMA engine driver
Date: Fri, 8 Jun 2012 15:30:23 +0530
Message-ID: <CAMQu2gzGp=eznnXweX=ZN03cxVbbhbHconowigk964ojx99mJQ@mail.gmail.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScaXw-0003tR-U8@rmk-PC.arm.linux.org.uk> <20120608090200.GA15831@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:37321 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750991Ab2FHKAp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jun 2012 06:00:45 -0400
Received: by qcsd16 with SMTP id d16so889304qcs.0
        for <linux-omap@vger.kernel.org>; Fri, 08 Jun 2012 03:00:43 -0700 (PDT)
In-Reply-To: <20120608090200.GA15831@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

On Fri, Jun 8, 2012 at 2:32 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jun 07, 2012 at 12:06:32PM +0100, Russell King wrote:
>> Tested-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> ---
>> =A0drivers/dma/Kconfig =A0 =A0 =A0| =A0 =A06 +
>> =A0drivers/dma/Makefile =A0 =A0 | =A0 =A01 +
>> =A0drivers/dma/omap-dma.c =A0 | =A0522 +++++++++++++++++++++++++++++=
+++++++++++++++++
>> =A0include/linux/omap-dma.h | =A0 24 ++
>> =A04 files changed, 553 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/dma/omap-dma.c
>> =A0create mode 100644 include/linux/omap-dma.h
>
> There is a bug in here which no one has spotted... I just noticed it.
>
> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index 500bc71..02eb2fd 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -130,14 +130,13 @@ static void omap_dma_callback(int ch, u16 statu=
s, void *data)
>
> =A0 =A0 =A0 =A0spin_lock_irqsave(&c->vc.lock, flags);
> =A0 =A0 =A0 =A0d =3D c->desc;
> - =A0 =A0 =A0 if (!d)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> - =A0 =A0 =A0 if (++c->sgidx < d->sglen) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_start_sg(c, d, c->sgidx);
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_start_desc(c);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vchan_cookie_complete(&d->vd);
> + =A0 =A0 =A0 if (d) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (++c->sgidx < d->sglen) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_start_sg(c, d,=
 c->sgidx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_start_desc(c);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vchan_cookie_complete(&=
d->vd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&c->vc.lock, flags);
> =A0}
>
You mean the lock release, right ?

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
