From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH] rtc-twl: Switch to using threaded irq
Date: Tue, 31 May 2011 10:51:39 +0200
Message-ID: <20110531085139.GA7290@earth.universe>
References: <1300291634-17884-1-git-send-email-ilkka.koskinen@nokia.com>
 <BANLkTinp8M4nndDC5Sfm=PzCiL-vGEqELg@mail.gmail.com>
 <4F5287B0C366D047BF44025F9ED7BB43E9D7@008-AM1MPN1-001.mgdnok.nokia.com>
 <1305242664.2680.28.camel@work-vm>
 <4DD41BE5.4050600@kolumbus.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comu.ring0.de ([46.4.151.82]:48630 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753952Ab1EaIvy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 May 2011 04:51:54 -0400
Content-Disposition: inline
In-Reply-To: <4DD41BE5.4050600@kolumbus.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, John Stultz <john.stultz@linaro.org>, a.zummo@towertech.it, rtc-linux@googlegroups.com, balajitk@ti.com, Ilkka Koskinen <ilkkakos@kolumbus.fi>


--wzJLGUyc3ArbnUjN
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I think the patch should also remove the local_irq_enable() call in
twl_rtc_interrupt, since it's no longer needed with threaded irq. At
least on the Pandaboard the RTC is still working with the appended
patch.

-- Sebastian

> >> On Apr 13, 2011 Krishnamoorthy, Balaji T  wrote:
> >>> On Wed, Mar 16, 2011 at 9:37 PM, Ilkka Koskinen
> >> <ilkka.koskinen@nokia.com> wrote:
> >>>>
> >>>> The driver is accessing to i2c bus in interrupt handler.
> >>>> Therefore, it should use threaded irq.
> >>
> >>> Acked-by: Balaji T K <balajitk@ti.com>
> >>
> >>>>
> >>>> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
> >>>> ---
> >>>>  drivers/rtc/rtc-twl.c |    2 +-
> >>>>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>>>
> >>>> diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
> >>>> index ed1b868..2715b96 100644
> >>>> --- a/drivers/rtc/rtc-twl.c
> >>>> +++ b/drivers/rtc/rtc-twl.c
> >>>> @@ -475,7 +475,7 @@ static int __devinit twl_rtc_probe(struct platform_device *pdev)
> >>>>        if (ret < 0)
> >>>>                goto out1;
> >>>>
> >>>> -       ret = request_irq(irq, twl_rtc_interrupt,
> >>>> +       ret = request_threaded_irq(irq, NULL, twl_rtc_interrupt,
> >>>>                                IRQF_TRIGGER_RISING,
> >>>>                                dev_name(&rtc->dev), rtc);
> >>>>        if (ret < 0) {
> >>>> --
> >>>> 1.7.0.4

--6TrnltStXW4iwmi0
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="fix-twl-rtc.patch"
Content-Transfer-Encoding: quoted-printable

--- a/drivers/rtc/rtc-twl.c   2011-05-19 06:06:34.000000000 +0200
+++ b/drivers/rtc/rtc-twl.c   2011-05-26 20:34:03.000000000 +0200
@@ -362,14 +362,6 @@
        int res;
        u8 rd_reg;
=20
-#ifdef CONFIG_LOCKDEP
-       /* WORKAROUND for lockdep forcing IRQF_DISABLED on us, which
-        * we don't want and can't tolerate.  Although it might be
-        * friendlier not to borrow this thread context...
-        */
-       local_irq_enable();
-#endif
-
        res =3D twl_rtc_read_u8(&rd_reg, REG_RTC_STATUS_REG);
        if (res)
                goto out;
@@ -462,7 +454,7 @@
        if (ret < 0)
                goto out1;
=20
-       ret =3D request_irq(irq, twl_rtc_interrupt,
+       ret =3D request_threaded_irq(irq, NULL, twl_rtc_interrupt,
                                IRQF_TRIGGER_RISING,
                                dev_name(&rtc->dev), rtc);
        if (ret < 0) {

--6TrnltStXW4iwmi0--

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJN5KwbAAoJENju1/PIO/qaPtgP/16IipKAmEUQgBB2cyzaZ1E6
tHwBs12wt0N2r4s4c21pNtnF+EkaCVhxAtvTmikirO3AefvJ3yPYlEB2dY23wEb/
dg8+8bKA28ssUSrxJ6GqRBMRM8IoPIBimpNjBBZXIl5ThFSgESzZh41qBOFqjBx+
syWaoVKgdvR0nnJHyHvGfHF2wOe4lrXmEziaigBhTPIRo1X8lVmmEYj01MIcjuAz
urvozhmJ4bya+sBF3WOXdsNBjZuLVm+gL40uQDYRKhpCJJ/SkQQsp8JM8ZXEwoU/
i+nEeqnpEYHIGXNx2dC/Qx/yPZP1L3cLd18r64vI9eaeu0nCw+cN0AP92CvGn9Jx
aKFKpEFGh7In2ljTJtfJhEhS7HzCoVB8GOENXGdjyWS1kbP70n5FdnseyFohnkqY
NTh8wEp4ipc6j3XDLRMzFtL/eVIMhbzQTJOZcacuC9r2KePgXOa8tlk/kDDsH+EM
EBYNkBP5MCQDCY/TrgOEa5GmOuXGEz+jOloF3luz/cx1ptKn4aIBoD4MfAqwdFmD
JmLn46fTk5hY5N47lcrV1kTsUJCQZhk3/GIK64YVb9e9R+DCbOBLQRFpplR6dqnk
SVvA42qFCtTQQ7MXM5lYWIa/YUPTOvDqKjpRQjuH/0oe3Q1PlGn5XSw3zSyjJub1
aEV0JJLyFAflxmNQHTUx
=sSUr
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
