From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 5/8] remoteproc: new driver for TI PRU
Date: Mon, 2 Jul 2018 11:05:04 +0300
Message-ID: <d331a7dc-9fb0-aa05-36e6-3e1373b6fd16@ti.com>
References: <20180623210810.21232-1-david@lechnology.com>
 <20180623210810.21232-6-david@lechnology.com>
 <ce87a7dc-ecf6-f3fd-9121-bf99216f7412@ti.com>
 <CA+CtpRhQ07=3UytY7QrfnpWkY06UqHbNVq099Coez3C4H3U5yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+CtpRhQ07=3UytY7QrfnpWkY06UqHbNVq099Coez3C4H3U5yg@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Derald Woods <woods.technical@gmail.com>
Cc: David Lechner <david@lechnology.com>, linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org, "Anna, Suman" <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Derald,

On 30/06/18 22:02, Derald Woods wrote:
> 
> 
> On Fri, Jun 29, 2018 at 5:14 AM, Roger Quadros <rogerq@ti.com <mailto:rogerq@ti.com>> wrote:
> 
> 
> 
>     On 24/06/18 00:08, David Lechner wrote:
>     > This adds a new remoteproc driver for TI Programmable Realtime Units
>     > (PRUs).
>     >
>     > This has been tested working on AM1808 (LEGO MINDSTORMS EV3) using the
>     > sample rpmsg client driver.
>     >
>     > Signed-off-by: David Lechner <david@lechnology.com <mailto:david@lechnology.com>>
>     > ---
>     >  MAINTAINERS                       |   5 +
>     >  drivers/remoteproc/Kconfig        |   7 +
>     >  drivers/remoteproc/Makefile       |   1 +
>     >  drivers/remoteproc/ti_pru_rproc.c | 660 ++++++++++++++++++++++++++++++
>     >  4 files changed, 673 insertions(+)
>     >  create mode 100644 drivers/remoteproc/ti_pru_rproc.c

<snip>

> 
>     We already have a working irq_chip implementation for INTC.
>     https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/drivers/remoteproc/pruss_intc.c <https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/drivers/remoteproc/pruss_intc.c>
> 
>     I think we can leverage directly from that.
> 
>     This way pru_rproc or client device nodes can easily specify a pruss_intc interrupt parent and the
>     SYSEVENT number as the irq. Then device drivers can simply use request_irq().
> 
>     example usage here
>     https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/arch/arm/boot/dts/am33xx.dtsi#line986 <https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/arch/arm/boot/dts/am33xx.dtsi#line986>
>     https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/drivers/remoteproc/pru_rproc.c#line670 <https://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-4.14.y/drivers/remoteproc/pru_rproc.c#line670>
> 
> 
> 
> 
> ​Is this PRU code on a path to be added to the mainline kernel?​ There is an increase in the number of available systems which would benefit from consistent PRU interfaces. If code is not mainlined, or on a mainline path, some may think it is not usable or ready for production. Is this a permanent "out-of-tree" and/or "TI-tree" development. Just wondering.
> 

Yes, we constantly upstream our work. We are currently working to get the PRU support upstream.

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
