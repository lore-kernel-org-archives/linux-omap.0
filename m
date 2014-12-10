From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: BCM2048 bluetooth connected over OMAP serial
Date: Wed, 10 Dec 2014 21:56:22 +0100
Message-ID: <20141210205622.GA25286@amd>
References: <20141210164333.GA3154@amd>
 <11367725.nphhSzdtpK@wuerfel>
 <20141210184203.GA28150@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141210184203.GA28150@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org" <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, "sre-GFxCN5SEZAc@public.gmane.org" <sre-GFxCN5SEZAc@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "aaro.koskinen-X3B1VOXEql0@public.gmane.org" <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, "ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed 2014-12-10 18:42:03, Mark Rutland wrote:
> On Wed, Dec 10, 2014 at 05:02:42PM +0000, Arnd Bergmann wrote:
> > On Wednesday 10 December 2014 17:43:33 Pavel Machek wrote:
> > > 
> > > So, there's bluetooth chip that's connected to the SoC by UART and some
> > > GPIOs. What would be right representation in the device tree?
> > > Something like this?
> > > 
> > >         bluetooth {
> > >                   compatible = "broadcom,bcm2048";
> > >                   uart = <&uart2>;
> > >                   reset-gpios = <&gpio3 27 GPIO_ACTIVE_HIGH>; /* want 91 */
> > >                   host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* want 101 */
> > >                   bluetooth-wakeup-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* want 37 */
> > >                   chip-type = >;
> > >                   bt-sysclk = <2>;
> > >                   reset-gpio-shared = <0>;
> > >         };
> > > 
> > > Is there some way to prevent OMAP tty driver from binding to the
> > > device and exporting the device to userspace?
> > 
> > I think from the driver perspective, you want this to be a tty line
> > discipline rather than a driver that attaches to the physical
> > uart.
> > 
> > For the DT representation, I fear we haven't got a precedent. A uart
> > phandle sounds reasonable, but there might be other ways to do it
> > and we should consider if there are better alternatives. It could
> > possibly be a child node of the uart, but that would require other
> > infrastructure in the kernel because we don't currently create
> > devices for those.
> 
> I think the child node is the way to go; that would match what we do for
> I2C and SPI. We might need new infrastructure, but I don't think we
> should treat this differently simlpy because we don't have that yet.

Well, uart in this case looks more like a GPIO than an I2C (no
addressing, just few wires). And we do phandle for GPIOs.

Actually, the chip also has PCM, analog audio, and "pc compatible?"
connections, plus some connection to WIFI. So we may need more
phandles there....

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
