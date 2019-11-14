From: Tony Lindgren <tony@atomide.com>
Subject: Re: [uL PATCH 1/2] ARM: dts: am5729: beaglebone-ai: adding device
 tree
Date: Thu, 14 Nov 2019 08:50:13 -0800
Message-ID: <20191114165013.GP5610@atomide.com>
References: <20191113221345.4795-1-c-robey@ti.com>
 <20191113221345.4795-2-c-robey@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191113221345.4795-2-c-robey@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caleb Robey <c-robey@ti.com>
Cc: linux-patch-review@list.ti.com, Jason Kridner <jkridner@gmail.com>, Lokesh Vutla <lokeshvutla@ti.com>, Jason Kridner <jdk@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, "Andrew F . Davis" <afd@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Caleb Robey <c-robey@ti.com> [191113 22:15]:
> From: Jason Kridner <jdk@ti.com>
> 
> BeagleBoard.org BeagleBone AI is an open source hardware single
> board computer based on the Texas Instruments AM5729 SoC featuring
> dual-core 1.5GHz Arm Cortex-A15 processor, dual-core C66 digital
> signal processor (DSP), quad-core embedded vision engine (EVE),
> Arm Cortex-M4 processors, dual programmable realtime unit
> industrial control subsystems and more. The board features 1GB
> DDR3L, USB3.0 Type-C, USB HS Type-A, microHDMI, 16GB eMMC flash,
> 1G Ethernet, 802.11ac 2/5GHz, Bluetooth, and BeagleBone expansion
> headers.
> 
> For more information, refer to:
> https://beaglebone.ai
> 
> This patch introduces the BeagleBone AI device tree.
> 
> Note that the device use the "ti,tpd12s016" component which is
> software compatible with "ti,tpd12s015". Thus we only use the
> latter driver.
> 
> Signed-off-by: Jason Kridner <jdk@ti.com>
> Cc: Robert Nelson <robertcnelson@gmail.com>
> Cc: Caleb Robey <c-robey@ti.com>

Hmm so this one has "From: Jason Kridner <jdk@ti.com>", but
seems like you may have updated it and are sending it out,
so it probably should also have your Signed-off-by.

Note that you can summarize your additions with something like:

Signed-off-by: Jason Kridner <jdk@ti.com>
[c-robey@ti.com: fixed up xyz against mainline kernel]
Signed-off-by: ...

Regards,

Tony
