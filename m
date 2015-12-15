From: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Tue, 15 Dec 2015 12:24:52 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1512151222020.26920@knanqh.ubzr>
References: <20150713131902.GH26485@atomide.com> <20151129180939.GE30871@n2100.arm.linux.org.uk> <alpine.LFD.2.20.1511291902100.22569@knanqh.ubzr> <201511300115.12478@pali> <20151130152352.GY2517@atomide.com> <20151130153933.GD29576@pali>
 <alpine.LFD.2.20.1511301041090.22569@knanqh.ubzr> <20151215093325.GK13531@pali> <20151215122038.GI30871@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-231738316-1450200294=:26920"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151215122038.GI30871-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--8323328-231738316-1450200294=:26920
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 15 Dec 2015, Russell King - ARM Linux wrote:

> On Tue, Dec 15, 2015 at 10:33:25AM +0100, Pali Rohár wrote:
> > So am I understand correctly that solution would be to hack
> > arch/arm/mm/mmu.c to not overwrite page at PHYS_OFFSET?
> 
> That's completely unnecessary: there are enough platform hooks to cope
> with whatever the platform requires.

Indeed.  I didn't notice that mdesc->reserve() exists these days and is 
perfect for this purpose as you say.


Nicolas
--8323328-231738316-1450200294=:26920--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
