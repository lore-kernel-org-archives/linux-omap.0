From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Thu, 19 Feb 2015 19:20:41 +0100
Message-ID: <201502191920.41284@pali>
References: <20131206213613.GA19648@earth.universe> <201502111339.54480@pali> <CAALWOA_ngoSKjB=ZQ264Va37bBK7v41Ei45SyoYLiMdanTKnxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1506586.9ZVXXx7XJm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:40058 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbbBSSUp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2015 13:20:45 -0500
Received: by wesx3 with SMTP id x3so1368512wes.7
        for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2015 10:20:44 -0800 (PST)
In-Reply-To: <CAALWOA_ngoSKjB=ZQ264Va37bBK7v41Ei45SyoYLiMdanTKnxQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@ring0.de>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--nextPart1506586.9ZVXXx7XJm
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 11 February 2015 16:22:51 Matthijs van Duin wrote:
> On 11 February 2015 at 13:39, Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
> >> Anyhow, since checking the firewalls/APs to see if you have
> >> permission will probably only get you yet another fault if
> >> things are walled off, the robust way of dealing with this
> >> sort of situation is by probing the device with a read
> >> while trapping bus faults. This also handles modules that
> >> are unreachable for other reasons, e.g. being disabled by
> >> eFuse.
> >=20
> > It is possible to patch kernel code to mask or ignore that
> > fault? Can you help me with something like that?
>=20
> As I mentioned, I'm still learning my way around the kernel,
> so I don't feel very comfortable suggesting a concrete patch
> just yet. I've been browsing arch/arm/mm/ however and my
> impression is that all that would be required is editing
> fault.c by making a copy of do_bad but containing
>     return user_mode(regs) || !fixup_exception(regs);
> and hook it onto the appropriate fault codes.  However, this
> really needs the opinion of someone more familiar with this
> code.
>=20
> I do have an observation to make on the issue of fault
> decoding: the list in fsr-2level.c may be "standard ARMv3 and
> ARMv4 aborts" but they are quite wrong for ARMv7 which has:
>=20
> [ 0] -
> [ 1] alignment fault
> [ 2] debug event
> [ 3] section access flag fault
> [ 4] instruction cache maintainance fault (reported via data
> abort) [ 5] section translation fault
> [ 6] page access flag fault
> [ 7] page translation fault
> [ 8] bus error on access
> [ 9] section domain fault
> [10] -
> [11] page domain fault
> [12] bus error on section table walk
> [13] section permission fault
> [14] bus error on page table walk
> [15] page permission fault
> [16] (TLB conflict abort)
> [17] -
> [18] -
> [19] -
> [20] (lockdown abort)
> [21] -
> [22] async bus error (reported via data abort)
> [23] -
> [24] async parity/ECC error (reported via data abort)
> [25] parity/ECC error on access
> [26] (coprocessor abort)
> [27] -
> [28] parity/ECC error on section table walk
> [29] -
> [30] parity/ECC error on page table walk
> [31] -
>=20
> Some entries are patched up near the bottom of fault.c but
> many bogus messages remain, for example the "on linefetch" vs
> "on non-linefetch" is misleading since no such thing can be
> inferred from the fault status on v7.  Also, the i-cache
> maintenance fault handling looks wrong to me: it should fetch
> the actual fault status from IFSR (even though the address
> still comes from DFSR) and dispatch based on that.
>=20
> Async external aborts (async bus error and async parity/ECC
> error) give you basically no info. DFAR will contain garbage
> hence displaying it will confuse rather than enlighten, a
> traceback is pointless since the instruction that caused the
> access is long retired, likewise user_mode() doesn't matter
> since a transition to kernel space may have happened after
> the access that cause the abort. Basically they should be
> treated more as an IRQ than as a fault (note they can also be
> masked just like irqs). In case of a bus error, it may be
> appropriate to just warn about it, or perhaps send a signal
> to the current process, although in the latter case it should
> have some means to distinguish it from a synchronous bus
> error.
>=20
> At least on the cortex-a8, a parity/ECC error (whether async
> or not) is to be regarded as absolutely fatal.  Quoth the
> TRM: "No recovery is possible. The abort handler must disable
> the caches, communicate the fail directly with the external
> system, request a reboot."
>=20
> Bit 10 no longer indicates an asynchronous (let alone
> imprecise) fault.  Apart from the debug events and async
> aborts (and possibly some implementation-defined aborts), all
> aborts listed are synchronous, and DFAR/IFAR is valid.
> There's no technical obstruction to make these trappable via
> the kernel exception handling mechanism. (Though at least in
> case of parity/ECC errors one shouldn't.)

Anyway, in Nokia Harmattan N9/N950 2.6.32 kernel is this patch:

diff --git a/arch/arm/mm/fsr-2level.c b/arch/arm/mm/fsr-2level.c
index 18ca74c..d530d55 100644
=2D-- a/arch/arm/mm/fsr-2level.c
+++ b/arch/arm/mm/fsr-2level.c
@@ -7,7 +7,12 @@ static struct fsr_info fsr_info[] =3D {
 	{ do_bad,		SIGBUS,	 BUS_ADRALN,	"alignment exception"		   },
 	{ do_bad,		SIGKILL, 0,		"terminal exception"		   },
 	{ do_bad,		SIGBUS,	 BUS_ADRALN,	"alignment exception"		   },
+/* Do we need runtime check ? */
+#if __LINUX_ARM_ARCH__ < 6
 	{ do_bad,		SIGBUS,	 0,		"external abort on linefetch"	   },
+#else
+	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"I-cache maintenance fault"=
	   },
+#endif
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"section translation fault"=
	   },
 	{ do_bad,		SIGBUS,	 0,		"external abort on linefetch"	   },
 	{ do_page_fault,	SIGSEGV, SEGV_MAPERR,	"page translation fault"	   },

Maybe it is related?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1506586.9ZVXXx7XJm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTmKXkACgkQi/DJPQPkQ1K9rwCeMzAnHuTpccYVJFiRRWvLnwwD
2hUAoLIQs+UnShL+azLvut2OQkvxydaV
=+mJv
-----END PGP SIGNATURE-----

--nextPart1506586.9ZVXXx7XJm--
