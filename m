From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH resend] omap: rx51: Add SI4713 FM transmitter
Date: Mon, 21 Feb 2011 09:54:21 +0200
Message-ID: <20110221095421.6576a98d.jhnikula@gmail.com>
References: <1298040354-1726-1-git-send-email-jhnikula@gmail.com>
	<1298270556-11571-1-git-send-email-jhnikula@gmail.com>
	<AANLkTikR5v9_G3oyRjVP1oCcBo=hU+ikywximd=VDbDd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f43.google.com ([209.85.215.43]:52759 "EHLO
	mail-ew0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062Ab1BUHxh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 02:53:37 -0500
Received: by ewy22 with SMTP id 22so523194ewy.2
        for <linux-omap@vger.kernel.org>; Sun, 20 Feb 2011 23:53:35 -0800 (PST)
In-Reply-To: <AANLkTikR5v9_G3oyRjVP1oCcBo=hU+ikywximd=VDbDd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org

On Mon, 21 Feb 2011 13:10:59 +0530
"Varadarajan, Charulatha" <charu@ti.com> wrote:

> > + =A0 =A0 =A0 err =3D gpio_request_one(RX51_FMTX_IRQ, GPIOF_DIR_IN,=
 "si4713 irq");
> > + =A0 =A0 =A0 if (err) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Cannot request si471=
3 irq gpio. %d\n", err);
>=20
> use pr_err instead of printk.
>=20
Thanks, I was obviously blind, will send an update :-)

--=20
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
