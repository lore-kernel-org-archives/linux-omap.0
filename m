From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: irqchip: Add PRUSS interrupt controller bindings
Date: Thu, 25 Jul 2019 16:27:48 -0600
Message-ID: <CAL_JsqJz9eDOMPA=HbvZ3W_h5XMaW8uah7dq6k474MBnSmrq4Q@mail.gmail.com>
References: <20190708035243.12170-1-s-anna@ti.com> <20190708035243.12170-2-s-anna@ti.com>
 <20190724163419.GA29254@bogus> <6871c381-9fc6-f6be-6386-f183fcc5546a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6871c381-9fc6-f6be-6386-f183fcc5546a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Tony Lindgren <tony@atomide.com>, "Andrew F. Davis" <afd@ti.com>, Roger Quadros <rogerq@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>, Murali Karicheri <m-karicheri2@ti.com>, devicetree@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 24, 2019 at 1:42 PM Suman Anna <s-anna@ti.com> wrote:
>
> On 7/24/19 11:34 AM, Rob Herring wrote:
> > On Sun, 7 Jul 2019 22:52:38 -0500, Suman Anna wrote:
> >> The Programmable Real-Time Unit Subsystem (PRUSS) contains an interrupt
> >> controller (INTC) that can handle various system input events and post
> >> interrupts back to the device-level initiators. The INTC can support
> >> upto 64 input events on most SoCs with individual control configuration
> >> and hardware prioritization. These events are mapped onto 10 interrupt
> >> lines through two levels of many-to-one mapping support. Different
> >> interrupt lines are routed to the individual PRU cores or to the
> >> host CPU or to other PRUSS instances.
> >>
> >> The K3 AM65x and J721E SoCs have the next generation of the PRU-ICSS IP,
> >> commonly called ICSSG. The ICSSG interrupt controller on K3 SoCs provide
> >> a higher number of host interrupts (20 vs 10) and can handle an increased
> >> number of input events (160 vs 64) from various SoC interrupt sources.
> >>
> >> Add the bindings document for these interrupt controllers on all the
> >> applicable SoCs. It covers the OMAP architecture SoCs - AM33xx, AM437x
> >> and AM57xx; the Keystone 2 architecture based 66AK2G SoC; the Davinci
> >> architecture based OMAPL138 SoCs, and the K3 architecture based AM65x
> >> and J721E SoCs.
> >>
> >> Signed-off-by: Suman Anna <s-anna@ti.com>
> >> Signed-off-by: Andrew F. Davis <afd@ti.com>
> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >> ---
> >> Prior version: https://patchwork.kernel.org/patch/10795771/
> >>
> >>  .../interrupt-controller/ti,pruss-intc.txt    | 92 +++++++++++++++++++
> >>  1 file changed, 92 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.txt
> >>
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >
>
> Thanks Rob. I am going to submit a v2 with some minor reword changes
> based on couple of comments, but no addition or removal of properties.
> Should I be retaining your Reviewed-by for v2?

Yes.
