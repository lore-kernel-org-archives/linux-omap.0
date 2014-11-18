From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [RFC] adp1653: Add device tree bindings for LED controller
Date: Tue, 18 Nov 2014 09:46:03 +0100
Message-ID: <20141118084603.GC4059@amd>
References: <20141116075928.GA9763@amd>
 <20141117145857.GO8907@valkosipuli.retiisi.org.uk>
 <546AFEA5.9020000@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <546AFEA5.9020000-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, sre-GFxCN5SEZAc@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, freemangordon-uiMcrn6V0Vs@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue 2014-11-18 09:09:09, Jacek Anaszewski wrote:
> Hi Pavel, Sakari,
> 
> On 11/17/2014 03:58 PM, Sakari Ailus wrote:
> >Hi Pavel,
> >
> >On Sun, Nov 16, 2014 at 08:59:28AM +0100, Pavel Machek wrote:
> >>For device tree people: Yes, I know I'll have to create file in
> >>documentation, but does the binding below look acceptable?
> >>
> >>I'll clean up driver code a bit more, remove the printks. Anything
> >>else obviously wrong?
> >
> >Jacek Anaszewski is working on flash support for LED devices. I think it'd
> >be good to sync the DT bindings for the two, as the types of devices
> >supported by the LED API and the V4L2 flash API are quite similar.
> >
> >Cc Jacek.
> 
> I've already submitted a patch [1] that updates leds common bindings.
> I hasn't been merged yet, as the related LED Flash class patch [2]
> still needs some indicator leds related discussion [3].
> 
> I think this is a good moment to discuss the flash related led common
> bindings.

Part of problem is that adp1653 is not regarded as "LED" device by
current kernel driver.

> [1] http://www.spinics.net/lists/linux-leds/msg02121.html

@@ -3,6 +3,17 @@ Common leds properties.
 Optional properties for child nodes:
 - label : The label for this LED.  If omitted, the label is
   taken from the node name (excluding the unit address).
+- iout-torch : Array of maximum intensities in microamperes of the
 torch
+	led currents in order from sub-led 0 to N-1, where N is the
 number
+	of torch sub-leds exposed by the device
+- iout-flash : Array of maximum intensities in microamperes of the
 flash
+	led currents in order from sub-led 0 to N-1, where N is the
 number
+	of flash sub-leds exposed by the device
+- iout-indicator : Array of maximum intensities in microamperes of
+  the indicator led currents in order from sub-led 0 to N-1,
+  where N is the number of indicator sub-leds exposed by the device
+- flash-timeout : timeout in microseconds after which flash led
+  is turned off
 
 - linux,default-trigger :  This parameter, if present, is a
     string defining the trigger assigned to the LED.  Current
     triggers are:
@@ -19,5 +30,10 @@ Examples:
 system-status {
 	       label = "Status";
 	       linux,default-trigger = "heartbeat";
+	       iout-torch = <500 500>;
+	       iout-flash = <1000 1000>;
+	       iout-indicator = <100 100>;
+	       flash-timeout = <1000>;
+
	...
 };

I don't get it; system-status describes single LED, why are iout-torch
(and friends) arrays of two?

Also, at least on adp1653, these are actually two leds -- white and
red. Torch and flash is white led, indicator is red led.

> [2] http://www.spinics.net/lists/linux-media/msg83100.html
> [3] http://www.spinics.net/lists/linux-leds/msg02472.html

What device are you using for testing? Can you cc me on future
patches?

Why do we need complex "flash LED class" support, and where is the
V4L2 glue?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
