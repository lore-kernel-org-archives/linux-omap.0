From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCHv3 2/7] clk: ti: add clkdev get helper
Date: Tue, 12 Jul 2016 10:40:17 -0700
Message-ID: <146834521716.73491.12539128897634971676@resonance>
References: <1467296018-25086-1-git-send-email-t-kristo@ti.com>
 <1467296018-25086-3-git-send-email-t-kristo@ti.com>
 <20160712102228.GE5783@n2100.arm.linux.org.uk> <57850A29.4010806@ti.com>
 <20160712153418.GF5783@n2100.arm.linux.org.uk> <5785117B.4050907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <5785117B.4050907@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, paul@pwsan.com, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Tero Kristo (2016-07-12 08:49:15)
> On 12/07/16 18:34, Russell King - ARM Linux wrote:
> > On Tue, Jul 12, 2016 at 06:18:01PM +0300, Tero Kristo wrote:
> >> On 12/07/16 13:22, Russell King - ARM Linux wrote:
> >>> On Thu, Jun 30, 2016 at 05:13:33PM +0300, Tero Kristo wrote:
> >>>>   /**
> >>>> + * ti_clk_get - lookup a TI clock handle
> >>>> + * @dev_id: device to lookup clock for
> >>>> + * @con_id: connection ID to find
> >>>> + *
> >>>> + * Searches for a TI clock handle based on the DT node name.
> >>>> + * Returns the pointer to the clock handle, or ERR_PTR in failure.
> >>>> + */
> >>>> +static struct clk *ti_clk_get(const char *dev_id, const char *con_id)
> >>>> +{
> >>>> +  struct of_phandle_args clkspec;
> >>>> +  struct device_node *node;
> >>>> +  struct clk *clk;
> >>>> +
> >>>> +  /* Only check for cases of type clk_get_sys(NULL, "xyz") */
> >>>> +  if (dev_id || !con_id)
> >>>> +          return ERR_PTR(-ENOENT);
> >>>> +
> >>>> +  if (of_have_populated_dt()) {
> >>>> +          node = of_find_node_by_name(NULL, con_id);
> >>>> +          clkspec.np = node;
> >>>> +          clk = of_clk_get_from_provider(&clkspec);
> >>>> +
> >>>> +          if (!IS_ERR(clk))
> >>>> +                  return clk;
> >>>> +  }
> >>>> +
> >>>> +  return ERR_PTR(-ENOENT);
> >>>> +}
> >>>
> >>> I _really_ don't like this.  This takes us back to the totally broken
> >>> idea, that's already been proven to be greatly harmful in OMAP land,
> >>> that the "con_id" is not a _DEVICE SPECIFIC CONNECTION NAME_ but is a
> >>> CLOCK NAME.  The connection ID is supposed to be a static string in
> >>> the requestor of the clock, not some random string picked out from
> >>> DT.
> >>
> >> What is the harm in that actually? I have most likely missed some discussion
> >> but please educate me.
> >
> > The problem is that we end up with drivers that we end up needing platform
> > information to know what clocks they should get, and what "connection names"
> > to use to get their clocks.
> >
> > We've been there before with OMAP, pre-DT times, and I fixed it up by
> > creating clkdev and converting much of OMAP over to clkdev, doing
> > everything the right way.  Now, we're heading around the same mistake
> > that I already solved several years ago.
> >
> > It's _well_ documented that the _connection id_ is a connection id and
> > not a clock name.  It's been documented that way ever since the clk API
> > was first published, and I'm on record for having brought up this point
> > _many_ times.
> 
> Yeah I know this is documented this way, the problem is we have plenty 
> of code around which doesn't really use it this way. >.<
> 
> >
> > So, when I see something reintroducing ways to persist with this crap,
> > I'm just not going to allow it.  This is 2016 after all, it's a full
> > _ten_ years after this API was created.
> 
> Ok fair enough, lets try to figure out something else. I was pretty much 
> worried before posting this patch/approach that you will shoot it down, 
> thus was requesting your feedback specifically. :P
> 
> >
> >> The problem is, we are already using this convention
> >> all over the place in the kernel (not only OMAPs), and trying to clean up
> >> the kernel requires some intermediate steps being taken, otherwise we end up
> >> doing all the clean-ups in a single massive patch I fear (change all the
> >> hwmod data + clock data + any implementations related to these at the same
> >> time.)
> >
> > This isn't an intermediate step if you're having to put stuff into DT
> > in order to support it.  Anything you throw into DT needs to be supported
> > for years by the kernel, since we have the requirement that newer kernels
> > are bootable with older DT files without regression.  That effectively
> > means we'll never be able to remove this, and we'll end up fighting other
> > people abusing the hook.
> >
> >> That is true, it will end up adding new DT nodes. However, as OMAP already
> >> is doing this extensively, I wonder what would be the alternative. Maybe
> >> move all the clock data back to kernel space to increase the size of
> >> multi-v7 builds?
> >
> > Why can't you use:
> >
> >       clocks = <&clk_provider fck_index>, <&clk_provider ick_index>, ...;
> >       clock-names = "fck", "ick", ...;
> >
> > when describing the hardware?  If you don't have a struct device, but
> > only a struct device_node, you can use of_clk_get(), which allows you
> > to omit the connection ID and look up by index in the clocks property.
> 
> That can be done. However, this means the individual clock provider must 
> implement all the clocks in the kernel, adding loads of static data. And 

Clock provider drivers *should* initialize all of their clock data
statically. Are you trying to opportunistically register only the clocks
found in DT? This goes against the current direction of clock DT
bindings where we model only the controller and use it to hook up
provider and consumer resources. We are *not* using DT to enumerate
per-clock data.

> the data is different for every TI SoC we have out there in the 
> wild..... aaand, we can't load the clock data as modules either due to 
> early boot time dependencies. This is a royal mess we have here in our 

Boot time deps are a separate issue. On ARMv8 you can probably get away
with it due to architected timers not needing clocks very early.

If you have software dependencies caused by the hwmod framework, again
that is a separate issue from how you should structure your clock data
and your clock controller DT binding.

> hands I am trying to clean-up somehow. I think I have posted several 
> different series along the years trying to get rid of the hwmod static 
> boot time dependency, but it always seems to get shot down. See this 
> approach from last year for example:
> 
> http://comments.gmane.org/gmane.linux.ports.arm.omap/125555

Tony has had a dream to move the clk data into /lib/firmware for a
while. We've talked about that over beers before. But note that no one
else is doing that stuff and I would be happy for the OMAP clock code to
achieve style-parity with the more recent clock provider driver
submissions before going off and trying to do something fancy.

Regards,
Mike

> 
> -Tero
