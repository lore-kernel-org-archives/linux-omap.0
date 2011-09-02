From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 6/6] usb: musb: Add support for ti81xx platform
Date: Fri, 2 Sep 2011 21:03:34 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404EC4CC37F@dbde02.ent.ti.com>
References: <1314357108-2279-1-git-send-email-ajay.gupta@ti.com>
 <1314357108-2279-7-git-send-email-ajay.gupta@ti.com>
 <20110826235226.GD4829@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404EC4CBA8E@dbde02.ent.ti.com>
 <20110829083757.GD13925@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404EC4CBB7B@dbde02.ent.ti.com>
 <20110902113519.GQ5148@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110902113519.GQ5148-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> > If you compare am35x and da8x then you would find that they are
> mostly
> > same and so should be merged. They both have one musb instances.
> >
> > Ti81xx has two musb interface and huge differences in register map as
> > listed Above so ti81xx should be in a separate file.
> >
> > Apart from this, am35 and da8x is not yet runtime pm compatible but
> > the current patches supporting ti81x is runtime pm compliant.
> >
> > I think da8x and am35x files should be merged in a separate patch
> > once they are tested after the merge.

> Sure, let's try to merge them as soon as possible.

Ok.

> Now, about this one.
> I still think the wrapper is essentially the same, but the memory map
> is different, right ?

Yes, except that usbss related wrappers are completely new in ti81xx and
They are not present in am35x or da8xx or davinci series platforms.

> I mean, the programming model of the wrapper and
> its features are the same, correct ?

Yes.

> So, how about you abstract the
> memory map by passing the address offsets via driver_data ?

This sounds to be a cleaner way of doing this. Let me work on this and
propose something.

> The thing
> is that this is all duplicated code in a sense. Although the register
> map is different, the HW block is the same, isn't it ?
Yes.

> Just a few tweaks to support multiple musb instances.

Except that the complete new usbss wrapper.

> In that case, I'm not very keen on letting yet another very similar
> file to be added.

Let me collect all the details and discuss further on this.

> How about you add a very clean musb-dsps.c file (btw, at some point, I
> want all glue layers to have musb- prepended to them) which, for now,
> only handles this new chip, but it has memory map passed in via
> driver_data ? Then it should be very simple to convert davinci, da8xx
> and am35x to the new file.
Ok.

> 
> You will probably need to revisit the other device's TRM to see what
> needs to be abstracted or flaged somehow. What is board-specific and
> what is silicon-specific and that sort of thing. But it will be a very
> nice exercise and the output will be the deletion of three very similar
> files.
Ok.

Thanks,
Ajay
> 
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
