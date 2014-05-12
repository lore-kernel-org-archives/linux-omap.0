From: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dts: am335x-bone-common: Add i2c2 definition
Date: Mon, 12 May 2014 15:27:13 -0500
Message-ID: <CAOCHtYg6XpF0Gbo4iFqsFvP=QSivQQvCzov8UfxeLXMzrRYEWw@mail.gmail.com>
References: <1399686184-1594-1-git-send-email-mranostay@gmail.com>
	<20140512195050.GB5668@atomide.com>
	<CAOCHtYiYwx_bEsyqkbUTTAbhBYESzvfBOOYeVuFXPS1dDy0ZKA@mail.gmail.com>
	<20140512201517.GC5668@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140512201517.GC5668-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, pantelis.antoniou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

>> >
>> > If these pins are not used for i2c2 on some capes, this device
>> > should be set to status = "disabled" state by default. Then
>> > u-boot could re-enable it on the boards that have i2c2 in use.
>>
>> To-date, this is the i2c bus that all capes have placed an at24 eeprom
>> for cape identification.
>
> And how many capes actually implement the eeprom cape identification
> out of the available capes? :)

Not including one off designs in someone's lab. We will never have an
accurate number. ;)

So far; just the ones that want their "cape" detected in the default
image currently being shipped by CircuitCo. Otherwise the few that
I've seen without an eeprom, usually follow this default pinmux.

http://elinux.org/CircuitCo:Basic_Proto_Cape

Which includes that i2c bus enabled.

Either case if fine with me.  As who knows when the dtc "overlay" will
every truly make it mainline, as the capemgr was the only real kernel
user of the i2c/at24 eeprom information.

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
