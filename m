From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 1/5] usb: dwc3: omap: use request_threaded_irq()
Date: Wed, 11 May 2016 12:47:37 +0300
Message-ID: <87y47hexja.fsf@linux.intel.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com> <1462873919-20532-2-git-send-email-rogerq@ti.com> <87a8jyi6ad.fsf@linux.intel.com> <5731B235.80505@ti.com> <87y47igr1g.fsf@linux.intel.com> <5732EA85.6050601@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5732EA85.6050601@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>> Roger Quadros <rogerq@ti.com> writes:
>>>>> @@ -497,8 +503,8 @@ static int dwc3_omap_probe(struct platform_device=
 *pdev)
>>>>>  	/* check the DMA Status */
>>>>>  	reg =3D dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
>>>>>=20=20
>>>>> -	ret =3D devm_request_irq(dev, omap->irq, dwc3_omap_interrupt, 0,
>>>>> -			"dwc3-omap", omap);
>>>>> +	ret =3D devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interru=
pt,
>>>>> +					NULL, 0, "dwc3-omap", omap);
>>>>
>>>> if you're using threaded_irq, it's better to have a NULL top half and
>>>> valid bottom half.
>>>
>>> But in this case we don't need a bottom half as there is nothing to do =
:).
>>>
>>>>
>>>> In fact, since this will be shared, you could do a proper preparation
>>>> and on top half check if $this device generated the IRQ and
>>>> conditionally schedule the bottom half. Don't forget to mask device's
>>>> interrupts from top half so you can run without IRQF_ONESHOT.
>>>>
>>>
>>> Why do this at all if there is nothing to do in the bottom half?
>>=20
>> oh, but there is :-)
>>=20
>> The whole idea of threaded IRQs is that you spend as little time as
>> possible on top half and the (strong) recommendation is that you *only*
>> check if $this device generated the interrupt. Note that "checking if
>> $this device generated the interrupt" will be mandatory as soon as you
>> mark the IRQ line as shared ;-)
>>=20
>> So here's how this should look like:
>>=20
>> static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
>> {
>>         struct dwc3_omap *omap =3D _omap;
>>         u32 reg;
>>=20
>>         reg =3D readl(IRQSTATUS)
>>         if (reg) {
>>                 mask_interrupts(omap);
>>         	return IRQ_WAKE_THREAD;
>>         }
>>=20
>> 	return IRQ_HANDLED;
>
> This should be IRQ_NONE right?

possibly, testing will say ;-)

>> static irqreturn_t dwc3_omap_threaded_interrupt(int irq, void *_omap)
>> {
>>         struct dwc3_omap *omap =3D _omap;
>>         u32 reg;
>>=20
>>         spin_lock(&omap->lock);
>
> Do we really need a spin_lock for the dwc3-omap driver?
> Currently we won't be doing anything other than just
> clearing the irqstatus and re-enabling the interrupts.

well, if there's no possibility of races, then no. But only testing will
say for sure, I guess. I didn't really go through the entire thing just
to a write a quick little template :-p

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMv+5AAoJEIaOsuA1yqREB0UP/0Pldih91arkBCQUKrbF0pby
GHQE0Q/Wdyb8TYaMWijnZtv8TqPtxNnhll16zxTpfTY1GZ7ZsUrtt85HtBpjSx+h
ElbginpGdRjT3TqsO22RLTRE4yZjbonB9vrnpGJ+GG8l/xQX2a5sVonIgrB3/bFu
HA0IIAn5yXG/usD+Pac+aEat406YG27z3RFVCXMia7Sr9HeJG8qeCkhtvZr+HUWa
EeZWFFYpehJXdqtGTH+ZkfU+IGJV1l/ZaD9lkucgJC2J0Rvycp1uep3/kA+gmuq2
g3u66MuOegX2GhKw7sqAlzLa9QbLcvm45tTkI/bl5Mvp+T3GneAvIwqFJbWTBhn7
LbqNVfq2gCln/6aMFpVST2puKbRap5jCOM121m8774xNnzU7ZhqitDvJXlitWbD7
sdrDeltlp6Geoge7j69tRONV8CxyanSgNYGcsjS8YA8ekAFeFUu0JOKnBXw0A8Sp
F382NfuzSnKM9g1IzxajZpiXwopaQUrmxHDShmqQOyPfTajxWsLQ9Qm/rCLuzca2
2KDZWZjnUHY3s4w8K/evu62+xa/gCxcEzz7YuEwmMhRwAHrbkN9xEN+RT6WZVr3y
Dk28Yx3ct9IdxCvv7XN/RtLagH8GOG97cIAT6id5jSyg5ABulOqRuCJFQqJ/4cxX
FvyM6dZ+Z83Mh2Nw9uFb
=zlVv
-----END PGP SIGNATURE-----
--=-=-=--
