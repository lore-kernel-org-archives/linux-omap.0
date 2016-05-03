From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 2/3] ARM: DRA7x: dts: Update the OSC_32K_CLK frequency
Date: Tue, 3 May 2016 11:08:26 -0700
Message-ID: <20160503180826.GP5995@atomide.com>
References: <20160427171658.GA5995@atomide.com>
 <1462209123-7332-1-git-send-email-Linux.HWI@garmin.com>
 <1462209123-7332-3-git-send-email-Linux.HWI@garmin.com>
 <57285E66.2000708@ti.com>
 <5728A81F.4050906@garmin.com>
 <20160503164323.GN5995@atomide.com>
 <5728E0BC.3080509@ti.com>
 <5728E495.4010502@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5728E495.4010502-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "J.D. Schroeder" <Linux.HWI-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jay.schroeder-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* J.D. Schroeder <Linux.HWI-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org> [160503 10:50]:
> On 05/03/2016 12:32 PM, Tero Kristo wrote:
> > Personally I would not recommend using this clock for any timing sensitive
> > applications. May I ask why you are interested in the exact clock rate of this
> > clock anyway?
> 
> I'm not interested in using this clock and I'm not sure how anyone would use
> this clock outside of the processor. See the inline comment that is part of
> the change and the commit message for the change. There is no hint in my
> change that this is an exact clock rate. It is a clarifying change to help
> others avoid using this clock as a 32 kHz clock (which the current clock name
> and frequency imply) and it more accurately represents the actual hardware
> behavior.

Well if it's inaccurate, how about we just add comments to the clock?

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
