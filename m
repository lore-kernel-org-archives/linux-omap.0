From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Date: Tue, 27 Nov 2018 10:17:46 -0800
Message-ID: <20181127181746.GU53235@atomide.com>
References: <20181119161906.GP53235@atomide.com>
 <20181119171406.GQ53235@atomide.com>
 <725df8e7-4aff-3751-d0b0-809b89e882e5@nvidia.com>
 <20181123164827.GE53235@atomide.com>
 <20181126093625.GA10878@ulmo>
 <d3f17ac6-c13b-5b5f-a482-b565b130f1ba@ti.com>
 <20181126102541.GC10878@ulmo>
 <20181126193212.GN53235@atomide.com>
 <149b3b6b-e52e-4942-151b-6df4358f5a7a@nvidia.com>
 <20181127175538.GS53235@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181127175538.GS53235@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Belisko Marek <marek.belisko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [181127 17:55]:
> The only option that works for omap5 at palmas end is if
> PALMAS_POLARITY_CTRL_INT_POLARITY is cleared. Setting the SoC internal
> pulls does not make a difference, so I suspect there is either some
> unknown pull-up/pull-down configuration register in palmas, or there
> is an external pull resistor.

Remuxing the palmas interrupt to gpio_wk16 instead of sys_nirq1
makes the palmas interrupt work just fine configured with active-low
or active-high with the internal pulls. So palmas.c is doing the
right thing, and the issue configuring palmas interrupt active-high
with sys_nirq1 on omap5 is somewhere between omap wkupegen and GIC.

Regards,

Tony
