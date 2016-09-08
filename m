From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] of: Add generic handling for ePAPR 1.1 fail-sss states
Date: Thu, 8 Sep 2016 08:58:30 -0700
Message-ID: <20160908155830.ov5so3vm2kmmccty@atomide.com>
References: <20160829223542.18871-1-tony@atomide.com>
 <57C74306.9020901@gmail.com>
 <20160831214151.wzq7y54xxs2qj422@atomide.com>
 <CAL_Jsq+dm5HMkX8DNNZNB2QF-VPg96Esb+Capv88zys9nAPksw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+dm5HMkX8DNNZNB2QF-VPg96Esb+Capv88zys9nAPksw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Tom Rini <trini@konsulko.com>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh+dt@kernel.org> [160908 06:38]:
> On Wed, Aug 31, 2016 at 4:41 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Frank Rowand <frowand.list@gmail.com> [160831 13:51]:
> >> I am still opposed to using the status property for this purpose.
> >>
> >> The status property is intended to report an operational problem with
> >> a device or a device that the kernel can cause to be operational (such
> >> as a quiescent cpu being enabled).  It is the only property I am aware
> >> of to report _state_.
> 
> Yes, in theory a device can go from disabled to okay, but that's
> generally never been supported. Linux takes the simple approach of
> "disabled" means ignore it. I think we'll see that change with
> overlays.

Yeah I think we have to assume that.

> >> It is unfortunate that Linux has adopted the practice of overloading status
> >> to determine whether a piece of hardware exists or does not exist.  This
> >> is extremely useful for the way we structure the .dts and .dtsi files but
> >> should have used a new property name.  We are stuck with that choice of
> >> using the status property for two purposes, first the state of a device,
> >> and secondly the hardware description of existing or not existing.
> 
> I don't agree. Generally, disabled means the h/w is there, but don't
> use it. There may be some cases where the hardware doesn't exist for
> the convenience of having a single dts, but that's the exception.
> 
> >> Why not just create a new property that describes the hardware?
> >> Perhaps something like:
> >>
> >>    incomplete = "pins_output", "buggy_dma";
> >
> > New property for incomplete works for me. Rob, got any comments here?
> 
> Pins not muxed out or connected on the board has to be the #1 reason
> for disabled status. I don't think we need or want another way to
> express that.

Both status and and a separate property work for me.

If no other considerations, we should probably pick something with a
a limited set of states to avoid it getting out of control and being
misused for something weird like driver probe order..

For example, just status = "fail" would be enough for the cases I've
seen. That would still allow probe the device, then PM runtime idle
it and bail out with -ENODEV.

For whatever warnings or errors the driver needs to show, the driver
could probably figure it out. I don't know if we want to or need to
pass any informational messages with the incomplete status or
property :)

> We may have discussed this, but why can't the driver that checks fail
> state just check whatever was used to set the device to fail in the
> first place?

Well there may be no way to check if something is pinned out based on
the hardware. The same SoC can be packaged with different pins. In that
case only the die id or serial number for each produced chip is
different, not the revision numbers. So for cases like that the dtb
file or kernel cmdline is the only information available. And we can't
assume pinctrl is required as it's perfectly fine to do that only in
the bootloader for the static cases to save memory.

Just to consider other ways of doing it, we could use the compatible
flag to tag devices that need to be just idled on probe, but that does
not seem like generic solution to me.

Regards,

Tony
