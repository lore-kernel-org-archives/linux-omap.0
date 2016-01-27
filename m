From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/3] ARM: dts: cm-t335: add peripherals - part 2
Date: Wed, 27 Jan 2016 10:34:23 -0800
Message-ID: <20160127183423.GS19432@atomide.com>
References: <1451475695-26921-1-git-send-email-uri.mashiach@compulab.co.il>
 <569F39E9.2070506@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <569F39E9.2070506-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org> [160119 23:41]:
> Gentle ping
> 
> On 12/30/2015 01:41 PM, Uri Mashiach wrote:
> >Add support for the following peripherals:
> >- CAN BUS
> >- Touchscreen
> >- Audio
> >
> >Uri Mashiach (3):
> >   ARM: dts: cm-t335: Add support for CAN bus
> >   ARM: dts: cm-t335: add touchscreen support
> >   ARM: dts: cm-t335: add audio support
> >
> >  arch/arm/boot/dts/am335x-cm-t335.dts | 116 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 116 insertions(+)

Sorry for the delay, I was waiting forv4.5-rc1 and have most fixes
out of the way first. Applying into omap-for-v4.6/dt.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
