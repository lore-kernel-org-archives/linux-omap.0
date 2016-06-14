From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 5/7] ARM: OMAP: dmtimer: Do not call PM runtime functions
 when not needed.
Date: Tue, 14 Jun 2016 00:53:56 -0700
Message-ID: <20160614075356.GU22406@atomide.com>
References: <1462634508-24961-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1462634508-24961-6-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160509193624.GH5995@atomide.com>
 <5730F840.3050807@gmail.com>
 <20160610102225.GS22406@atomide.com>
 <575B2F48.4090707@gmail.com>
 <20160613071057.GQ22406@atomide.com>
 <575F025F.7000101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <575F025F.7000101-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160613 12:01]:
> Hi,
> 
> On 13.06.2016 10:10, Tony Lindgren wrote:
> > * Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160610 14:23]:
> > > 
> > > On 10.06.2016 13:22, Tony Lindgren wrote:
> > > > 
> > > > OK. And I just applied the related dts changes. Please repost the driver
> > > > changes and DT binding doc with Rob's ack to the driver maintainers to
> > > > apply.
> > > > 
> > > 
> > > Already did, see https://lkml.org/lkml/2016/5/16/429
> > > 
> > > Shall I do anything else?
> > 
> > Probably good idea to repost just the driver changes to the
> > subsystem maintainers. With v4.7 out any pre v4.7 patchsets
> > easily get forgotten.
> > 
> 
> Sorry for the maybe stupid question, but does this mean that I should send
> separate patches instead of series? Or the series without what you've
> already applied?

Always leave out the patches that have been already applied.
Otherwise people will get confused. Just mention it in the
cover letter saying "patch xyz has been already applied into
foo tree, these patches are safe to apply separately into bar
tree" or something similar :)

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
