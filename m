From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: musb: fix pm_runtime calls while atomic
Date: Tue, 8 Nov 2011 13:48:28 +0200
Message-ID: <20111108114826.GM6921@legolas.emea.dhcp.ti.com>
References: <1313159931-22121-1-git-send-email-vikram.pandita@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9v2bTOXBzuB5Piju"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59021 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751053Ab1KHLsc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 06:48:32 -0500
Content-Disposition: inline
In-Reply-To: <1313159931-22121-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-usb@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, axelhaslam@ti.com, ccross@google.com, Moiz Sonasath <m-sonasath@ti.com>


--9v2bTOXBzuB5Piju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2011 at 07:38:51AM -0700, Vikram Pandita wrote:
> From: Vikram Pandita <vikram.pandita@ti.com>
>=20
> musb pm_runtime_get_sync call happens in intrrupt context on cable attach=
 case
> That can result in re-enabling the interrupts and cause side affects.
>=20
> So move the code to a work queue.
>=20
> Following is the error path hit on cable attach:
>=20
> BUG: sleeping function called from invalid context at drivers/base/power/=
runtime.c:802
> in_atomic(): 0, irqs_disabled(): 0, pid: 18, name: irq/378-twl6030
>=20
> Backtrace:
> [<c00520f0>] (dump_backtrace+0x0/0x110) from [<c054f454>] (dump_stack+0x1=
8/0x1c)
> [<c054f43c>] (dump_stack+0x0/0x1c) from [<c007f59c>] (__might_sleep+0x130=
/0x134)
> [<c007f46c>] (__might_sleep+0x0/0x134) from [<c02c2794>] (__pm_runtime_re=
sume+0x94/0x98)
> [<c02c2700>] (__pm_runtime_resume+0x0/0x98) from [<c033e7e4>] (musb_otg_n=
otifications+0x9c/0x164)
> [<c033e748>] (musb_otg_notifications+0x0/0x164) from [<c00b3df0>] (notifi=
er_call_chain+0x4c/0x8c)
> [<c00b3da4>] (notifier_call_chain+0x0/0x8c) from [<c00b44a8>] (__atomic_n=
otifier_call_chain+0x40/0x54)
> [<c00b4468>] (__atomic_notifier_call_chain+0x0/0x54) from [<c00b44dc>] (a=
tomic_notifier_call_chain+0x20/0x28)
> [<c00b44bc>] (atomic_notifier_call_chain+0x0/0x28) from [<c033f124>] (twl=
6030_usb_irq+0xc8/0xdc)
> [<c033f05c>] (twl6030_usb_irq+0x0/0xdc) from [<c00d79f8>] (irq_thread_fn+=
0x24/0x40)
> [<c00d79d4>] (irq_thread_fn+0x0/0x40) from [<c00d7b64>] (irq_thread+0x150=
/0x1d8)
> [<c00d7a14>] (irq_thread+0x0/0x1d8) from [<c00adf70>] (kthread+0x94/0x98)
> [<c00adedc>] (kthread+0x0/0x98) from [<c0094388>] (do_exit+0x0/0x720)
>=20
> Tested with:
> MUSB Device mode: Cold boot / Hot plug
> MUSB Host mode: Cold boot / Hot plug
>=20
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>

applied, thanks

--=20
balbi

--9v2bTOXBzuB5Piju
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOuRcJAAoJEIaOsuA1yqRExTAQAKv+9BFKjR9uLACDEUszMfb4
0/ziK5Vkk3kpLMWwMbCUzxQXTKMX91ENTwgFwGkNLg+vjSdvMSC2LwRtTPyAGSSY
PqgxiwFZReK54jYwSax/BZRBuAuqOh4BRuaTs3loQJwybZcONFYrMwUBi0ugfK6n
bknY/r6YwXayocbVXP7V5G28pH5AKrPXIiLMvQA1AnX4hhAsKjtAGotBCs1wfMZl
+Ca+WcXJkMureiyS64SJGpfUlTzdjutDyIzuxDmTn/NY+no+XIq+k69CbJtcGPeb
vT+Ss6jibPxUeFzWPOybvXD1TUbzl0r6xeitzhIkxlTPfbh9D6voIJvc389NrBIm
/mOARPURGwMGacik4yZYbtcm7MtH42UR7b6M4ghCaBswNCB7elp0p2nALsOfRjW1
+RNnsvBMMsUL3FRgrBChVYVgQ0IA96z3xLkV2LngeC5KzhXcKx0wtr0whZEH8yEZ
WWkn16aAqJEJ9MRCpErhjdPfiZ8BNuNikHbi9LvQwuuv3foncXG+870RB8lOryEU
rWehgp9mwCRcxxL6yvZoNBFrHZr9k0akNKswAsm1iqXAxGYNRZrRrVL3Br93HKI8
y2TgBRNWNj6pGTQz6SBplHWmnFR9CdSovqOIy7n0Y3fU23HFfLXQf9bt5r32QPna
u+4GLPxPCLlwG4c9OkPG
=aXqf
-----END PGP SIGNATURE-----

--9v2bTOXBzuB5Piju--
