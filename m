From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [RFC 3/7] dt: bindings: Add nokia-bluetooth
Date: Wed, 17 Aug 2016 17:54:52 +0200
Message-ID: <20160817155452.GA14957@amd>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-4-git-send-email-sre@kernel.org>
 <20160816135155.GA20948@rob-hp-laptop>
 <20160816232855.qgempm64zgp36ufd@earth>
 <CAL_JsqLcDzTZ++h+e7D-n0xbt7LgryK6jfGJDNEcAaU=Dn4b0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqLcDzTZ++h+e7D-n0xbt7LgryK6jfGJDNEcAaU=Dn4b0w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Ville Tervo <ville.tervo-X3B1VOXEql0@public.gmane.org>, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi!

> >> > +  - reset-gpios:           Should specify the gpio for bluetooth reset
> >> > +  - host-wakeup-gpios:             Should specify the gpio for host wakeup
> >>
> >> Should be interrupt instead?
> >
> > Yes this is mostly an interrupt, but I need to read the current
> > line state.
> 
> When? If the interrupt is level triggered, then you can get the line
> state based on whether you get an interrupt or not. If this needs to
> be a wakeup source (see the wakeup source binding), then it needs to
> be an interrupt.

What is wrong with GPIO? It is simply a piece of wire. Yes, we'll
configure it to generate an interrupt, or maybe not, but that's
software detail, the device tree just should not care....
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
