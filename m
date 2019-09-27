From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] drm/omap: Migrate minimum FCK/PCK ratio from Kconfig to dts
Date: Fri, 27 Sep 2019 07:33:50 -0500
Message-ID: <CAHCN7xKocdiWOdmoWQV3POr84qte6WNt0QbQRAwxKSvU8COB_w@mail.gmail.com>
References: <20190510194229.20628-1-aford173@gmail.com> <af325707-3e42-493d-e858-77878ef06138@ti.com>
 <CAHCN7xLzoCNW6q5yDCsqMHeNvdNegkGhd0N+q9+Gd8JUGbG=_g@mail.gmail.com>
 <7ada0752-6f65-2906-cb29-a47c9490fd57@ti.com> <CAHCN7xJexJvh71vyb31ETgo=n_y_CupHH-AZwVK9mZe3GzJfEQ@mail.gmail.com>
 <845055e2-8182-de74-2077-629fdf50ac6c@ti.com> <CAHCN7xJFrTLOnbqrnH2W_T2whR8Xji0EMNR_cy8GYkDV-JDodQ@mail.gmail.com>
 <854f6130-c8a8-81cb-aa76-4830f218ae54@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <854f6130-c8a8-81cb-aa76-4830f218ae54@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, dri-devel <dri-devel@lists.freedesktop.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 27, 2019 at 2:55 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> (dropping folks who're probably not interested...)
>
> On 26/09/2019 17:12, Adam Ford wrote:
> > On Thu, Sep 26, 2019 at 1:55 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >>
> >> On 25/09/2019 23:51, Adam Ford wrote:
> >>
> >>>> Has anyone debugged why the hang is happening?
> >>> I started to debug this, but I got distracted when I noticed the LCD
> >>> did't work at all on modern kernels.  I have that fixed now, so I can
> >>> go back to investigating this.
>
> I dont' have the same board, but I was testing with omap3 beagle xm. I
> can reproduce rather similar issue, although I don't get a hang but
> instead sync lost and underflow flood (which makes the device unusable).
>
> It looks like a bug in omap clock handling.
>
> DSS uses dss1_alwon_fck_3430es2 as fclk. dss1_alwon_fck_3430es2 comes
> from dpll4_ck, and there's a divider after the PLL, dpll4_m4_ck.
>
> When the DSS driver sets dss1_alwon_fck_3430es2 rate to 27000000 or
> 27870967, which can be created with m4 dividers 32 and 31, it looks like
> the divider goes to bypass, or to a very small value. DSS gets a very
> high clock rate and breaks down.

Is there anything I can do to help troubleshoot this?  I could insert
a hack that checks if we're omap3 and if so make the divider equal to
4, but that seems like just a hack.
I can run more tests or insert code somewhere if you want.

adam
>
>   Tomi
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
