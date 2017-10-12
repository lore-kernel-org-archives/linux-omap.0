From: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/7] ARM: dts: Add nodes for missing omap4 interconnect
 target modules
Date: Thu, 12 Oct 2017 10:40:30 +0200
Message-ID: <20171012084030.lshobr3ewu3t5goc@squirrel.local>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-6-tony@atomide.com>
 <f5c57f0b-1423-c362-0fda-4069b77a2e38@ti.com>
 <20171011165850.jnaievrgcszcawh3@earth>
 <da8d1d7f-f16d-8d71-cf49-acff79614610@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <da8d1d7f-f16d-8d71-cf49-acff79614610-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 12, 2017 at 09:07:55AM +0300, Peter Ujfalusi wrote:
> I don't see much benefit of using McASP on OMAP4, only drawbacks... It
> lacks AFIFO so it is prone to underrun and if it underruns you need to
> reset McASP. Been there with the Samsung Galaxy Nexus.

AESS/ATC isn't able to consistently respond to a DMA request within 20
us ?  Strange.. I would have expected it to have no trouble with that.
(And presumably so did TI, or they would have included AFIFO?)

> I wonder how Motorola is using the McASP as the OMAP4 version
> (officially) does not support I2S.

Hmm? I checked the omap4430 TRM and I don't see that mentioned. It seems
to have pins for i2s transmit:

	abe_mcasp_axr              O     Audio transmit data
	abe_mcasp_aclkx            O     Transmit bit clock
	abe_mcasp_ahclkx           O     Transmit high-frequency master clock
	abe_mcasp_afsx             O     Transmit frame synchronization
	abe_mcasp_amute            O     Mute out to external
	abe_mcasp_amutein          I     Mute in from external

If it supported s/pdif tx only, then all of these except axr would be
useless.

Matthijs
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
