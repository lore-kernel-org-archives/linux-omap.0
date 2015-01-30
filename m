From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] ARM: dst: OMAP3-N900: Add microphone bias voltages
Date: Fri, 30 Jan 2015 21:03:22 +0100
Message-ID: <20150130200321.GA2087@amd>
References: <1422645800-21287-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422645800-21287-1-git-send-email-jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri 2015-01-30 21:23:20, Jarkko Nikula wrote:
> From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> 
> N900 audio recording needs that codec provides bias voltage for integrated
> digital microphone and headset microphone depending which one is used.
> Digital microphone uses 2 V bias and it comes from the codec A part. Codec
> B part drives the headset microphone bias and that is set to 2.5 V.
> 
> Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> [Jarkko: Headset mic bias changed to 2 (2.5 V) as it was before commit
> e2e8bfdf6157 ("ASoC: tlv320aic3x: Convert mic bias to a supply widget")]
> Signed-off-by: Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>
> ---
> Pavel: I hope you don't mind I took your diff from
> http://marc.info/?l=linux-kernel&m=142249383224678&w=2
> and added your Signed-off-by?

No problem, my patches are GPLed. Thanks!
								Pavel
								

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
