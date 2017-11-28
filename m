From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: EHCI and MUSB do not discover devices without CONFIG_PM
Date: Tue, 28 Nov 2017 11:03:50 +0200
Message-ID: <87induzseh.fsf@linux.intel.com>
References: <20171127220833.GA10070@lenoch> <20171128073328.GF10757@kroah.com> <20171128085751.GA28256@lenoch>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171128085751.GA28256@lenoch>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> writes:
> On Tue, Nov 28, 2017 at 08:33:28AM +0100, Greg KH wrote:
>> On Mon, Nov 27, 2017 at 11:08:33PM +0100, Ladislav Michl wrote:
>> > Hi there,
>> >=20
>> > USB hosts do not discover any connected device on OMAP3 based board
>> > with CONFIG_PM=3Dn. Just enabling this option is enough to restore wor=
king
>> > behaviour. Nothing unusual in log. Tested 4.14.2 and 4.15-rc1. I know
>> > a lot of stuff depends on CONFIG_PM, but is this expected behaviour?
>> > Neither EHCI nor MUSB is working without CONFIG_PM.
>>=20
>> What bus type is your controllers on?  PCI?  platform?  Something else?
>
> Platform controllers inside OMAP3630 Soc.
>
>> And yes, perhaps this is to be expected, why would you not want
>> CONFIG_PM to be enabled?  :)
>
> For a start, I know Linux is general purpose OS and I know I cannot expect
> low latency or low jitter when dealing with interrupts.
>
> Original problem is described here:
> https://www.spinics.net/lists/linux-omap/msg140081.html
>
> Shortly, with CONFIG_PM jitter of GPIO interrupt is about 350us which
> renders IR receiver unuseable - is cannot reliably decode IR protocol
> (gpio-ir-recv is used). With CONFIG_PM disabled, jitter is around 30us
> and that's enough to make IR decoders work.
>
> And as I was unable to fix it, nor anyone provided useful hint, I though
> I could work around problem from another side. And here we are...

Isn't it enough to just set a huge timeout for GPIO's runtime_pm? You
can do that through sysfs. Just write a big number to the GPIO's
autosuspend_delay_ms file. This should help you:

modified   drivers/gpio/gpio-omap.c
@@ -1238,6 +1238,8 @@ static int omap_gpio_probe(struct platform_device *pd=
ev)
=20
 	platform_set_drvdata(pdev, bank);
=20
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, 60000);
 	pm_runtime_enable(dev);
 	pm_runtime_irq_safe(dev);
 	pm_runtime_get_sync(dev);


=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlodJnYACgkQzL64meEa
mQZgsw/+K5xxYwluULykLzr5ygxh9pj4k1mkvMuXJeFmGc80G/CgwUBXjhZChgwb
Lq6KTk+B+Ur6/3y9iS7VZIrgsBwWPoBCoV+UySoR2ov6p4sCAKDXnftMcKSJ7MeM
AqlPSJ9DjXHAZzvx7bFRc9LklUwL4Cd6kGOWGfSK/fs4HomFb6fhptRr1mEFrdVP
DZqPyPqVMvE+o8E9waASv52voGqX57DNHeDkuufD1Zx8ck667ooKaKDo1eFnaIms
NW85A+6DraV5nY7h5mH/9g6k9uYuZ7SpHc6zEbMvmpauofPpPbaIeyQrrm2FhnKC
PXeRGJ10NUx1KmdjheY7l2Z1DFJG9nCJF7NwnC62N7NClKJiV/kCPZsueLZAmPTM
idOlVLrc3QGPGK0UT8XBCoido8tOv7BLfKAMVIdO7Dv/gvOWMeKy/3OvX+DaJUnX
boF8cVz9ps0Q1nkeMdPWfQILpMiVgIEooyJfnqFb0E40KKUehqUDA219XY2VA4aa
1Lz3z0EELy8g3CXLF4QdOMssS9cDtU6A2IkwKiXueb8ACsyE1A9MzG92MFURn2h8
DR37BT4D2OIk5b/fm2R/ljfK1/0zig5Pad3yCJdvkG+Lq0EFQEZS2QkUCBtnqTRh
Y901v/ja0QuOSNlIgDUQDd0TII7IWoUHZWaZs/bDchWaroZCxW4=
=RsT+
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
