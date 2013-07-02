From: Torben Hohn <torbenh@linutronix.de>
Subject: RT and omap-gpio irqchip with DeviceTree
Date: Tue, 2 Jul 2013 13:44:53 +0200
Message-ID: <20130702114452.GA13763@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60024 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab3GBLoy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jul 2013 07:44:54 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tglx@linutronix.de
Cc: bigeasy@linutronix.de, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi..

I am running into Problems with a network adapter IRQ connected to an
omap-gpio pin.

omap-gpio expects gpio-request() to be called before i can use the pin.
But this is abstracted via the DeviceTree bindings.

I see 8d4c277e185c31359cf70573d8b0351fb7dd0dfe in mainline.
This one just puts a warning into the exact place, i am dealing with.
But i need to make this work, instead of bailing out.

I have this fix in place, instead:
---------------------------------------------------------------------------=
------------
commit 4ca17be8e7e24863cb98f440992fd89034aa34f5
Author: Torben Hohn <torbenh@linutronix.de>
Date:   Fri Jun 21 17:34:24 2013 +0200

    gpio omap: Fix for DT calling into gpio_irq_type without request_gpio()
   =20
    gpio_irq_type() requires that the GPIO is requested, do that.

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f1fbedb2..57d956c 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -87,6 +87,8 @@ struct gpio_bank {
 #define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
 #define GPIO_MOD_CTRL_BIT      BIT(0)
=20
+static int omap_gpio_request(struct gpio_chip *chip, unsigned offset);
+
 static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
 {
        return gpio_irq - bank->irq_base + bank->chip.base;
@@ -429,6 +431,9 @@ static int gpio_irq_type(struct irq_data *d, unsigned t=
ype)
        if (!gpio)
                gpio =3D irq_to_gpio(bank, d->irq);
=20
+       if (!bank->mod_usage)
+               omap_gpio_request( &bank->chip, gpio );
+
        if (type & ~IRQ_TYPE_SENSE_MASK)
                return -EINVAL;
=20

---------------------------------------------------------------------------=
--------------


But now with RT i am running into a Problem, because gpio_irq_type() is cal=
led=20
under a raw_spinlock() But its calling pm_runtime_suspend() which carries a=
 normal spinlock.


---------------------------------------------------------------------------=
--------------
/**
 *      irq_set_type - set the irq trigger type for an irq
 *      @irq:   irq number
 *      @type:  IRQ_TYPE_{LEVEL,EDGE}_* value - see include/linux/irq.h
 */    =20
int irq_set_irq_type(unsigned int irq, unsigned int type)
{
        unsigned long flags;
        struct irq_desc *desc =3D irq_get_desc_buslock(irq, &flags, IRQ_GET=
_DESC_CHECK_GLOBAL);
        int ret =3D 0;
       =20
        if (!desc)
                return -EINVAL;
       =20
        type &=3D IRQ_TYPE_SENSE_MASK;
        ret =3D __irq_set_trigger(desc, irq, type);
        irq_put_desc_busunlock(desc, flags);
        return ret;
}
---------------------------------------------------------------------------=
--------------

I think, i need a normal hook in the irq_chip, which "prepares" the irq, bu=
t i dont see one.


--=20
Mit freundlichen Gr=FC=DFen
Torben Hohn

Linutronix GmbH

Standort: Bremen

Phone: +49 421 5650 2310 ; Fax.: +49 7556 919 886
mailto: torbenh@linutronix.de
Firmensitz / Registered Office: D-88690 Uhldingen, Auf dem Berg 3
Registergericht / Local District Court: Freiburg i. Br., HRB Nr. / Trade
register no.: 700 806;

Gesch=E4ftsf=FChrer / Managing Directors: Heinz Egger, Thomas Gleixner

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJR0r00AAoJEESSOlgt2wc7lBAIAI+pNvlDs9qSlf7F8KHDYoxd
oGVe8ETpfVnqNq5l18y8qVHgPm/YZ1TG1U1NNrpiwzo8sIDsOHSs62PADfaIUNp9
fGqL+vtPY9vSLkct1rSqWISpZdEHyDDK/r+4nI0xx+/Qz++FP6eR3Mn1UFBfF86Q
u/ekdtSbIdHxIeNZsFfRYl6oiZMaw/lwyR7LyEUeiMBrdKJzKM+KAH5CnUPOX2hJ
Bv5nM4jf5aVIinsnkCFgmowUQAOEHEG/qE0fCgKAiB8Qq3zJdBxjct/hK3mySQNO
QgG32eUjuUr911ENmQvl/D4vYBp1BsyfRA1+r2p9n5BWCsINp/oJeDtXHQND9zg=
=1QUR
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
