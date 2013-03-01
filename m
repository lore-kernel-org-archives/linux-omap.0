From: =?UTF-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?=
	<freemangordon@abv.bg>
Subject: Re: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
Date: Fri, 1 Mar 2013 12:09:12 +0200 (EET)
Message-ID: <604513288.26328.1362132552062.JavaMail.apache@mail83.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: pali.rohar@gmail.com, tony@atomide.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

=20
Unfortunately it is necessary, on RX-51 PPA/NOLO leaves IBE bit unset.


 >-------- =D0=9E=D1=80=D0=B8=D0=B3=D0=B8=D0=BD=D0=B0=D0=BB=D0=BD=D0=BE=
 =D0=BF=D0=B8=D1=81=D0=BC=D0=BE --------
 >=D0=9E=D1=82:  Peter De Schrijver=20
 >=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE: Re: [PATCH] arm: omap: RX=
-51: ARM errata 430973 workaround
 >=D0=94=D0=BE: Pali Roh=C3=A1r=20
 >=D0=98=D0=B7=D0=BF=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=BE =D0=BD=D0=B0: =
=D0=9F=D0=B5=D1=82=D1=8A=D0=BA, 2013, =D0=9C=D0=B0=D1=80=D1=82 1 11:43:=
14 EET
 >
 >
 >On Thu, Feb 28, 2013 at 10:42:28AM +0100, Pali Roh=C3=A1r wrote:
 >> Signed-off-by: Ivaylo Dimitrov=20
 >> Signed-off-by: Pali Roh=C3=A1r=20
 >> ---
 >>  arch/arm/mach-omap2/Makefile            |    1 +
 >>  arch/arm/mach-omap2/board-rx51-secure.c |   66 +++++++++++++++++++=
++++++++++++
 >>  arch/arm/mach-omap2/board-rx51-secure.h |   36 +++++++++++++++++
 >>  arch/arm/mach-omap2/board-rx51-smc.S    |   34 ++++++++++++++++
 >>  arch/arm/mach-omap2/board-rx51.c        |    7 ++++
 >>  5 files changed, 144 insertions(+)
 >>  create mode 100644 arch/arm/mach-omap2/board-rx51-secure.c
 >>  create mode 100644 arch/arm/mach-omap2/board-rx51-secure.h
 >>  create mode 100644 arch/arm/mach-omap2/board-rx51-smc.S
 >>=20
 >
 >Is this necessary? I thought the PPA sets this bit?
 >
 >Cheers,
 >
 >Peter.
 >
