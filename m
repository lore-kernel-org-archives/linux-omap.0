From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] of: Add generic handling for ePAPR 1.1 fail-sss states
Date: Wed, 31 Aug 2016 14:41:52 -0700
Message-ID: <20160831214151.wzq7y54xxs2qj422@atomide.com>
References: <20160829223542.18871-1-tony@atomide.com>
 <57C74306.9020901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57C74306.9020901-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160831 13:51]:
> On 08/29/16 15:35, Tony Lindgren wrote:
> > 	if (of_device_is_incomplete(pdev->dev.of_node, status)) {
> > 		if (!strcmp("hw-incomplete-pins", status)) {
> > 			dev_info(&pdev->dev,
> > 				 "Unusable hardware: Not pinned out\n");
> > 			err = -ENODEV;
> > 			goto out;
> > 		}
> > 		if (!strcmp("hw-missing-daughter-card")) {
> > 			err = -EPROBE_DEFER;
> > 			goto out;
> > 		}
> > 		if (!strcmp("hw-buggy-dma")) {
> > 			dev_warn(&pdev->dev,
> > 				 "Replace hardware for working DMA\n");
> > 		}
> > 	}
> 
> What if the device has two issues to be reported?  You can not
> specify two different values for the status property.

That's a good point.

> What if the firmware wants to report that the hardware failed
> self-test (thus status = "fail-sss") but is already using
> status to describe the hardware?

Yeah that's true. Do you know what the "sss" stands for here?
Status Self teSt, or Side Scan Sonar? :)

> > - Make more generic as suggested by Frank but stick with
> >   "operational status of a device" approch most people seem
> >   to prefer that
> 
> I am still opposed to using the status property for this purpose.
> 
> The status property is intended to report an operational problem with
> a device or a device that the kernel can cause to be operational (such
> as a quiescent cpu being enabled).  It is the only property I am aware
> of to report _state_.
> 
> It is unfortunate that Linux has adopted the practice of overloading status
> to determine whether a piece of hardware exists or does not exist.  This
> is extremely useful for the way we structure the .dts and .dtsi files but
> should have used a new property name.  We are stuck with that choice of
> using the status property for two purposes, first the state of a device,
> and secondly the hardware description of existing or not existing.
> 
> Why not just create a new property that describes the hardware?
> Perhaps something like:
> 
>    incomplete = "pins_output", "buggy_dma";

New property for incomplete works for me. Rob, got any comments here?

> > + *  __of_device_is_incomplete - check if a device is incomplete
> 
> It is not checking if a device is incomplete.  It is checking whether the
> device is operational _or_ incomplete.
> 
> This is conflating concepts and likely to be confusing.  This is the problem
> with overloading the status property for yet another purpose.

Sure that's a valid point.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
