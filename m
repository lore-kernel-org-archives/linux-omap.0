From: Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: Re: [PATCH] userspace API definitions for auto-focus coil
Date: Tue, 12 Jul 2016 20:32:01 -0300
Message-ID: <20160712203201.7ffd8f22@recife.lan>
References: <20160602074544.GR26360@valkosipuli.retiisi.org.uk>
	<20160602193027.GB7984@amd>
	<20160602212746.GT26360@valkosipuli.retiisi.org.uk>
	<20160605190716.GA11321@amd>
	<575512E5.5030000@gmail.com>
	<20160611220654.GC26360@valkosipuli.retiisi.org.uk>
	<20160612084811.GA27446@amd>
	<20160612112253.GD26360@valkosipuli.retiisi.org.uk>
	<20160613191753.GA17459@amd>
	<20160617213545.GH24980@valkosipuli.retiisi.org.uk>
	<20160618153846.GA15662@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160618153846.GA15662@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Em Sat, 18 Jun 2016 17:38:46 +0200
Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> escreveu:

> Hi!
> 
> > > Not V4L2_CID_USER_AD5820...?  
> > 
> > The rest of the controls have no USER as part of the macro name, so I
> > wouldn't use it here either.  
> 
> Ok.
> 
> > > Ok, separate header file for 2 lines seemed like a bit of overkill,
> > > but why not.  
> > 
> > That follows an existing pattern of how controls have been implemented in
> > other drivers.  
> 
> Ok.
> 
> > Could you merge this with the driver patch? I've dropped that from my ad5820
> > branch as it does not compile.  
> 
> Yes, merged patch should be in your inbox now.

The V4L2 core changes should be on a separate patch. Btw, you'll also
need to patch documentation to reflect such changes. We're right now
moving from DocBook to ReST markup language. The patches for it are
right now on a separate topic branch (docs-next), to be merged for
Kernel 4.8 on the next merge window.

You should either base the patch on such branch or wait for it to be
merged back mainstream to write such documentation additions.


> 
> Thanks,
> 									Pavel
> 


-- 
Thanks,
Mauro
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
