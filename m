From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 2/3] ARM: dts: twl4030: Add missing madc reference for
 bci subnode
Date: Tue, 6 Jun 2017 00:23:58 -0700
Message-ID: <20170606072358.GT3730@atomide.com>
References: <cover.1495363097.git.hns@goldelico.com>
 <69d95172f257cee8d6abc1eaab57865e536be73c.1495363097.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <69d95172f257cee8d6abc1eaab57865e536be73c.1495363097.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, Marek Belisko <marek@goldelico.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [170521 03:44]:
> From: Marek Belisko <marek@goldelico.com>
> 
> The twl4030_charger driver expects an iio channel to detect the
> presence of an AC charger by looking at VAC (madc channel 11).
> This definition is missing in the device tree.

I'm picking this patch into omap-for-v4.13/dt thanks.

Tony
