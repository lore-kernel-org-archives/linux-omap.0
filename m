From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2] Input: omap4-keypad: Add pinctrl support
Date: Thu, 1 Nov 2012 09:54:00 +0100
Message-ID: <CACRpkdbCk9+HSBPtfT-1dO8paSRYJ5VXX_0SxiyxgrObnJEvmQ@mail.gmail.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121024161429.GA16350@core.coreip.homeip.net>
 <CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
 <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
 <CACRpkdaiLXVeUg1quuw3XPTenbKOjn+aWbGQezpcyvzQCtCWow@mail.gmail.com>
 <20121030113407.GA24335@sirena.org.uk>
 <CACRpkdapQJY0aoam741O0fb8EeM9BLk_Psq5TaPG84J7wEvCLw@mail.gmail.com>
 <87obji8kta.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4172150913260462090=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <87obji8kta.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============4172150913260462090==
Content-Type: multipart/alternative; boundary=047d7b62275e180d8404cd6b2995

--047d7b62275e180d8404cd6b2995
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Oct 31, 2012 at 9:10 PM, Kevin Hilman
<khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>wrote:

> Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>


> > piece of hardware, this would be the right thing to do,
> > and I think the in-kernel examples are all "simple",
> > e.g. arch/arm/mach-omap2/powerdomain* is all about
> > power domains and nothing else,
>
> FYI... that code isn't the same as PM domain.


This sort of points to a core problem here. Our terminologies are
ambiguous that we cannot understand each others code. As long
as <linux/pm_domain.h> begins:

/*
 * pm_domain.h - Definitions and headers related to device power domains.
 *

But arguably that should just be patched (I think there are a few
remnants in the code still implying that these things are only about
power).


>  That code is for the
> *hardware* powerdomains, not the software concept of "PM domain."  In
> OMAP, PM domain is implmented at the omap_device level.  And omap_device
> is the abstraction of an IP block that knows about all the PM related
> register settings, clocks, HW powerdomain, voltage domain, PM related
> pin-muxing etc. etc.    All of these things are abstracted in an
> omap_device, so that the PM domain implementation for OMAP looks rather
> simple (c.f. omap_device_pm_domain in arch/arm/plat-omap/omap_device.c.)
>

OK following now...


> > I think the lesser of two evils is the distributed approach,
>
The pinctrl examples I've seen mentioned so far are all PM related
> (sleep, idle, wakeup, etc.) so to me I think they still belong in
> PM domains (and that's how we handle the PM related pins in OMAP.)
>

Well, the pinctrl grabbers in these drivers are using these states also
for platforms that do not even select CONFIG_PM.  For example
mach-nomadik is quite happy that the PL011 driver is thusly
muxing in its pins. And would require refactoring to use PM
domains.

So basically this requirement comes down to:

- When dealing with a SoC IP block driver

- That need to multiplex pins

- Then your SoC must select CONFIG_PM and
  CONFIG_PM_RUNTIME and
  CONFIG_PM_GENERIC_DOMAINS and implement
  proper domain handling hooks.

Is this correct? And for Mark, Dmitry, does this correspond to
your view?

It's actually something that needs to be acknowledged by the
ARM SoC maintainers, because they will be the ones telling
all subarch maintainers to go implement full PM handling
with these three frameworks whenever an SoC driver want
to handle pins.

Bascially all subsystem maintainers dealing with embedded
SoCs need to be aligned on this as well...

And IIUC not only pins but also silicon block clocks?

I can surely fix these for "my" systems, but it really needs
to be enforced widely or it will be a mess.


>  > I worry that the per-SoC power domain implementation
> > which will live in arch/arm/mach-* as of today will become
> > the new board file problem, overburdening the arch/* tree.
> > Maybe I'm mistaken as to the size of these things,
> > but just doing ls arch/arm/mach-omap2/powerdomain*
> > makes me start worrying.
>
> Yes, I agree that this means more code/data in arch/arm/mach-*, but
> IMO, that's really where it belongs.  It really is SoC integration
> details, and driver should really not know about it.


OK we need feedback from ARM SoC on this.

Yours,
Linus Walleij

--047d7b62275e180d8404cd6b2995
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, Oct 31, 2012 at 9:10 PM, Kevin Hilman <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org" target=
=3D"_blank">khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org</a>&gt;</span> wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"im">Linus Walleij &lt;<a href=3D"mailto=
:linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt; writes:</div></=
div></blockquote><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"im">&gt; piece of hardware, this would =
be the right thing to do,<br>
&gt; and I think the in-kernel examples are all &quot;simple&quot;,<br>
&gt; e.g. arch/arm/mach-omap2/powerdomain* is all about<br>
&gt; power domains and nothing else,<br>
<br>
</div></div>FYI... that code isn&#39;t the same as PM domain.</blockquote><=
div><br>This sort of points to a core problem here. Our terminologies are<b=
r>ambiguous that we cannot understand each others code. As long<br>as &lt;l=
inux/pm_domain.h&gt; begins:<br>
<br>/*<br>=A0* pm_domain.h - Definitions and headers related to device powe=
r domains.<br>=A0*<br><br>But arguably that should just be patched (I think=
 there are a few<br>remnants in the code still implying that these things a=
re only about<br>
power).<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"> =A0That code is for the=
<br>
*hardware* powerdomains, not the software concept of &quot;PM domain.&quot;=
 =A0In<br>
OMAP, PM domain is implmented at the omap_device level. =A0And omap_device<=
br>
is the abstraction of an IP block that knows about all the PM related<br>
register settings, clocks, HW powerdomain, voltage domain, PM related<br>
pin-muxing etc. etc. =A0 =A0All of these things are abstracted in an<br>
omap_device, so that the PM domain implementation for OMAP looks rather<br>
simple (c.f. omap_device_pm_domain in arch/arm/plat-omap/omap_device.c.)<br=
></blockquote><div><br>OK following now...<br>=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
&gt; I think the lesser of two evils is the distributed approach, <br></blo=
ckquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">The pinctrl examples I&#39;ve seen m=
entioned so far are all PM related<br>

(sleep, idle, wakeup, etc.) so to me I think they still belong in<br>
PM domains (and that&#39;s how we handle the PM related pins in OMAP.)<br><=
/blockquote><div><br>Well, the pinctrl grabbers in these drivers are using =
these states also<br>for platforms that do not even select CONFIG_PM.=A0 Fo=
r example<br>
mach-nomadik is quite happy that the PL011 driver is thusly<br>muxing in it=
s pins. And would require refactoring to use PM<br>domains.<br><br>So basic=
ally this requirement comes down to:<br><br>- When dealing with a SoC IP bl=
ock driver<br>
<br>- That need to multiplex pins<br><br>- Then your SoC must select CONFIG=
_PM and<br>=A0 CONFIG_PM_RUNTIME and<br>=A0 CONFIG_PM_GENERIC_DOMAINS and i=
mplement<br>=A0 proper domain handling hooks.<br><br>Is this correct? And f=
or Mark, Dmitry, does this correspond to<br>
your view?<br><br>It&#39;s actually something that needs to be acknowledged=
 by the<br>ARM SoC maintainers, because they will be the ones telling<br>al=
l subarch maintainers to go implement full PM handling<br>with these three =
frameworks whenever an SoC driver want<br>
to handle pins.<br><br>Bascially all subsystem maintainers dealing with emb=
edded<br>SoCs need to be aligned on this as well...<br><br>And IIUC not onl=
y pins but also silicon block clocks?<br><br>I can surely fix these for &qu=
ot;my&quot; systems, but it really needs<br>
to be enforced widely or it will be a mess.<br>=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<div class=3D"im">
&gt; I worry that the per-SoC power domain implementation<br>
&gt; which will live in arch/arm/mach-* as of today will become<br>
&gt; the new board file problem, overburdening the arch/* tree.<br>
&gt; Maybe I&#39;m mistaken as to the size of these things,<br>
&gt; but just doing ls arch/arm/mach-omap2/powerdomain*<br>
&gt; makes me start worrying.<br>
<br>
</div>Yes, I agree that this means more code/data in arch/arm/mach-*, but<b=
r>
IMO, that&#39;s really where it belongs. =A0It really is SoC integration<br=
>
details, and driver should really not know about it.</blockquote><div><br>O=
K we need feedback from ARM SoC on this.<br><br>Yours,<br>Linus Walleij<br>=
</div></div>

--047d7b62275e180d8404cd6b2995--

--===============4172150913260462090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4172150913260462090==--
