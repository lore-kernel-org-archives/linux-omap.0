From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v4 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
Date: Wed, 24 Nov 2010 10:46:04 +0530
Message-ID: <AANLkTimNW8ixBPyuwckZYnijXmT+t-XSY37xMUVvubLB@mail.gmail.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com> <1290547617-16640-3-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:49267 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751451Ab0KXFQp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 00:16:45 -0500
Received: by mail-iw0-f174.google.com with SMTP id 33so1048711iwn.5
        for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 21:16:45 -0800 (PST)
In-Reply-To: <1290547617-16640-3-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

On Wed, Nov 24, 2010 at 02:56, Hari Kanigeri <h-kanigeri2@ti.com> wrote=
:

Should the subject be like this?
OMAP4: mailbox: fix rx interrupt disable

> disablign rx interrupt on omap4 is different than its pre-decessors.

Typo ->disablign

> The bit in OMAP4_MAILBOX_IRQENABLE_CLR should be set to disable the
> interrupts instead of clearing the bit.
>
> Defined rev field in mailbox structure to differentiate the mailbox
> versions.
>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
> =A0arch/arm/mach-omap2/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A07 +=
+++++-
> =A0arch/arm/plat-omap/include/plat/mailbox.h | =A0 =A04 ++++
> =A0arch/arm/plat-omap/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04=
 ++++
> =A03 files changed, 14 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mail=
box.c
> index 42dbfa4..c32058d 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -195,7 +195,12 @@ static void omap2_mbox_disable_irq(struct omap_m=
box *mbox,
> =A0 =A0 =A0 =A0struct omap_mbox2_priv *p =3D (struct omap_mbox2_priv =
*)mbox->priv;
> =A0 =A0 =A0 =A0u32 l, bit =3D (irq =3D=3D IRQ_TX) ? p->notfull_bit : =
p->newmsg_bit;
> =A0 =A0 =A0 =A0l =3D mbox_read_reg(p->irqdisable);
> - =A0 =A0 =A0 l &=3D ~bit;
> +
> + =A0 =A0 =A0 if (mbox->rev =3D=3D OMAP_MBOX_IP_VERSION_2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l |=3D bit;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~bit;
> +
> =A0 =A0 =A0 =A0mbox_write_reg(l, p->irqdisable);
> =A0}
>
> diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/pla=
t-omap/include/plat/mailbox.h
> index 13f2ef3..1655c61 100644
> --- a/arch/arm/plat-omap/include/plat/mailbox.h
> +++ b/arch/arm/plat-omap/include/plat/mailbox.h
> @@ -20,6 +20,9 @@ typedef int __bitwise omap_mbox_type_t;
> =A0#define OMAP_MBOX_TYPE1 ((__force omap_mbox_type_t) 1)
> =A0#define OMAP_MBOX_TYPE2 ((__force omap_mbox_type_t) 2)
>
> +#define OMAP_MBOX_IP_LEGACY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
x1
> +#define OMAP_MBOX_IP_VERSION_2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2
> +
> =A0struct omap_mbox_ops {
> =A0 =A0 =A0 =A0omap_mbox_type_t =A0 =A0 =A0 =A0type;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 (*startup)(struct omap_mbo=
x *mbox);
> @@ -58,6 +61,7 @@ struct omap_mbox {
> =A0 =A0 =A0 =A0struct omap_mbox_ops =A0 =A0*ops;
> =A0 =A0 =A0 =A0struct device =A0 =A0 =A0 =A0 =A0 *dev;
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*priv;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rev;
> =A0};
>
> =A0int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbo=
x.c
> index 48e161c..a1c6bd9 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -358,6 +358,10 @@ int omap_mbox_register(struct device *parent, st=
ruct omap_mbox **list)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D PTR_ERR(mbox->=
dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx())

Do not use cpu_is* checks in plat-omap/*

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox->rev =3D OMAP_MBOX=
_IP_VERSION_2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox->rev =3D OMAP_MBOX=
_IP_LEGACY;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 0;
>
> --
> 1.7.0
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
