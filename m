From: Pavel Machek <pavel@ucw.cz>
Subject: Re: RGB LED control (was Re: "advanced" LED controllers)
Date: Tue, 10 Mar 2015 09:04:21 +0100
Message-ID: <20150310080420.GA31091@amd>
References: <20150219211424.GN13603@saruman.tx.rr.com>
 <CAMuHMdUUNzFYHzSR3yLCJuz11vuO3Z4yVWVxRQfutGY1KxZLPQ@mail.gmail.com>
 <CAAVeFuJ7DCs_=iESJRcXwyQ09eD57dZCxGG5CD3LD9_ZGZHP2A@mail.gmail.com>
 <20150302092111.GA19233@amd>
 <CAAVeFuK9eGO2TN+tgDyN8EFzEhgHOy5YCch+LaqS9PNaQXQ4Qg@mail.gmail.com>
 <20150308205732.GA385@amd>
 <CAMuHMdUVgZ1i5zymxmi3-i98n9UPTV=Sq-Oa=ieyfOzETW-DzA@mail.gmail.com>
 <yw1xd24i1ja7.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <yw1xd24i1ja7.fsf@unicorn.mansr.com>
Sender: linux-leds-owner@vger.kernel.org
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Alexandre Courbot <gnurou@gmail.com>, Felipe Balbi <balbi@ti.com>, Bryan Wu <cooloney@gmail.cofm>, Richard Purdie <rpurdie@rpsys.net>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon 2015-03-09 11:50:56, M=E5ns Rullg=E5rd wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>=20
> > Hi Pavel,
> >
> > On Sun, Mar 8, 2015 at 9:57 PM, Pavel Machek <pavel@ucw.cz> wrote:
> >> Ok, so I played with RGB LED a bit, and we have quite a gap in
> >> documentation: what 50% brightness means is non-trivial and very
> >> important in case we want to do smooth blinking and color transiti=
ons.
> >>
> >> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documenta=
tion/ABI/testing/sysfs-class-led
> >> index 3646ec8..649d7a6 100644
> >> --- a/Documentation/ABI/testing/sysfs-class-led
> >> +++ b/Documentation/ABI/testing/sysfs-class-led
> >> @@ -8,6 +8,11 @@ Description:
> >>                 non-zero brightness settings. The value is between=
 0 and
> >>                 /sys/class/leds/<led>/max_brightness.
> >>
> >> +               If LED supports continuous brightness settings, 50=
% brightness
> >> +               should correspond to 50% brightness perceived by h=
uman, in a similar
> >> +               manner pixel brightness on monitor does (not 50% P=
WM).
> >
> > How many drivers do it right? How many don't?
> >
> > For those that don't, perhaps we handle the conversion between perc=
eived and
> > pwm in the core, e.g. by adding a new flag to led_classdev.flags to=
 indicate
> > the need for conversion?
>=20
> Some LED controllers do the right thing in hardware, so any adjustmen=
t
> done in the core needs to be optional.

Do you have example controller that gets it right, btw?

Bryan, can you apply the documentation patch so we can start fixing
the drivers?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
