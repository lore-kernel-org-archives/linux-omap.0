From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v3 0/5] common clk framework
Date: Tue, 22 Nov 2011 11:12:26 -0800
Message-ID: <20111122191226.GA4844@kroah.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <20111122154259.GA18954@kroah.com>
 <20111122174544.GA19739@n2100.arm.linux.org.uk>
 <CAPtuhTgFPZA9U-8heNw1eNUnHLFv2w+LzXg5rdjSx3J53Xy+2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPtuhTgFPZA9U-8heNw1eNUnHLFv2w+LzXg5rdjSx3J53Xy+2g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Mike Turquette <mturquette@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jeremy.kerr@canonical.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, paul@pwsan.com, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 22, 2011 at 10:09:29AM -0800, Mike Turquette wrote:
> On Tue, Nov 22, 2011 at 9:45 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Nov 22, 2011 at 07:42:59AM -0800, Greg KH wrote:
> >> On Mon, Nov 21, 2011 at 05:40:42PM -0800, Mike Turquette wrote:
> >> > =A0 .sysfs support. =A0Visualize your clk tree at /sys/clk! =A0W=
here would be
> >> > a better place to put the clk tree besides the root of /sys/?
> >>
> >> Um, in the "proper" place for it under /sys/devices like the rest =
of the
> >> device tree is?
> >
> > I'd suggest that making the clock tree visible in sysfs (and theref=
ore
> > part of the kernel ABI) is not a good idea. =A0Some of the nodes in=
 there
> > will be specific to the implementation. =A0Exposing the clock nodes=
 means
> > that if you have to change the clock tree structure, you change the
> > visible userspace ABI.
>=20
> It is true that the ABI will change dynamically.
>=20
> >
> > So, I'd suggest that we need to see a justification for this, rathe=
r
> > than exposing this stuff via debugfs as has been done with existing
> > implementations.
>=20
> Userspace tools like powerdebug (and maybe someday powertop) hope to
> use a reliable-looking interface to view clk data.  There are obvious
> uses for this data in a debug tool, the most obvious of which is
> "which clk isn't turning off when it should?".
>=20
> I can migrate this stuff to debugfs, but it adds the burden of having
> debugfs enabled for folks that want to view this data.  I would also
> argue that sysfs is there to model various aspects of system topology
> and a clk tree certainly fits the bill.
>=20
> If others also agree that it should reside only in debugfs then I'll
> move it there for V4.

If it's only for debug stuff, then yes, it belongs in debugfs.  All
distros turn debugfs on these days, and for an embedded system, the cod=
e
is quite small so there should not be much overhead.

thanks,

greg k-h
