From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] of: Add generic handling for ePAPR 1.1 fail-sss states
Date: Mon, 29 Aug 2016 17:39:22 -0700
Message-ID: <20160830003922.462byzmpnq277h2u@atomide.com>
References: <20160829223542.18871-1-tony@atomide.com>
 <CAL_JsqK=JLN+ujvyVv62E-d1sB_DgeZCGP5Pddt9ohPkypHdEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqK=JLN+ujvyVv62E-d1sB_DgeZCGP5Pddt9ohPkypHdEg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [160829 17:24]:
> On Mon, Aug 29, 2016 at 5:35 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > It seems we can use the ePAPR 1.1 status fail-sss to do this.
> > Quoting "Table 2-4 Values for status property" we have "fail-sss":
> >
> > "Indicates that the device is not operational. A serious error was
> >  detected in the device and it is unlikely to become operational
> >  without repair. The sss portion of the value is specific to the
> >  device and indicates the error condition detected."
> 
> I had read this as 'sss' is just 3 characters, but I guess that doesn't matter.

Yeah I'd assume it does not matter for the length.

> > We can handle these fail states can be handled in a generic
> > way. So let's introduce a generic status = "fail-" that
> > describes a situation where a device driver probe should just
> > shut down or idle the device if possible and then bail out.
> > This allows the SoC variant and board specific dts files to set
> > the status as needed.
> >
> > The suggested usage in a device driver probe is:
> >
> > static int foo_probe(struct platform_device *pdev)
> > {
> >         int err;
> >         const char *status;
> >         ...
> >
> >         pm_runtime_enable(&pdev->dev);
> >         pm_runtime_get_sync(&pdev->dev);
> >         pm_runtime_use_autosuspend(&pdev->dev);
> >         ...
> >
> >         /* Configure device, load firmware, idle device */
> >         ...
> >
> >         if (of_device_is_incomplete(pdev->dev.of_node, status)) {
> 
> &status

Oops, I guess I should compile test the example.

> >                 if (!strcmp("hw-incomplete-pins", status)) {
> >                         dev_info(&pdev->dev,
> >                                  "Unusable hardware: Not pinned out\n");
> >                         err = -ENODEV;
> >                         goto out;
> >                 }
> >                 if (!strcmp("hw-missing-daughter-card")) {
> >                         err = -EPROBE_DEFER;
> 
> This implies we're going to change this on the fly? I guess
> disabled->okay can already happen.

Well let's assume the bootloader sets some i2c controlled daughter
board with "fail-hw-missing-daughter-card", then in theory kernel
could probe it if it pops up on the i2c bus later on. Not sure if
we want to do this, but it seems we could..

> > +static bool __of_device_is_incomplete(const struct device_node *device,
> > +                                     const char **status)
> > +{
> > +       const char *s, *m = "fail-";
> > +       int slen, mlen;
> > +
> > +       if (!device)
> > +               return false;
> > +
> > +       s = __of_get_property(device, "status", &slen);
> 
> You can use the string helper function here (or is the lock a problem?).

I'll check.

> Overall, seems okay to me.

OK thanks for looking.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
