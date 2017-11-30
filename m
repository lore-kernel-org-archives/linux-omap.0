From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 4/4] DTS: Pandora: fix panel compatibility string
Date: Thu, 30 Nov 2017 07:24:30 -0800
Message-ID: <20171130152430.GM28152@atomide.com>
References: <cover.1511884135.git.hns@goldelico.com>
 <b6001c7b7fb98e7a3ad4c712084fea9dae9e6b27.1511884135.git.hns@goldelico.com>
 <20171128160437.GD28152@atomide.com>
 <ADAFBBA4-6AC4-4EC4-AB0E-98B59718E12E@goldelico.com>
 <20171128161834.GE28152@atomide.com>
 <4EE1E298-6461-48FF-977C-958DD16AD83A@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4EE1E298-6461-48FF-977C-958DD16AD83A@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Russell King <linux@armlinux.org.uk>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@op>
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [171128 18:35]:
> Hi,
> 
> > Am 28.11.2017 um 17:18 schrieb Tony Lindgren <tony@atomide.com>:
> > 
> > * H. Nikolaus Schaller <hns@goldelico.com> [171128 16:17]:
> >> Hi Tony,
> >> 
> >>> Am 28.11.2017 um 17:04 schrieb Tony Lindgren <tony@atomide.com>:
> >>> 
> >>> * H. Nikolaus Schaller <hns@goldelico.com> [171128 15:52]:
> >>>> We can remove the unnecessary "omapdss," prefix because
> >>>> the omapdrm driver takes care of it when matching with
> >>>> the driver table.
> >>> 
> >>> So is this needed as a fix or is this another clean-up?
> >>> 
> >>> So is this is really needed as a fix?
> >> 
> >> Hm. How do you differentiate between "fix" and "cleanup"?
> >> Maybe it is more a wording than a content issue...
> >> 
> >> For me it is a "fix" because it is semantically wrong to have
> >> a prefix where it is not needed. And "fixing" it changes the
> >> compiler output by 8 bytes.
> > 
> > How about let's call it a "typo fix" then? :)
> 
> Well, it is not really a typo.

Well what if the stable people pick it into earlier stable series
based on the word fix in the subject? That has happened before.

I suggest you update the dts patches to use wording like
"update compatible to use new naming" or something similar.

Regards,

Tony
