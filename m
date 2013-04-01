From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] RX-51: ARM errata 430973 workaround
Date: Mon, 1 Apr 2013 14:03:41 +0530
Message-ID: <51594665.1090903@ti.com>
References: <20130328155803.GT10155@atomide.com> <1364738063-23868-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1364738063-23868-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Peter De Schrijver <pdeschrijver@nvidia.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

On Sunday 31 March 2013 07:24 PM, Pali Roh=C3=A1r wrote:
> Closed and signed Nokia X-Loader bootloader stored in RX-51 nand does=
 not set
> IBE bit in ACTLR and starting kernel in non-secure mode. So direct wr=
ite to
> ACTLR by our kernel does not working and the code for ARM errata 4309=
73 in
> commit 7ce236fcd6fd45b0441a2d49acb2ceb2de2e8a47 that sets IBE bit is =
a noop.
>=20
> In order to have workaround for ARM errata 430973 from non-secure wor=
ld on
> RX-51 we needs Secure Monitor Call to set IBE BIT in ACTLR.
>=20
> This patch adds RX-51 specific SMC support and sets IBE bit in ACTLR =
during
> board init code for ARM errata 430973 workaround.
>=20
> Because all the setup and what arguments are required for SMC are com=
pletely
> different from SoC to SoC it is not possible to create generic SMC ha=
ndling.
> Code in omap-smc.S looks identical but it is not. So RX-51 needs anot=
her code.
>=20
> ARM errata 430973 workaround is needed for thumb-2 ISA compiled users=
pace
> binaries. Without this workaround thumb-2 binaries crashing. So with =
this
> patch it is possible to recompile and run applications/binaries with =
thumb-2
> ISA on RX-51.
>=20
> Signed-off-by: Ivaylo Dimitrov <freemangordon@abv.bg>
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> ---
>  arch/arm/mach-omap2/Makefile            |    1 +
>  arch/arm/mach-omap2/board-rx51-secure.c |   66 +++++++++++++++++++++=
++++++++++
>  arch/arm/mach-omap2/board-rx51-secure.h |   36 +++++++++++++++++
>  arch/arm/mach-omap2/board-rx51-smc.S    |   34 ++++++++++++++++
>  arch/arm/mach-omap2/board-rx51.c        |    7 ++++
>  5 files changed, 144 insertions(+)
>  create mode 100644 arch/arm/mach-omap2/board-rx51-secure.c
>  create mode 100644 arch/arm/mach-omap2/board-rx51-secure.h
>  create mode 100644 arch/arm/mach-omap2/board-rx51-smc.S
>=20
> diff --git a/arch/arm/mach-omap2/board-rx51-smc.S b/arch/arm/mach-oma=
p2/board-rx51-smc.S
> new file mode 100644
> index 0000000..70e2eb7
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-rx51-smc.S
> @@ -0,0 +1,34 @@
You can avoid creating board-rx51-smc.S by having rx51_ppa_smc()
part of board-rx51-secure.c using inline asm. You can avoid the
board-rx51-secure.h as well considering the usage is limited to
the rx51 board.

Regards,
Santosh
