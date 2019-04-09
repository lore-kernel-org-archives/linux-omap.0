From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/5] ARM: OMAP: Wakeupgen: AM43xx HS devices should save
 context like non-HS
Date: Tue, 9 Apr 2019 08:08:56 -0700
Message-ID: <20190409150856.GH2839@atomide.com>
References: <20190329175336.19824-1-afd@ti.com>
 <20190329175336.19824-4-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190329175336.19824-4-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Kevin Hilman <khilman@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [190329 17:53]:
> Unlike some previous generation devices, AM43xx HS IRQ and Wakegen
> context is handled by the ROM for us, and no secure service call
> is needed or supported. Non-GP AM43xx devices should take the
> same path as GP.

Applying the two SoC related changes into omap-for-v5.2/soc.

Tony
