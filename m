From: Tony Lindgren <tony@atomide.com>
Subject: Re: PROBLEM: bindings for drivers/mfd/twl4030-power.c
Date: Mon, 25 Aug 2014 14:26:54 -0700
Message-ID: <20140825212652.GR17254@atomide.com>
References: <FAC7D7E5-1D05-4D63-821F-C56D3AAA8FF9@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <FAC7D7E5-1D05-4D63-821F-C56D3AAA8FF9@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Lee Jones <lee.jones@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Dr. H. Nikolaus Schaller <hns@goldelico.com> [140817 08:46]:
> I am trying to make ti,use_poweroff work on 3.17-rc1 for the GTA04 board.
> Poweroff was broken for a while and I found that the driver isn't loaded at all.
> 
> It appears to me that commit e7cd1d1eb16fcdf53001b926187a82f1f3e1a7e6
> did rename the compatible entry from "ti,twl4030-power" to "ti,twl4030-power-reset"
> but this was not documented in the bindings and of course our DT does not
> match.
> 
> Even your commit message talks about "ti,twl4030-power" although I can't find it
> in the code.

Hmm sorry did I accidentally remove ti,twl4030-power? If so, that should
be added back for sure. Do you have a patch for that already?
 
> Are "ti,twl4030-power" and "ti,twl4030-power-reset" doing the same?

No, they are separate where ti,twl4030-power does not configure the
twl4030 in any way where ti,twl4030-power-reset configures the warm
reset sequence.

For gta04, what you really want is to use ti,twl4030-power-idle or
even ti,twl4030-power-idle-osc-off if the board is wired to support
cutting off the oscillator.

And you probably also want to configure some wake-up interrupts at least
for the the UARTs in the board specific .dts file, see for example the
UART3 in the existing board files that have:

interrupts-extended = <&intc 74 &omap3_pmx_core OMAP3_UART3_RX>;

Regards,

Tony
