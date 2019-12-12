From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: dts: am5729: beaglebone-ai: adding device tree
Date: Thu, 12 Dec 2019 09:04:52 -0800
Message-ID: <20191212170452.GV35479@atomide.com>
References: <20191120220559.18914-1-c-robey@ti.com>
 <41c73bc1-99ae-6797-5bb7-7acc0f6518c0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <41c73bc1-99ae-6797-5bb7-7acc0f6518c0@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Caleb Robey <c-robey@ti.com>, linux-omap@vger.kernel.org, Jason Kridner <jkridner@gmail.com>, Lokesh Vutla <lokeshvutla@ti.com>, Jason Kridner <jdk@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, "Andrew F . Davis" <afd@ti.com>, Tom Rini <trini@konsulko.com>, Robert Nelson <robertcnelson@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [191121 11:08]:
> 
> 
> On 21/11/2019 00:05, Caleb Robey wrote:
> > From: Jason Kridner <jdk@ti.com>
> > 
> > BeagleBoard.org BeagleBone AI is an open source hardware single
> > board computer based on the Texas Instruments AM5729 SoC featuring
> > dual-core 1.5GHz Arm Cortex-A15 processor, dual-core C66 digital
> > signal processor (DSP), quad-core embedded vision engine (EVE),
> > Arm Cortex-M4 processors, dual programmable realtime unit
> > industrial control subsystems and more. The board features 1GB
> > DDR3L, USB3.0 Type-C, USB HS Type-A, microHDMI, 16GB eMMC flash,
> > 1G Ethernet, 802.11ac 2/5GHz, Bluetooth, and BeagleBone expansion
> > headers.
> > 
> > For more information, refer to:
> > https://beaglebone.ai
> > 
> > This patch introduces the BeagleBone AI device tree.
> > 
> > Note that the device use the "ti,tpd12s016" component which is
> > software compatible with "ti,tpd12s015". Thus we only use the
> > latter driver.
> 
> Ah. thanks. I see my comments resolved here.
> no more comments to net part from my side.

Just FYI, Jason had one pending comment on the earlier version
about the compatible property to use.

So I'm assuming there will be a new version posted, tagging
this one as read.

Regards,

Tony
