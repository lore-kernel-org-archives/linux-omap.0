From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] Adding DT support for TI HECC module
Date: Mon, 16 Jan 2017 09:38:44 -0800
Message-ID: <20170116173844.GD7403@atomide.com>
References: <1484143521-4898-1-git-send-email-yegorslists@googlemail.com>
 <CAGm1_kvWXfZ_f3PPL1VJj8AhBf59Pax_GFHDVdejuMBRDu9y6Q@mail.gmail.com>
 <20170112004757.GZ2630@atomide.com>
 <CAGm1_kvNcmpayN-=mMmkCn1=wXaykhENUrHK2-MVmZLC+Cca0Q@mail.gmail.com>
 <20170112154155.GA2630@atomide.com>
 <CAGm1_kvSeFDjtb4=it4uwXywrKj0S=Df4u5Aozh0ALOjwvHNDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGm1_kvSeFDjtb4=it4uwXywrKj0S=Df4u5Aozh0ALOjwvHNDw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, robh+dt@kernel.org, Andrey Skvortsov <andrej.skvortzov@gmail.com>, hs@denx.de, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

* Yegor Yefremov <yegorslists@googlemail.com> [170116 01:36]:
> On Thu, Jan 12, 2017 at 4:41 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Yegor Yefremov <yegorslists@googlemail.com> [170112 00:00]:
> >> On Thu, Jan 12, 2017 at 1:47 AM, Tony Lindgren <tony@atomide.com> wrote:
> >> > * Yegor Yefremov <yegorslists@googlemail.com> [170111 13:52]:
> >> >> On Wed, Jan 11, 2017 at 3:05 PM,  <yegorslists@googlemail.com> wrote:
> >> >> > From: Yegor Yefremov <yegorslists@googlemail.com>
> >> >> >
> >> >> > This is an attempt to revive DT support for TI HECC that was started in 2015.
> >> >> >
> >> >> > I haven't changed much because not all questions could be fully answered:
> >> >> >
> >> >> > * Should HECC use "am3505" as compatible?
> >> >>
> >> >> I mean "ti,am3505-hecc"
> >> >
> >> > Yeah it should use the device name for the driver.
> >> >
> >> >> > * What should be done to the offsets (ti,scc-ram-offset, ti,hecc-ram-offset, ti,mbx-offset)?
> >> >
> >> > The devicetree maintainers need to ack the binding doc. Maybe
> >> > send that as a first patch?
> >>
> >> The question is whether to place these settings into dtsi (as it was
> >> done in the original patch) or in the driver itself.
> >
> > Well where are they on the SoC? Each driver should only access registers
> > that belong to the driver module.
> >
> > If the ti,scc-ram-offset and ti,hecc-ram-offset are not within the ECC
> > driver module, probably you should use a separate driver for them
> > such as drivers/misc/sram.c.
> >
> > Also, sounds like the ti,mbx-offset should just be using the mailbox
> > framework like remoteproc is doing with include/linux/omap-mailbox.h?
> 
> AFAIK all offsets are in RAM and belong to ioremapped space:
> 
>         mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (!mem) {
>                 dev_err(&pdev->dev, "No mem resources\n");
>                 goto probe_exit;
>         }
>         irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>         if (!irq) {
>                 dev_err(&pdev->dev, "No irq resource\n");
>                 goto probe_exit;
>         }
>         if (!request_mem_region(mem->start, resource_size(mem), pdev->name)) {
>                 dev_err(&pdev->dev, "HECC region already claimed\n");
>                 err = -EBUSY;
>                 goto probe_exit;
>         }
>         addr = ioremap(mem->start, resource_size(mem));
>         if (!addr) {
>                 dev_err(&pdev->dev, "ioremap failed\n");
>                 err = -ENOMEM;
>                 goto probe_exit_free_region;

If these are all within the HECC address space, then all you need
is just multiple reg entries and "reg-names" property.
Then the driver can get the reg entry by name and no custom properties
are needed for those.

Regards,

Tony
