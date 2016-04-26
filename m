From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/5] DT Fixes for OMAP4 and OMAP5 boards
Date: Tue, 26 Apr 2016 10:28:10 -0700
Message-ID: <20160426172810.GJ5995@atomide.com>
References: <cover.1461003660.git.hns@goldelico.com>
 <1F57045F-FCD1-45F1-865B-E2324FACB581@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1F57045F-FCD1-45F1-865B-E2324FACB581@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Laxman Dewangan <ldewangan@nvidia.com>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [160426 08:02]:
> ping.
> 
> > Am 18.04.2016 um 20:20 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> > 
> > This patch series adds DT nodes for:
> > * twl6030 gpadc for omap4 based boards (Pandaboard ES)
> > * twl6037 gpadc for omap5 based board (OMAP5EVM)
> > * omap5-board-common: ckobuffer (needed for high quality twl6040 audio)
> > * fix range problem with omap5 pinmux
> > 
> > 
> > H. Nikolaus Schaller (5):
> >  ARM: dts: twl6030: describe gpadc
> >  ARM: dts: omap5-board-common: describe gpadc for Palmas
> >  ARM: dts: omap5: fix range of permitted wakeup pinmux registers
> >  ARM: dts: omap5: describe control for ckobuffer
> >  ARM: dts: omap5-board-common: set up ckobuffer for twl6040
> > 
> > arch/arm/boot/dts/omap5-board-common.dtsi | 24 ++++++++++++++++++++++++
> > arch/arm/boot/dts/omap5.dtsi              | 12 +++++++++++-
> > arch/arm/boot/dts/twl6030.dtsi            |  6 ++++++
> > 3 files changed, 41 insertions(+), 1 deletion(-)

Thanks for the reminder, I had somehow untagged this thread.
Picked one into fixes, two into next, and two Tero should
review.

Tony
