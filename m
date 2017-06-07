From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v5 2/3] ARM: dts: twl4030: Add missing madc reference for bci subnode
Date: Wed, 7 Jun 2017 11:50:36 +0200
Message-ID: <86926E09-93B8-4C17-BD98-C1340CA48F21@goldelico.com>
References: <cover.1495363097.git.hns@goldelico.com> <69d95172f257cee8d6abc1eaab57865e536be73c.1495363097.git.hns@goldelico.com> <20170606072358.GT3730@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170606072358.GT3730@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, Marek Belisko <marek@goldelico.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


> Am 06.06.2017 um 09:23 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [170521 03:44]:
>> From: Marek Belisko <marek@goldelico.com>
>> 
>> The twl4030_charger driver expects an iio channel to detect the
>> presence of an AC charger by looking at VAC (madc channel 11).
>> This definition is missing in the device tree.
> 
> I'm picking this patch into omap-for-v4.13/dt thanks.

Thanks and BR!
Nikolaus
