From: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCHv3] media: i2c/adp1653: devicetree support for adp1653
Date: Fri, 3 Apr 2015 14:23:56 +0300
Message-ID: <20150403112355.GJ20756@valkosipuli.retiisi.org.uk>
References: <20150402143846.GA11687@amd>
 <20150402161453.GH20756@valkosipuli.retiisi.org.uk>
 <20150402203043.GB29963@amd>
 <20150402234823.GI20756@valkosipuli.retiisi.org.uk>
 <20150403082344.GA14721@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150403082344.GA14721@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, sre-GFxCN5SEZAc@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

On Fri, Apr 03, 2015 at 10:23:44AM +0200, Pavel Machek wrote:
> Hi!
> 
> > Hi Pawel,
> 
> I'm still Pavel. v, not w.

I know too many Pawels. Sorry about that. :-)

> 
> > > > Hi Pawel,
> 
> > > > A corresponding change to the N900 dts would be very nice.
> > > 
> > > Corresponding change to the dts will come in separate patch. Or do you
> > > have n900 for testing?
> > 
> > Yes, it should be a separate patch, I agree.
> > 
> > I do have one but I can't say when I'd have time to test it. I'm fine with
> > you having tested it though.
> > 
> > > > I think you're missing change to adp1653_i2c_driver.driver.of_match_table.
> > > 
> > > It actually worked for me, which means device tree somehow does it
> > > magic.
> > 
> > By magic? :-) It probably just ends up comparing the device and the driver
> > names. How about adding the of_match_table?
> 
> I guess it uses adp1653_id_table. I'd hade to add redundand
> information, because if it would just mask the errors if the code
> changed...

Indeed, that's true. This is comparing "adp1653" vs. comparing
"adi,adp1653". I think I still prefer the latter since it's got also the
vendor prefix included.

Suppose we change this later and someone misspelled the vendor prefix ---
their board would break.

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org	XMPP: sailus-PCDdDYkjdNMDXYZnReoRVg@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
