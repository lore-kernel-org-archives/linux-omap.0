From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v5 3/3] drivers:power:twl4030-charger: add deferred probing for phy and iio
Date: Mon, 12 Jun 2017 22:38:48 +0200
Message-ID: <7D1F0D80-0291-4EFE-8577-D15363028672@goldelico.com>
References: <cover.1495363097.git.hns@goldelico.com> <6ed105f6c9c21c24184913a7be9e665453549d79.1495363097.git.hns@goldelico.com> <20170607204444.zumcreuqdnv7euv2@earth> <01A3D2F5-9E09-4E93-A363-93130DCEB7DF@goldelico.com> <1b9f3e92-36ac-2a73-7b2d-037b19fafaad@ti.com> <DC2DA07F-72A1-45B9-A4F5-BD83D930974D@goldelico.com> <754fbc28-f5ff-4736-1d46-f467667b130d@ti.com> <D12A5BD7-65A1-49E6-A25C-B2A2162FCA05@goldelico.com> <a91d2ad7-5985-789e-e4ad-04057dfdd8a3@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a91d2ad7-5985-789e-e4ad-04057dfdd8a3-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM mailing list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
>>=20
>>> As for me it more reasonable to move forward using smaller steps.
>>=20
>> Well, I wonder what it does help to fix a bug which does not even =
become visible
>> if we don't add EPROBE_DEFER?
>=20
> Sry, but have you tried test I've proposed (I can't try it by myself =
now, sry)?=20

No because I can't easily try it at the moment.

And I think it does not show what you expect.

Usually the iio_channel_get() fails and we have bci->channel_vac =3D =
NULL
which does not make problems in the irq handler and is catched in =
ac_available().

To make iio_channel_get() not fail we have to implement deferred probe
handling.

> There is not only iio channel can be a problem - for example =
"current_worker"
> initialized after IRQ request, but can be scheduled from IRQ handler.

Ah, yet another bug.

Looks as if there are some race conditions and we are just lucky that it
rarely happens.

>=20
>>=20
>> So I would count two steps:
>> a) add EPROBE_DEFER and reorder code to make it work
>> b) convert to devm for iio
>>=20
>=20
> Few words regarding devm_request_irq() - it's useful, from one side, =
and
> dangerous form another :(, as below init sequence is proved to be =
unsafe
> and so it has to be used very carefully:
>=20
> probe() {
> <do some initialization>
> <create some object:> objX =3D create_objX() -- no devm
> devm_request_irq(IrqY) -- IrqY handler using objX
>=20
> <init step failed>
> 	goto err;
> ...
>=20
> err:
> [a]
> release_objX() - note IRQ is still enabled here
> }
> dd_core if err:
> devres_release_all() - IRQ disabled and freed only here
>=20
> remove() {
> [b]
> release_objX() -- note IRQ is still enabled here
> }
> dd_core:
> devres_release_all() - IRQ disabled and freed only here
>=20
> IRQ has to be explicitly disabled at points [a] & [b]=20

Or everything done devm so that irqs are released first.

>=20
> Sequence to move forward can be up to you in general,
> personally I'd try to add devm_iio and move  devm_request_irq()
> down right before "/* Enable interrupts now. */" line first.

Yes, that is what I almost proposed as well.

Except that you propose to move lines from INIT_WORK() up to

if (bci->dev->of_node) {
...
}

as well.

Looks good to me.

So if Sebastian or others have no more comments, I will prepare a patch =
v6 asap.

BR and thanks,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
