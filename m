From: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH] userspace API definitions for auto-focus coil
Date: Sat, 18 Jun 2016 00:28:41 +0300
Message-ID: <20160617212841.GG24980@valkosipuli.retiisi.org.uk>
References: <20160531213437.GA28397@amd>
 <20160601152439.GQ26360@valkosipuli.retiisi.org.uk>
 <20160601220840.GA21946@amd>
 <20160602074544.GR26360@valkosipuli.retiisi.org.uk>
 <20160602193027.GB7984@amd>
 <20160602212746.GT26360@valkosipuli.retiisi.org.uk>
 <20160605190716.GA11321@amd>
 <575512E5.5030000@gmail.com>
 <20160611220654.GC26360@valkosipuli.retiisi.org.uk>
 <20160612075416.GA1160@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160612075416.GA1160@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

On Sun, Jun 12, 2016 at 09:54:17AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > >@@ -974,4 +975,9 @@ enum v4l2_detect_md_mode {
> > > >  #define V4L2_CID_DETECT_MD_THRESHOLD_GRID	(V4L2_CID_DETECT_CLASS_BASE + 3)
> > > >  #define V4L2_CID_DETECT_MD_REGION_GRID		(V4L2_CID_DETECT_CLASS_BASE + 4)
> > > >
> > > >+/* Control IDs specific to the AD5820 driver as defined by V4L2 */
> > > >+#define V4L2_CID_FOCUS_AD5820_BASE 	(V4L2_CTRL_CLASS_CAMERA | 0x10af)
> > 
> > Please check V4L2_CID_USER_*_BASE. That's how custom controls are handled
> > nowadays.
> 
> Let me see...
> 
> > Now that I think about this, the original implementation in N900 very likely
> > did not use either of the two controls; the device driver was still written
> > to provide access to full capabilities of the chip. And that one had no
> > continuous AF.
> 
> I'm not sure about the original implementation, but fcam-dev library
> (which is our best chance for usable camera) does use both:
> 
> pavel@duo:~/g/fcam-dev$ grep -ri RAMP_TIME .
> ./.svn/pristine/05/0574680922f59e07bd49e16a951d69421690a323.svn-base:
> int val = ioctlSet(V4L2_CID_FOCUS_AD5820_RAMP_TIME,
> 1000000.0f/diopterRateToTickRate(speed));
> ./src/N900/Lens.cpp:    int val =
> ioctlSet(V4L2_CID_FOCUS_AD5820_RAMP_TIME,
> 1000000.0f/diopterRateToTickRate(speed));
> pavel@duo:~/g/fcam-dev$ grep -ri RAMP_MODE .
> ./.svn/pristine/05/0574680922f59e07bd49e16a951d69421690a323.svn-base:
> ioctlSet(V4L2_CID_FOCUS_AD5820_RAMP_MODE, 0);
> ./src/N900/Lens.cpp:    ioctlSet(V4L2_CID_FOCUS_AD5820_RAMP_MODE, 0);
> pavel@duo:~/g/fcam-dev$
> 
> > I might as well drop the two controls, up to you. If someone ever needs them
> > they can always be reintroduced. I'd be happy to get a new patch, the
> > current driver patch does not compile (just tried) as the definitions of
> > these controls are missing.
> 
> I'd prefer to keep the controls, as we have userspace using them. I
> got it to compile but have yet to get it to work (subdevs split, so it
> needs some modifications).

Right. I didn't know Fcam used them. Still, using them is hardly an optimal
way to control the lens (as far as camera functionality goes, using them
requires less CPU time consumption though).

The flash control patches should receive a proper RFC that discusses the
problem area and proposes a solution. I'll write one in the near future.

I think that for this particular controller it's relatively clear though: it
provides very basic functionality that maps well to controls that I don't
really see alternative options for that.

I don't object defining standard controls for ramp mode nor time either. But
I expect you to write a patch in that case. :-)

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org	XMPP: sailus-PCDdDYkjdNMDXYZnReoRVg@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
