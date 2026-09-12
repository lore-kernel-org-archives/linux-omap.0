Received: from mail-qk2-f8.google.com (mail-qk2-f8.google.com [74.125.230.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336A5376475
	for <linux-omap@vger.kernel.org>; Sat, 12 Sep 2026 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.200
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789178960; cv=pass; b=efZuTQGhDxLXRBgJIv6OQkiZg8/m7RH1iaHjdmkuKGQtDWH0l6ewIJOFS0ofmUoiWmCt4l1pSkgtUxI0Jj/LnL2ZfxXF6myu+0NBDKEEAG6f4omJMVKFPAlT/Q3kve3VGwdJEEAhVESXwzxJxcHZzjKYdcIgyas0KohB60j4pKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789178960; c=relaxed/simple;
	bh=mdT9ENWPEzBfkyRK8P1a2dUQlY39G8cEaKSfK8TCWpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNu9CRjosXND7enaru+BzZACKkrlTI+z4mP3Uvh71FeNwDUXoshy0XdZhmNou4P0bkEWuiMJL/nHTi3QRzAg5bdEs2cyEiSzx0DoZv2wEXhclyaoJ7Y6PMMOjefll37JQcVV+TiBI24hN8+IfRIiUXewQg1Kqo+oxTjqu+OWcAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMm3dOKX; arc=pass smtp.client-ip=74.125.230.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMm3dOKX"
Received: by mail-qk2-f8.google.com with SMTP id d75a77b69052e-530e2f0c0a8so4153781cf.0
        for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2026 19:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789178952; cv=none;
        d=google.com; s=arc-20260327;
        b=EZqmKp1dziLdnl1HdyXwekAy9gYOjwIWdHfiZinvYtNFn3ofWt7J/Zw/arpZALLnyK
         VKGl1PSWM4DgA6byX2qwd5ANwGWvYfgy6+j16phENSiiCw9BJuuG3Q45o6OeJYP+mv0y
         b/0BrjtldvDI+vcS3W34o+IaaQYvMjm2iS4NV+EW+G69sWgsRHrYSt79wAbzMjeo/ows
         c39mMnz4Hgm49Rf4TNYoRxIa2SnSOvV5o7pOOgf4mk/ax65BEKEPASEzZEcdxoxPiHJY
         9KqABPMNf4Rl4YbQ/QjMItkpzE8bP2n4YNTreYrJQM+fiG4FEex1/fbOg760VXF/OMOj
         0JYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mdT9ENWPEzBfkyRK8P1a2dUQlY39G8cEaKSfK8TCWpw=;
        fh=qzzBMwamDf30kSkCgufkcwMDMWCb+6Txc84XOWeelBs=;
        b=s0uVs9lOsmP+s4l6e4Ygx8CbusD+VgpshjIxaAtFKViBk8gsH/yhRUHQBMViN1TLZr
         Tzw4RQVc7zwj5DhGoLBvqURwgrSG58B/Lf96rmMezp7Sx+Z3mLQcH4USWzdv69xuyDc8
         accMKBde2orEJBkg2rIPxb5SHge6m1qaKT/2SoUMmK5s1qQrMd1nHRGJvNkXS4jS7zP0
         Y33z7O0DJkriv/whJYPKoxQmZ2XkNpIRhJCIXJZxy7gwi0KuDlVoFVCZ+E1Bc1UKungJ
         BlgkHdIZ35oYHFHgmMSbIf1sRLcV9Twq4+sNN+ZjfnRQc0ho7TW8ujHuu0HzFI3KsK8x
         Mj8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789178952; x=1789783752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mdT9ENWPEzBfkyRK8P1a2dUQlY39G8cEaKSfK8TCWpw=;
        b=JMm3dOKXg3dR288w9DJwRrPKB3jB2Gf5uWX+r2Jd94fqwUUkdUb0j8Tu/DNIpnF5Gh
         +fKPDYcxNdVvIY+oI2ffqgGRXi5h1VT2cDFU21lEdRPmkMTAiv42+Z+OtKGgD5VM/Hw2
         olMjymLuzbTX6+vI5HVpJmDgAGm4Xj31buSYpDWt7obqabhT3/TDoSX82s44Mepo45bw
         9EVfVjW2P2wKmCTKoPvXWS7dCezilyn/1AUEgdmFXRsV+uzBIrx06eXZlP9YpKSNmmFN
         GjTueV3c59yNLE0Nz57BNmZwVVs8eHNY3ZsfMatyrRcNs7h4QCgMHEsm6g/JMmx62Ecd
         Mt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789178952; x=1789783752;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mdT9ENWPEzBfkyRK8P1a2dUQlY39G8cEaKSfK8TCWpw=;
        b=GNLGsq0vrWKAs/aGlWBjKe94GVZ9lYY/EFq+cnE7BYPjChftLOchPujj7fc0+RnL+S
         3Dtv9glDBoDL7qvx8R38Ofxw+CW21GQrfcGzFxNfeRDi/vCAvZsvFj3MH78NEdpFz9lh
         37l5xffQe35VJeZzlhpFFqXnL2fA2B1TtyoylMJ5BjGRL0/f8FXs+BnO4dtAZIAAxIVJ
         WNDX76VHeRV0woqCnz/MobhqUnFrfCsc8v72uIY77EO3cZ7AJUvalOj2lAlXAP4WrgW5
         8O4nCCIpbtT4mfEeiRqhN4z6ZwVyo1KEwjJGmmp+3afaDgOA4nmAoJSZHu3+HaUS9Qlp
         cUtg==
X-Forwarded-Encrypted: i=1; AKwUvBxLzFuOTteOHh0jrKA4EHW/NmNyT2ZURErWXxgg9H0kQZ9+MXY1ErwADlwge4a4gGxp4Q47qcqQWT6K@vger.kernel.org
X-Gm-Message-State: AFuF++lUO94mp87qPsrpVQY0LDGyOQvq0TxCP1nKnAjx72MxEt32GM4K
	roz6D1XcpGNi1py9Uv/vDANV3ci4qqMS0ClrF0Q36OYnhHyrXK193j2xhUS7saYKVf1Jvu6OUD2
	FBoxDEc8vw6JdJ2v3JB8wS6UqiBp9PKM=
X-Gm-Gg: AYBFou2NvkKVY1DuG0vvBtQfE+CvuA6CKP+GT1s37xhS/Z+6XaPCKkC6385eKA1hO1t
	jdAxroSo/phvfGFfW991Qsd4hpsYHrA4K4fv0B4oJO7X+ib9V8H/ZMgSBaDOP8V58hPwSVv998U
	iaDa76YxemaXTgtSVNb5WfOtCyOeBXQggzIegNG63PKNbzkSOquCne9Wpccvuizv5TsapEmNZ0u
	R1OqPTkCHqQufT+DpEn4w2zMyA6+7CZdHxgGvXPHs7sClB4/VQb8yiYRLoSIRfrrYzph18fM2Gb
	7qt0IWEbdt7N/ChY/gwnJBNbEEYpx21/Zb094ETOqyy7SmWyWW/sUDWgn4sfqyNWTRrBIWztK3S
	81FLO3uOEH1VCb9SsVpf4glh6FSX6GwiQOYSfV7bu
X-Received: by 2002:ac8:5dc6:0:b0:530:d1d6:792d with SMTP id
 d75a77b69052e-530e7dd8ae5mr13590681cf.15.1789178947506; Fri, 11 Sep 2026
 19:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com> <aqRI3N5FPX1dpIlk@gmail.com>
In-Reply-To: <aqRI3N5FPX1dpIlk@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Fri, 11 Sep 2026 19:08:55 -0700
X-Gm-Features: AcwNN1XgIQzd6k50BFzIHmb9Q0P_yN5Y-RnB_uEDdmfcLkrtltvi4fLr_oEAXtE
Message-ID: <CADkSEUgkPyikkhqLBOVEeS-H8L7CvUN8VD88=dUuTeFB8pUM5w@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Drew Fustini <fustini@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Shawn Guo <shawnguo@kernel.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	Ian Molton <spyro@f2s.com>, Jens Axboe <axboe@kernel.dk>, Helge Deller <deller@gmx.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, "Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Karl,

On Fri, Sep 11, 2026 at 11:43=E2=80=AFAM Karl Mehltretter
<kmehltretter@gmail.com> wrote:
> I've made a RiscPC emulator in the browser using QEMU and WASM. It boots
> Linux kernels and currently emulates a StrongARM RiscPC:

That's awesome. Are you planning to add support for the NetWinder to the b?

A couple things that I didn't see when I glanced through the code:

* QEMU needs to model the broken ldrh/strh instructions for the Risc
PC (but not the NetWinder). I am not sure exactly what their behavior
is on real hardware (though I have seen forum posts where people
investigated this - I'll let you know when I find them). For now, you
could just have them load/store a random value (:p). It would also be
helpful if it could print a warning when one of these instructions is
executed, to help people detect and remove instances of them in e.g.
JITs.

* On ARMv3, CP15 register c0 is write-only, and you don't model this.
This caused Linux on ARMv3 to be broken for a very long time before
support was eventually removed - it was broken even in 2.4.18-rmk4. A
patch to run Linux on the CL-PS7500FE (=3D ARM710 Risc PC on a chip,
used in the Acorn A7000+) works around this by keeping a copy of it:
http://webpal.bigbrd.com/patch-2.4.18-rmk4-wp3.gz. According to a
comment in later 2.4 versions, that approach won't work, but I don't
understand why. Also, the patch fails to fix other reads to the
register outside cpu_get_pgd() (I forget which ones).

A few things I know about early ARM hardware and Linux that might help you:

Before 2.6, ARM support in the mainline kernel was very incomplete
and, IIRC, unusable. To build a working kernel, you needed to apply a
patch from http://ftp.armlinux.org.uk/pub/linux/arm/kernel/. There are
no patches for versions newer than 2.4.27, but the 2.4.27 patch mostly
applies correctly to 2.4.37.11 (I didn't try to fully fix it up
though). The last patch that was released was 2.6.0-rmk2 - it has some
relevant changes like the CL-PS7500 PS/2 mouse driver. There is also
an unreleased 2.6.4 patch - I should ask RMK if he still has it.

The NetWinder development team shipped patches to their kernel with
additional features for the NetWinder (and other ARM hardware,
including Acorn). This is the last one:
http://www.netwinder.org/mirror/users/r/ralphs/kernel/patch-2.4.21-rmk1-nw1=
.gz
I don't think most of those changes ended up in mainline.

The Risc PC and NetWinder lost their audio drivers when OSS was
removed in commit 727dede0ba8afbd8d19116d39f2ae8d19d00033d. RMK was
working on an ALSA driver for the NetWinder but never finished it
(IIRC it is in 2.6.0-rmk2 but probably doesn't work).

> I used LLMs a lot while building it.

I don't use LLMs for environmental reasons, because they are often
inaccurate, and because I like using my own brain and don't want it to
atrophy, but we are all entitled to our own opinion.

> Your GCC work looks useful for this. I will look at building the RiscPC
> Linux kernel with it, and at emulating the original ARMv3 CPU too.

Great. Let me know if it works.

P.S. I have a few UI suggestions for the emulator:
* Make the display bigger and able to lock the mouse/keyboard and go
into fullscreen.
* Remove the LK201 keyboard - the NetWinder used a normal PC keyboard
(if you add it), and the Risc PC used an Acorn PS/2 keyboard (a normal
British PC keyboard but with no Windows key):
https://chrisacorns.computinghistory.org.uk/32bit_UpgradesA2G/Acorn_RiscPC_=
Keyboard.html.
Just keep virtual keys for the keys that you can't input in a web
browser.
* It should be possible to middle click using a modifier key if the
emulator ever runs Risc OS, because middle clicking is heavily used in
Risc OS.
* I think some of the explanatory text is unnecessary.
* The skeuomorphism is cute but inaccurately represents a Risc PC, and
I think it clutters the UI unnecessarily.

Ethan
