From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] drm/omap: Migrate minimum FCK/PCK ratio from Kconfig to dts
Date: Fri, 27 Sep 2019 07:13:59 -0500
Message-ID: <CAHCN7x+ysOEXFCE5DXvoPh6sQBdnHRE8t-KJfcijWesJRx9iXg@mail.gmail.com>
References: <20190510194229.20628-1-aford173@gmail.com> <af325707-3e42-493d-e858-77878ef06138@ti.com>
 <CAHCN7xLzoCNW6q5yDCsqMHeNvdNegkGhd0N+q9+Gd8JUGbG=_g@mail.gmail.com>
 <7ada0752-6f65-2906-cb29-a47c9490fd57@ti.com> <CAHCN7xJexJvh71vyb31ETgo=n_y_CupHH-AZwVK9mZe3GzJfEQ@mail.gmail.com>
 <845055e2-8182-de74-2077-629fdf50ac6c@ti.com> <CAHCN7xJFrTLOnbqrnH2W_T2whR8Xji0EMNR_cy8GYkDV-JDodQ@mail.gmail.com>
 <f6012b3a-7b96-6020-d09d-c458fa8742d8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f6012b3a-7b96-6020-d09d-c458fa8742d8@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, dri-devel <dri-devel@lists.freedesktop.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 27, 2019 at 1:22 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> On 26/09/2019 17:12, Adam Ford wrote:
>
> >> And what is the hdmi5_configure there? I don't see anything in the
> >> driver that would print hdmi5_configure. And, of course, there's no
> >> hdmi5 on that platform. Hmm, ok... it's from component.c, using "%ps".
> >> Somehow that goes wrong. Which is a bit alarming, but perhaps a totally
> >> different issue.
> >
> > I'll try to take a look later.  For Logic PD distributions, we create
> > a custom defconfig with all those drivers removed, so I'm not worked
> > up about it, but it would be nice to not call drivers that don't
> > exist.
>
> So you have CONFIG_OMAP5_DSS_HDMI=n? Then it's even more disturbing, as
> there's no way the string "hdmi5_configure" can be in the kernel image...

For the logs and problems I am showing in this thread, I am using a
stock omap2plus_defconfig which has it enabled.  I was only trying to
state that I am not worried about the omap5 hdmi stuff, because when I
do a custom distribution for Logic PD, I remove those config options
to make the issue go away.
>
> Maybe it's nothing, but... It's just so odd.

I don't think we need to worry about it now.  Ideally, it would be
nice to have the drivers recognize they are not needed and or setup
the Kconfig options to make these drivers dependent on the platforms
that support it so unselecting OMAP5 could make the omap5 options
disappear.

Sorry if I accidentally threw in a distraction or confusion.

adam
>
>   Tomi
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
