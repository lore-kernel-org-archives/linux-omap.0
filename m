From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v1] regulator: twl: Provide of_map_mode for twl4030
Date: Fri, 8 Apr 2016 10:54:56 -0700
Message-ID: <20160408175456.GY16484@atomide.com>
References: <20160404222638.GM2350@sirena.org.uk>
 <1459835974-31664-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160407175745.GK32257@rob-hp-laptop>
 <20160408154907.GT16484@atomide.com>
 <20160408160828.GA10562@earth>
 <20160408161923.GW16484@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160408161923.GW16484-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160408 09:21]:
> * Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org> [160408 09:09]:
> > Hi Tony,
> > 
> > On Fri, Apr 08, 2016 at 08:49:07AM -0700, Tony Lindgren wrote:
> > > * Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [160407 10:58]:
> > > > On Tue, Apr 05, 2016 at 08:59:34AM +0300, Ivaylo Dimitrov wrote:
> > > > > of_map_mode is needed so to be possible to set initial regulators mode from
> > > > > the board DTS. Otherwise, for DT boot, regulators are left in their default
> > > > > state after reset/reboot. Document device specific modes as well.
> > > > > 
> > > > > Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > > ---
> > > > >  .../bindings/regulator/twl-regulator.txt           |  6 ++++++
> > > > 
> > > > Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > > 
> > > I'd like to test these patches, but I don't know which combination
> > > of patches needed? It seems we're waiting for an update on at least
> > > one of the patches in this series?
> > > 
> > > Might be best to repost the whole series so people can test the
> > > right patches.
> > 
> > As far as I can see Mark has already queued all patches in his
> > for-next branch and they are already in today's linux-next, so
> > you can just test linux-next.
> 
> OK thanks will do.

Yup PM seems to work just fine with these.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
