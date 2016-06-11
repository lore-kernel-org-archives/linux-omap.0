From: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH] userspace API definitions for auto-focus coil
Date: Sun, 12 Jun 2016 01:06:55 +0300
Message-ID: <20160611220654.GC26360@valkosipuli.retiisi.org.uk>
References: <20160527205140.GA26767@amd>
 <20160531212222.GP26360@valkosipuli.retiisi.org.uk>
 <20160531213437.GA28397@amd>
 <20160601152439.GQ26360@valkosipuli.retiisi.org.uk>
 <20160601220840.GA21946@amd>
 <20160602074544.GR26360@valkosipuli.retiisi.org.uk>
 <20160602193027.GB7984@amd>
 <20160602212746.GT26360@valkosipuli.retiisi.org.uk>
 <20160605190716.GA11321@amd>
 <575512E5.5030000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <575512E5.5030000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Ivaylo,

On Mon, Jun 06, 2016 at 09:06:29AM +0300, Ivaylo Dimitrov wrote:
> Hi,
> 
> On  5.06.2016 22:07, Pavel Machek wrote:
> >Add userspace API definitions.
> >
> >Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> >
> >diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> >index b6a357a..23011cc 100644
> >--- a/include/uapi/linux/v4l2-controls.h
> >+++ b/include/uapi/linux/v4l2-controls.h
> >@@ -974,4 +975,9 @@ enum v4l2_detect_md_mode {
> >  #define V4L2_CID_DETECT_MD_THRESHOLD_GRID	(V4L2_CID_DETECT_CLASS_BASE + 3)
> >  #define V4L2_CID_DETECT_MD_REGION_GRID		(V4L2_CID_DETECT_CLASS_BASE + 4)
> >
> >+/* Control IDs specific to the AD5820 driver as defined by V4L2 */
> >+#define V4L2_CID_FOCUS_AD5820_BASE 	(V4L2_CTRL_CLASS_CAMERA | 0x10af)

Please check V4L2_CID_USER_*_BASE. That's how custom controls are handled
nowadays.

> >+#define V4L2_CID_FOCUS_AD5820_RAMP_TIME	(V4L2_CID_FOCUS_AD5820_BASE+0)
> >+#define V4L2_CID_FOCUS_AD5820_RAMP_MODE	(V4L2_CID_FOCUS_AD5820_BASE+1)
> >+
> >  #endif
> >
> 
> Sakari, what about adding those as standard camera controls? It seems ad5820
> is not the only VCM driver to implement "antiringing" controls, http://rohmfs.rohm.com/en/products/databook/datasheet/ic/motor/mobile_module/bu64241gwz-e.pdf
> is another example I found by quick search.

These controls however seem to be related to some thing else --- configuring
the driver to drive the lens little by little to the target using a
pre-defined step time and size. I presume it is intended for something else,
most likely for performing a full search for a regular AF algorithm. I also
wonder how much this functionality is used nowadays, most devices use
continuous AF algorithm that has little or no use for such. It also provides
no help in synchronising lens movement to exposure of the AF window.

Now that I think about this, the original implementation in N900 very likely
did not use either of the two controls; the device driver was still written
to provide access to full capabilities of the chip. And that one had no
continuous AF.

> What about:
> 
> #define V4L2_CID_FOCUS_STEP_MODE xxx
> enum v4l2_cid_focus_step_mode {
> V4L2_CID_FOCUS_STEP_MODE_DIRECT,
> V4L2_CID_FOCUS_STEP_MODE_LINEAR,
> V4L2_CID_FOCUS_STEP_MODE_AUTO
> };
> #define V4L2_CID_FOCUS_STEP_TIME xxx+1
> 
> Also, how the userspace(or the kernel) is notified by v4l that there is an
> event? The point is - I think it is a good idea to notify when VCM has
> completed its movement, we can start a timer based on the current position,
> mode, step time etc and notify after the pre-calculated movement time.

You'd have to start modelling the movement of the lens somehow. And for
that, we'd need to know about the lens and the spring in the kernel, too. I
presume that's already a lot of the algorithm to get the lens moving, and
supposing this is in the kernel, what else would go to the kernel?

These device provide very basic functionality for moving the lens; current
is applied on a coil and that has the effect of moving the lens, bringing
the focus distance closer as more current is applied but that's pretty much
it: there's no reliable way to focus at a particular distance for example.

I might as well drop the two controls, up to you. If someone ever needs them
they can always be reintroduced. I'd be happy to get a new patch, the
current driver patch does not compile (just tried) as the definitions of
these controls are missing.

Ringing compensation functionality present in the other chip should be far
more useful.

If there are AF experts reading this, feel free to challenge me. :-) I can't
claim to be one.

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org	XMPP: sailus-PCDdDYkjdNMDXYZnReoRVg@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
