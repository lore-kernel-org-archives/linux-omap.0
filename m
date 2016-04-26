From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 0/5] DT Fixes for OMAP4 and OMAP5 boards
Date: Tue, 26 Apr 2016 17:00:33 +0200
Message-ID: <1F57045F-FCD1-45F1-865B-E2324FACB581@goldelico.com>
References: <cover.1461003660.git.hns@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461003660.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

ping.

> Am 18.04.2016 um 20:20 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> 
> This patch series adds DT nodes for:
> * twl6030 gpadc for omap4 based boards (Pandaboard ES)
> * twl6037 gpadc for omap5 based board (OMAP5EVM)
> * omap5-board-common: ckobuffer (needed for high quality twl6040 audio)
> * fix range problem with omap5 pinmux
> 
> 
> H. Nikolaus Schaller (5):
>  ARM: dts: twl6030: describe gpadc
>  ARM: dts: omap5-board-common: describe gpadc for Palmas
>  ARM: dts: omap5: fix range of permitted wakeup pinmux registers
>  ARM: dts: omap5: describe control for ckobuffer
>  ARM: dts: omap5-board-common: set up ckobuffer for twl6040
> 
> arch/arm/boot/dts/omap5-board-common.dtsi | 24 ++++++++++++++++++++++++
> arch/arm/boot/dts/omap5.dtsi              | 12 +++++++++++-
> arch/arm/boot/dts/twl6030.dtsi            |  6 ++++++
> 3 files changed, 41 insertions(+), 1 deletion(-)
> 
> -- 
> 2.7.3
> 
