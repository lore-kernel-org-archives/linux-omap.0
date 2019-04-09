From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] ARM: dts: am43xx-epos-evm: Keep DCDC5 and DCDC6
 always on
Date: Tue, 9 Apr 2019 08:08:30 -0700
Message-ID: <20190409150830.GG2839@atomide.com>
References: <20190329175336.19824-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190329175336.19824-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Kevin Hilman <khilman@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [190329 10:53]:
> From: Kabir Sahane <x0153567@ti.com>
> 
> These regulator outputs are needed even in deep sleep modes to prevent
> low-voltage detection events. Make these always ON to avoid this.

Thanks applying the three dts changes into omap-for-v5.2/dt.

Regards,

Tony
