From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] of/platform: Fix no irq domain found errors when
 populating interrupts
Date: Tue, 31 Dec 2013 10:33:58 -0600
Message-ID: <CAL_Jsq+X5G94DUn-zFKQkhEy91cdjCyeciny+kDjr=V6EiBHfQ@mail.gmail.com>
References: <20131123004334.GJ10023@atomide.com>
	<20131123010850.GN10023@atomide.com>
	<20131123015034.GP10023@atomide.com>
	<20131124212757.7D224C402A3@trevor.secretlab.ca>
	<alpine.DEB.2.02.1312100331460.32309@utopia.booyaka.com>
	<alpine.DEB.2.02.1312302209200.8869@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1312302209200.8869-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 30, 2013 at 4:10 PM, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Grant, Rob,
>
> On Tue, 10 Dec 2013, Paul Walmsley wrote:
>
>> On Sun, 24 Nov 2013, Grant Likely wrote:
>>
>> > On Fri, 22 Nov 2013 17:50:35 -0800, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>> > > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [131122 17:16]:
>> > > > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [131122 17:09]:
>> > > > > * Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> [131122 16:56]:
>> > > > > > On Fri, Nov 22, 2013 at 04:43:35PM -0800, Tony Lindgren wrote:
>> > > > > > > +         /* See of_device_resource_notify for populating interrupts */
>> > > > > > > +         for (i = 0; i < num_irq; i++, res++) {
>> > > > > > > +                 res->flags = IORESOURCE_IRQ;
>> > > > > > > +                 res->start = -EPROBE_DEFER;
>> > > > > > > +                 res->end = -EPROBE_DEFER;
>> > > > > >
>> > > > > > NAK.  Definitely a bad idea to start introducing magic values other into
>> > > > > > resources.  Please don't do this.
>> > > > >
>> > > > > Do you have any better ideas on how to sort out this issue then?
>> > > >
>> > > > I guess we could allocate all the resources lazily here, I'll take a look
>> > > > at that.
>> > >
>> > > Here's a version that allocates the resources lazily with the notifier.
>> > > Seems to boot, need to play with it a bit more though to make sure we're
>> > > not overwriting resources for any legacy devices.
>> >
>> > Blurg. Using a notifier really feels like we don't have a good handle on
>> > a reasonable solution yet. Basically it means we're hooking into the
>> > driver core without /looking/ like we're hooking into the driver core. I
>> > don't think this is any better, but I don't have a better suggestion at
>> > the moment.   :-(
>>
>> Unfortunately this patch, or something that accomplishes the same results,
>> is somewhat high-priority for us on OMAP.  OMAP37xx got prematurely
>> converted to DT booting, and now dynamic power management is broken:
>>
>>     http://marc.info/?l=linux-arm-kernel&m=138658294830408&w=2
>>
>> Tony writes that this patch is one of the two patches needed to get things
>> working again:
>>
>>     http://marc.info/?l=linux-arm-kernel&m=138660942506846&w=2
>>
>> Is it possible to get this patch, or something similar, merged for
>> v3.13-rc?
>>
>> Once something like PM is broken, it's pretty easy for other broken
>> patches to make it into the tree, since it becomes very difficult to test
>> without turning into a maintainer denial-of-service attack.
>
> Ping.  Could you please provide some guidance here about what you'd need
> to get this solved for v3.13-rc?

I agree with doing the platform_get_irq modification and feel free to
add my ack. I'm going to be offline for the next week.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
