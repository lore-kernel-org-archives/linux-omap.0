From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] dts: omap5: board-common: fix wrong SMPS6 (VDD-DDR3)
 voltage
Date: Mon, 14 Nov 2016 13:17:15 -0800
Message-ID: <20161114211714.GV7138@atomide.com>
References: <9718ff02c1c863e97bf1247009db8292fcff7d8d.1479124514.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9718ff02c1c863e97bf1247009db8292fcff7d8d.1479124514.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [161114 03:55]:
> DDR3L is usually specified as
> 
> 	JEDEC standard 1.35V(1.28V~1.45V) & 1.5V(1.425V~1.575V)
> 
> Therefore setting smps6 regulator to 1.2V is definitively below
> minimum. It appears that real world chips are more forgiving than
> data sheets indicate, but let's set the regulator right.
> 
> Note: a board that uses other voltages (DDR with 1.5V) can
> overwrite by referencing &smps6_reg.

Applying into omap-for-v4.9/fixes thanks.

Tony
