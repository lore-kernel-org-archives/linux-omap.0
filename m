From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [patch 2.6.29-rc3-git 2/2] USB: disable twl4030 USB regulators when cable unplugged
Date: Tue, 10 Feb 2009 15:19:03 +0000
Message-ID: <20090210151902.GA31365@sirena.org.uk>
References: <200902081053.00255.david-b@pacbell.net> <1234271294.17391.12.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1234271294.17391.12.camel@ubuntu>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Jokiniemi <kalle.jokiniemi-sMOQStClEysAvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 10, 2009 at 03:08:14PM +0200, Kalle Jokiniemi wrote:

> A bug has been discovered here. If the twl-regulator is not compiled in,
> the twl4030-usb fails while trying to access the reg-fw interfaces (and

reg-fw is the regulator framework?

> not checking error values). Also it's bit confusing how we get different
> error values if reg_fw is not compiled (no error) vs. reg_fw is
> compiled, but twl_regulator is not... (error)

The general model is that if you've got regulator API support enabled
then you'll have the relevant regulator drivers enabled.  The support
for compiling out the core is intended to allow configurations that
don't use regulators at all.  This is a bit restrictive but works well
for most users.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
