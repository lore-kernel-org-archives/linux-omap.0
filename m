From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] USB: ohci-omap: defer probe if PHY is missing
Date: Tue, 03 Jan 2017 21:11:27 +0200
Message-ID: <877f6cm00w.fsf@linux.intel.com>
References: <20170102205355.18920-1-aaro.koskinen@iki.fi> <20170103165143.GA25272@kroah.com> <20170103185031.viic6w5tzshb7mt5@raspberrypi-2.musicnaut.iki.fi> <20170103190504.GA10352@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170103190504.GA10352-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Hi,

Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> writes:
> On Tue, Jan 03, 2017 at 08:50:31PM +0200, Aaro Koskinen wrote:
>> Hi,
>> 
>> On Tue, Jan 03, 2017 at 05:51:43PM +0100, Greg Kroah-Hartman wrote:
>> > On Mon, Jan 02, 2017 at 10:53:55PM +0200, Aaro Koskinen wrote:
>> > > Defer probe if PHY is missing. E.g. on Nokia 770 several modules needs
>> > > to be loaded to get the PHY going and ohci-omap should wait for those.
>> > > 
>> > > Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
>> > 
>> > Is this a new bug?  The 770 has been around for forever, why has this
>> > not been a problem before now?
>> 
>> PHY/OTG support for 770 has been around only since v3.14.
>
> 3.14 was released March, 2014.  A long time ago in kernel development :)
>
>> I was previously compiling phy-tahvo as built-in, and bumped into this
>> issue when compiling it as a module.
>
> Why not just make the defconfig as built-in?
>
> I'm not objecting to this patch, just really curious why no one else has
> ever hit it.

Aaro is likely to be the last active OMAP1 user (let alone hacker)
around. This is probably just a reflection of that fact. No-one else was
using N770 with upstream (at least with USB in mind) :-)

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
