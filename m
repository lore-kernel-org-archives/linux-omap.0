From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH 2/3] hwmon: Driver for OMAP3 temperature sensor
Date: Tue, 30 Dec 2014 19:00:02 +0100
Message-ID: <20141230180002.GC23142@amd>
References: <20141226102933.GA28778@amd>
 <1419597294-21487-1-git-send-email-sre@kernel.org>
 <1419597294-21487-3-git-send-email-sre@kernel.org>
 <CANOLnON6rAQ2+jJEFDKseH2Htu6bqRkURDioGt7zp1Ze73f8Pw@mail.gmail.com>
 <CAGo_u6qO0ok+GBnm7SQtw6dJuwGN2OuP7CpKDEWawS3V2go4KA@mail.gmail.com>
 <20141229181556.GA26926@amd>
 <54A1BB2B.9060204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54A1BB2B.9060204-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, dt list <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Pali Rohar <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon 2014-12-29 14:35:55, Nishanth Menon wrote:
> On 12/29/2014 12:15 PM, Pavel Machek wrote:
> > On Mon 2014-12-29 12:01:03, Nishanth Menon wrote:
> >> On Mon, Dec 29, 2014 at 11:52 AM, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>> On Fri, Dec 26, 2014 at 2:34 PM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >>>> OMAP34xx and OMAP36xx processors contain a register in the syscon area,
> >>>> which can be used to determine the SoCs temperature. This patch provides
> >>>> a DT based driver for the temperature sensor based on an older driver
> >>>> written by Peter De Schrijver for the Nokia N900 and N9.
> >>>
> >>> The sensor looks like an earlier iteration of sensors used in newer
> >>> OMAPs, which are already supported by maybe
> >>> drivers/thermal/ti-soc-thermal/ , maybe it would make sense to update
> >>> that driver instead?
> >>
> >> Just to be clear - OMAP4 is the first time that the sensors were
> >> reliable enough to be used.
> > 
> > When testing initial version of the patch, they seem to work very well
> > in the omap3 case.
> 
> Just be careful when you try to make thermal policy like decisions
> based on this sensor. Placement of the sensor w.r.t the actual logic

I guess we won't do that, certainly not anytime soon.

> Also notice http://www.ti.com/lit/er/sprz278f/sprz278f.pdf "Advisory
> 3.1.1.186 MMC OCP Clock Not Gated When Thermal Sensor Is Used" I think
> there were accuracy issues at certain values etc.. So remember to do a
> off mode type PM tests as well before you consider requesting these to
> be merged.

Thanks a lot for a pointer. 3x 100uA power draw when you enable
temperature sensor, because it also errorneously enables MMC. I wonder
how the solution would look in the device tree...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
