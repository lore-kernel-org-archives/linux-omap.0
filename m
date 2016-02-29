From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 5/5] ARM: multi_v7_defconfig: Enable LP872x regulator support
Date: Mon, 29 Feb 2016 22:58:32 +0100
Message-ID: <3559918.7gA8u2p4Bl@wuerfel>
References: <1456663185-14170-1-git-send-email-contact@paulk.fr> <1456663185-14170-6-git-send-email-contact@paulk.fr> <20160229215446.GP13417@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160229215446.GP13417@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Kocialkowski <contact@paulk.fr>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday 29 February 2016 13:54:46 Tony Lindgren wrote:
> * Paul Kocialkowski <contact@paulk.fr> [160228 04:40]:
> > The LP872x regulator is used in the LG Optimus Black codename sniper to supply
> > the external mmc card.
> 
> This patch needs to be sent directly to arm@kernel.org to avoid
> merge conflicts. I've picked the omap2plus_defconfig related change
> into omap-for-v4.6/defconfig.

I'd actually prefer it as part of the omap-for-v4.6/defconfig branch.
Taking care of merge conflicts is easy.

	Arnd
