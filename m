From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
Date: Fri, 1 Mar 2013 11:43:14 +0200
Message-ID: <20130301094314.GG23234@tbergstrom-lnx.Nvidia.com>
References: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ivaylo Dimitrov <freemangordon@abv.bg>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 28, 2013 at 10:42:28AM +0100, Pali Roh=E1r wrote:
> Signed-off-by: Ivaylo Dimitrov <freemangordon@abv.bg>
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
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

Is this necessary? I thought the PPA sets this bit?

Cheers,

Peter.
