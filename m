From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4] DTS: ARM: =?utf-8?Q?OMAP5?=
 =?utf-8?Q?=3A_uevm=3A_add_=C2=B5SD?= card detect
Date: Tue, 16 May 2017 09:47:17 -0700
Message-ID: <20170516164717.GM31418@atomide.com>
References: <90e9c1d71ce9ee47b55f4c0794e582167c6b961d.1494837075.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <90e9c1d71ce9ee47b55f4c0794e582167c6b961d.1494837075.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [170515 01:35]:
> If we have Linux installed in eMMC we can boot without
> µSD card, but inserting one is not recognised.
> 
> The reason is that the card detect gpio (gpio5_152)
> is not configured and attached to the mmc1 interface
> driver and the mmc driver does not poll by default.
> 
> Hence we add pinmux and gpio setup for the SDCARD_NCD
> signal.

Applying into omap-for-v4.13/dt thanks.

Tony
