From: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap3-gta04: reduce panel backlight PWM
 frequency to 83Hz
Date: Sat, 10 Sep 2016 10:20:16 +0200
Message-ID: <CAALWOA8ZZBbgCG-5TRbd6=k27PQV2EHcCj6zwk31sKTHY1A7Bg@mail.gmail.com>
References: <954d43b570092fe92b8b49cf8f475c027d3d8342.1473066997.git.hns@goldelico.com>
 <20160910031736.xwnepaoifpedqfbr@squirrel.local> <3188F52F-1372-4D59-B790-C15E584A44F2@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3188F52F-1372-4D59-B790-C15E584A44F2-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: David Rivshin <drivshin-5fOYsn7Fw8lBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 10 September 2016 at 09:08, H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
> Reducing the PWM frequency is good by itself since it should not be unnecessarily
> fast and helps to make the PWM to "average current" translation more linear.
>
> The non-linear effect is that the PWM controlled DC/DC converter reacts almost
> immediately to a 1->0 control transition but needs some time (ca. 0.5ms) to recover
> on a 0->1 transition.

DT already allows for compensation of many non-linearities by
specifying the duty cycle of each brightness increment.  Though, as
you observed, there's one limitation it cannot fix here:

> If we just fix the PWM generator to output a steady 1 signal at 100%, we have a
> very significant change if we switch to 99%, depending on PWM frequency.

Specifically the next-to-brightest step (assuming 0.5ms off-time) would be:
75%  @ 500 Hz
90%  @ 200 Hz
95%  @ 100 Hz
96%  @  83 Hz

Note that perceptually the distance to 100% might be smaller due to
non-linear response of the eye. That's my experience with pwm
controlled leds anyway, which may or may not apply to backlights
(though with my laptop's backlight I never really have use for the
distinct steps at the brightest end while those at the darkest end
seem disproportionally large).

> This effect becomes smaller if the PWM frequency is reduced and 83Hz seems more
> reasonable (although still a little arbitrary) than the current value.

While 500Hz is perhaps a bit high, 83Hz actually seems very low to me.
Searching a bit around yielded 175 Hz as common frequency for CCFL
backlights and higher for LED backlights (source:
http://www.tftcentral.co.uk/articles/pulse_width_modulation.htm).

(I may be reacting a bit twitchy here due to having encountered dimmed
LED lighting that was flickering obnoxiously for me while noone else
noticed this.)

Matthijs
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
