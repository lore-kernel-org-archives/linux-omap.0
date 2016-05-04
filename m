From: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/3] ARM: DRA7x: dts: Update the OSC_32K_CLK frequency
Date: Wed, 4 May 2016 16:09:40 +0200
Message-ID: <CAALWOA_4bqWo-izirjQUKb-YjiyBJwAdek_z60kjnEnj74Er7w@mail.gmail.com>
References: <20160427171658.GA5995@atomide.com> <1462209123-7332-1-git-send-email-Linux.HWI@garmin.com>
 <1462209123-7332-3-git-send-email-Linux.HWI@garmin.com> <57285E66.2000708@ti.com>
 <5728A81F.4050906@garmin.com> <20160503164323.GN5995@atomide.com> <5728E0BC.3080509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5728E0BC.3080509-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "J.D. Schroeder" <Linux.HWI-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, jay.schroeder-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 3 May 2016 at 18:43, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> Does a fixed divider calculation of input * (32768 / 27e6) make sense
> here too as pointed out earlier by Matthijs for the ti81xx?

That was an actual fractional divider, i.e. the output clock would be
exactly that ratio of the input clock, which would therefore yield
32768 Hz if the default crystal is used for the main osc.

It makes no sense to use it to describe a wobbly RC osc.


On 3 May 2016 at 19:32, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> wrote:
> Also, as it is security related, this is kind of sensitive area to discuss publicly.

Don't be silly. The only sense in which this clock is "security
related" is because it's used for the secure watchdog, and the reason
to use it despite its inaccuracy is completely obvious: an internal rc
osc can't be easily manipulated by an external attacker. I see no
reason to act all cloak-and-dagger about this.

(This seems to be a general theme to conceal "security related" things
from public documentation. If I were an HS customer I'd actually be
concerned about such behaviour since it would seem to indicate a lack
of confidence in one's security architecture.)

Matthijs
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
