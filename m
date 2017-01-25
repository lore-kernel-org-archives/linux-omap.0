From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/7] Implement generic regulator constraints parsing for
 ACPI and OF
Date: Wed, 25 Jan 2017 18:23:20 +0000
Message-ID: <20170125182319.GB25470@leverpostej>
References: <20170125000641.25520-1-furquan@chromium.org>
 <20170125124911.dxveow7bo3zw5jcc@sirena.org.uk>
 <CAJZ5v0hHSadH1KLOGg029VU2qrY900ak0=NnH5HPBKZ=FpB7HQ@mail.gmail.com>
 <CAEGmHFG1d24k3+qT_aoqRmPFzciAbNObCnzY1d8pQWjEW+3HxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEGmHFG1d24k3+qT_aoqRmPFzciAbNObCnzY1d8pQWjEW+3HxA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Furquan Shaikh <furquan@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>Lin
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 25, 2017 at 08:56:42AM -0800, Furquan Shaikh wrote:
> I understand that ACPI provides its own bindings to allow firmware to
> control power management and thus regulators have been a part of the
> firmware control. However, there are use cases where the kernel driver
> wishes to control the regulator to manage power to the device
> irrespective of the way regulator is passed in (ACPI/OF).

It sounds like there is a deficiency in the ACPI spec, then.  That being
the case, this should be addressed within the ACPI spec (or at least in
conjunction with it), rather than attaching something unrelated onto the
side.

There are a number of problems with this approach, and other OSs are
facing the same set of problems. The ACPI spec and the ASWG are supposed
to provide a common ground where such issues get dealt with.

Using DSD to bypass the ASWG is creating a large set of problems for a
trivial expedience.

> That is the reason why the recent change to add ACPI support to fixed
> regulators was done
> (https://github.com/torvalds/linux/blob/master/drivers/regulator/fixed.c#L100).

To be honest, I'm surprised this got merged.

Mark, this was added in this cycle; can we please rip that out for now?

> It needs regulators for USB driver. Similarly, other drivers like ELAN
> touchscreen that plan to control power to the device in a generic way
> irrespective of OF/ACPI need to control regulators in kernel itself.
> The above change for adding ACPI support to fixed regulators is
> currently parsing only limited parameters and also does not work the
> same way for ACPI and OF, though it ends to introduce the regulators
> in a way similar to OF.

Having a consistent API is desirable. That does not imply that we should
invent a non-standard FW representation in ACPI, nor does it imply that
an API we have today is necessarily appropriate.

There are a number of different ways this could be addressed.

> We need to support existing drivers and use cases for power management
> in both OF and ACPI environments (keeping in mind that suspend to idle
> bypasses parts of firmware) without needing to change all the drivers.

I think that the goal here is broken, given existing model differences
between ACPI and DT.

We can certainly come up with something that allows drivers to support
both, but trying to do this without updating drivers opens a huge set of
problems.

Thanks,
Mark.
