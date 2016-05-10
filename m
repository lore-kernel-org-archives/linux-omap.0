From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 1/5] usb: dwc3: omap: use request_threaded_irq()
Date: Tue, 10 May 2016 13:12:43 +0300
Message-ID: <87y47igr1g.fsf@linux.intel.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com> <1462873919-20532-2-git-send-email-rogerq@ti.com> <87a8jyi6ad.fsf@linux.intel.com> <5731B235.80505@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5731B235.80505@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>>> @@ -497,8 +503,8 @@ static int dwc3_omap_probe(struct platform_device *=
pdev)
>>>  	/* check the DMA Status */
>>>  	reg =3D dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
>>>=20=20
>>> -	ret =3D devm_request_irq(dev, omap->irq, dwc3_omap_interrupt, 0,
>>> -			"dwc3-omap", omap);
>>> +	ret =3D devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
>>> +					NULL, 0, "dwc3-omap", omap);
>>=20
>> if you're using threaded_irq, it's better to have a NULL top half and
>> valid bottom half.
>
> But in this case we don't need a bottom half as there is nothing to do :).
>
>>=20
>> In fact, since this will be shared, you could do a proper preparation
>> and on top half check if $this device generated the IRQ and
>> conditionally schedule the bottom half. Don't forget to mask device's
>> interrupts from top half so you can run without IRQF_ONESHOT.
>>=20
>
> Why do this at all if there is nothing to do in the bottom half?

oh, but there is :-)

The whole idea of threaded IRQs is that you spend as little time as
possible on top half and the (strong) recommendation is that you *only*
check if $this device generated the interrupt. Note that "checking if
$this device generated the interrupt" will be mandatory as soon as you
mark the IRQ line as shared ;-)

So here's how this should look like:

static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
{
        struct dwc3_omap *omap =3D _omap;
        u32 reg;

        reg =3D readl(IRQSTATUS)
        if (reg) {
                mask_interrupts(omap);
        	return IRQ_WAKE_THREAD;
        }

	return IRQ_HANDLED;
}

static irqreturn_t dwc3_omap_threaded_interrupt(int irq, void *_omap)
{
        struct dwc3_omap *omap =3D _omap;
        u32 reg;

        spin_lock(&omap->lock);
        reg =3D readl(IRQSTATUS);

        if (reg & BIT0)
        	handle_bit_0(omap);

	if (reg & BIT1)
        	handle_bit_1(omap);

	unmask_interrupts(omap);
	spin_unlock(&omap->lock);

	return IRQ_HANDLED;
}

this will *always* behave well with RT and non-RT kernels. It also
allows for the user to change priorities on these interrupt handlers if
necessary.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMbQbAAoJEIaOsuA1yqREilgQAIS5BWe3/C5ozbIMFTJPRv9w
SrzN2OfeWiep7itj0iFwGB8qSXvxuNfhNUKS3w1UMhurroNTgFJT5QsiIX0y42U8
Ce+NDSvDwUaX9K8BXBNbMwTHLXGm1dCv+z6aa/T1/NJ8Eb3n9LGgGfRjgo9XCMvV
/vAixNXQvr9rdrkmrajSjfoQ9XMTJhUIILz22iFlp8o07ar5s+wj3iMb+1qik6Hg
3azB36ylDDLIfxLfrGGfwrUkwaFB1dzhLoScS8CF7Cpp2WS7b/qCe7hurYBu4wXv
n3cIL74CToy3XwJA0dJN8/MFcwm8wZoRFQnyexVAhm000jmxsz0h/bKEcaWwzDoe
dqE4XGP9u+/eOMTG8Ooi9t9aI8Bh0N7TY3gmlMDkD0O9VDvPKWSPlG0x5nJhJazt
dNvGZTcF7v+gItBnEncwUFG211d4LGeY4tIXqktxFbBZ7lNwUMpAwWs/WSNjBBnT
y5e7NhJEihpPLK6HL03p1K0SDOEPgTm2B0doYYZ921KK8/kDnxnTcfrnxq/ZBG/M
oV+PnTclzTxIYutngwCw8vXDJd0QjpRFQGVqQJuqTgPl8iKFjowG7Xb7jRGWzUz5
+vtuV/kDJ0UWfPv6nSlg13cQ+aDY4+aj6c/SIcot45EM87m0hlaZdOEzSSOsEVuv
NCvW3tyXGiIJyg/b5zZu
=V8TL
-----END PGP SIGNATURE-----
--=-=-=--
