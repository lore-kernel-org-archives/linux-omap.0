From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V7 3/8] ARM: OMAP3+: use cpu0-cpufreq driver in device
 tree supported boot
Date: Tue, 22 Oct 2013 08:11:35 -0700
Message-ID: <20131022151135.GN15154@atomide.com>
References: <1381937948-27057-1-git-send-email-nm@ti.com>
 <1381937948-27057-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381937948-27057-4-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [131016 08:39]:
> With OMAP3+ and AM33xx supported SoC having defined CPU device tree
> entries with operating-points and clock nodes defined, we can now use
> the SoC generic cpufreq-cpu0 driver by registering appropriate device.

Thanks I'm taking patches 1 - 3 from this series into
omap-for-v3.13/board-removal-take2 because of the dependencies.

Tony
