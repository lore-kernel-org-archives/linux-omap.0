From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH RESEND] ARM: dts: OMAP3-N900: Add microphone bias voltages
Date: Mon, 30 Mar 2015 09:42:38 -0700
Message-ID: <20150330164237.GJ10805@atomide.com>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
 <55197A12.1050009@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55197A12.1050009-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org> [150330 09:31]:
> On 03/01/2015 09:07 PM, Jarkko Nikula wrote:
> > From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> > 
> > N900 audio recording needs that codec provides bias voltage for integrated
> > digital microphone and headset microphone depending which one is used.
> > Digital microphone uses 2 V bias and it comes from the codec A part. Codec
> > B part drives the headset microphone bias and that is set to 2.5 V.
> > 
> > Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> > [Jarkko: Headset mic bias changed to 2 (2.5 V) as it was before commit
> > e2e8bfdf6157 ("ASoC: tlv320aic3x: Convert mic bias to a supply widget")]
> > Signed-off-by: Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/omap3-n900.dts | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> Ping?

Oops sorry I have missed this one. This looks like a regression fix
for the v4.0-rc series? Should it be cc stable v3.16+ or something?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
