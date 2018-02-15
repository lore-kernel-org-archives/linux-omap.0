From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [balbi-usb:testing/next 45/57] drivers/usb/dwc2/core.c:438:13: error: static declaration of 'dwc2_clear_force_mode' follows non-static declaration
Date: Thu, 15 Feb 2018 15:33:21 +0200
Message-ID: <87bmgq8jj2.fsf@linux.intel.com>
References: <201802152134.OH8x0B2I%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201802152134.OH8x0B2I%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grigor Tovmasyan <Grigor.Tovmasyan-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git tes=
ting/next
> head:   65223a0ed97c8c4b18c4899653745058f87d67e3
> commit: 4caf1fe8fb537388810a4c8fecfa5324b26f80ea [45/57] usb: dwc2: Make =
dwc2_force_mode() static
> config: i386-randconfig-x072-201806 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 4caf1fe8fb537388810a4c8fecfa5324b26f80ea
>         # save the attached .config to linux build tree
>         make ARCH=3Di386=20
>
> All errors (new ones prefixed by >>):
>
>>> drivers/usb/dwc2/core.c:438:13: error: static declaration of 'dwc2_clea=
r_force_mode' follows non-static declaration
>     static void dwc2_clear_force_mode(struct dwc2_hsotg *hsotg)
>                 ^~~~~~~~~~~~~~~~~~~~~
>    In file included from drivers/usb/dwc2/core.c:57:0:
>    drivers/usb/dwc2/core.h:1101:6: note: previous declaration of 'dwc2_cl=
ear_force_mode' was here
>     void dwc2_clear_force_mode(struct dwc2_hsotg *hsotg);
>          ^~~~~~~~~~~~~~~~~~~~~
>
> vim +/dwc2_clear_force_mode +438 drivers/usb/dwc2/core.c
>
>    428=09
>    429	/**
>    430	 * dwc2_clear_force_mode() - Clears the force mode bits.
>    431	 *
>    432	 * After clearing the bits, wait up to 100 ms to account for any
>    433	 * potential IDDIG filter delay. We can't know if we expect this d=
elay
>    434	 * or not because the value of the connector ID status is affected=
 by
>    435	 * the force mode. We only need to call this once during probe if
>    436	 * dr_mode =3D=3D OTG.
>    437	 */
>  > 438	static void dwc2_clear_force_mode(struct dwc2_hsotg *hsotg)

patch dropped.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqFjCEACgkQzL64meEa
mQbG+BAAkZaeK/QagVjuq1m2mYACTvDlMIoGGj/4eDLeR/lZZLDbouUL5eaZYUfz
0men70X8merKQW2+RuaEvZI0WHmHq8TMIgHQOVSR+IfIIjBTtrKivIyW9PJvxpy/
nuTeJwre1AiFQcEOCc90heI1tJusIeBGnBQxN/iRwTzuPZoMu/QsNtuNrVNclKMB
oKeFvHkg/w3MVSEtsR8X9ONmGlNO9wgHfySuFR8IKz2IJTV7Yk8DqMccGkfdpJT6
qSShNsiAFrKe8gOHXRYtTr6bMEtlbSuRnfdD+xyEkf7WawD9aJEd9PCBgdRAJZBC
av+6f/rKXRDGgpLbMiBJ5qlzqOHOKzwE1zoNfYfX2IsgBkPYmuj3WnHI5eMSHriE
xxf9J/kmrEwue+OCqsyGRNqwYHix1NxDQCbWPfn6/BvnR/fvt9+m4GgmVWMAHYpC
mj/1tKvcXHrQ25/E2ArM2g3Kj7T6VxYQXcXHNRNvc8xFX0V4mfP4qCkL+QJtUq/Q
skoAs1j/0zgzZgsi/7CwshW+QS+iqaoFsZQry+7OkR0Gkff04Meic0TzgROyoZAM
dkU0mz+qckzI3FkomijOGJKWclwDp5zYUxNlYcTJgfZU6Svxh7MaKX47P0zpWWgR
B2dLcNjUkBNrPcfZCdAQH2DpfSINWQt7c/rTyTlD1o/ybIAB0CU=
=ozVy
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
