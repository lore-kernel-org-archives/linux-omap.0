From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dts: am335x-bone-common: Add i2c2 definition
Date: Mon, 12 May 2014 13:42:13 -0700
Message-ID: <20140512204213.GD5668@atomide.com>
References: <1399686184-1594-1-git-send-email-mranostay@gmail.com>
 <20140512195050.GB5668@atomide.com>
 <CAOCHtYiYwx_bEsyqkbUTTAbhBYESzvfBOOYeVuFXPS1dDy0ZKA@mail.gmail.com>
 <20140512201517.GC5668@atomide.com>
 <CAOCHtYg6XpF0Gbo4iFqsFvP=QSivQQvCzov8UfxeLXMzrRYEWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOCHtYg6XpF0Gbo4iFqsFvP=QSivQQvCzov8UfxeLXMzrRYEWw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, pantelis.antoniou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [140512 13:27]:
> >> >
> >> > If these pins are not used for i2c2 on some capes, this device
> >> > should be set to status = "disabled" state by default. Then
> >> > u-boot could re-enable it on the boards that have i2c2 in use.
> >>
> >> To-date, this is the i2c bus that all capes have placed an at24 eeprom
> >> for cape identification.
> >
> > And how many capes actually implement the eeprom cape identification
> > out of the available capes? :)
> 
> Not including one off designs in someone's lab. We will never have an
> accurate number. ;)
> 
> So far; just the ones that want their "cape" detected in the default
> image currently being shipped by CircuitCo. Otherwise the few that
> I've seen without an eeprom, usually follow this default pinmux.
> 
> http://elinux.org/CircuitCo:Basic_Proto_Cape
> 
> Which includes that i2c bus enabled.

OK thanks for the info.
 
> Either case if fine with me.  As who knows when the dtc "overlay" will
> every truly make it mainline, as the capemgr was the only real kernel
> user of the i2c/at24 eeprom information.

Sounds like we should keep it disabled though so u-boot can be used
to toggle it while waiting for the capemgr. That's because the board
has a header for pins, so it's not exactly limited to just the capes.

Anybody working on enabling/disabling cape dtb configurations in u-boot?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
