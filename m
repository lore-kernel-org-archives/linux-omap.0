From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: usb: gadget breakage on N900: bind UDC by name passed via
 usb_gadget_driver structure
Date: Fri, 18 Mar 2016 09:47:57 +0200
Message-ID: <CAB=otbSfj24nSUe1DyfVBDKD=trCp2-X-S-AcA1D+PTHZuP1Bg@mail.gmail.com>
References: <20160317212603.GA16651@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160317212603.GA16651@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Maxime Ripard <maxime.ripard@free-electrons.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Peter Chen <peter.chen@freescale.com>, "Balbi, Felipe" <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Pavel

On Thu, Mar 17, 2016 at 11:26 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> USB gadget stops working for me on n900, if I merge

Could you please give us more details?
Which gadget driver do you use (g_nokia?)

>
> usb: gadget: bind UDC by name passed via usb_gadget_driver structure
>
> patch.
>
> commit 2284b29d3d9dd16490909962574d7f3fef83fd97
> Author: Ruslan Bilovol <ruslan.bilovol@gmail.com>
> Date:   Mon Nov 23 09:56:35 2015 +0100
>
>     usb: gadget: bind UDC by name passed via usb_gadget_driver
>     structure
>
>     Introduce new 'udc_name' member to usb_gadget_driver structure.
>         The 'udc_name' is a name of UDC that usb_gadget_driver should
>             be bound to. If udc_name is NULL, it will be bound to any
>                 available UDC.
>
>     Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>         Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
>             Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>                 Tested-by: Peter Chen <peter.chen@freescale.com>
>                     Signed-off-by: Felipe Balbi <balbi@ti.com>
>
>
> Patch is obvious enough... if there's someone who sets udc_name to
> NULL. Who is supposed to do that?

That is done automatically if you use libcomposite.
There is a static usb_gadget_driver composite_driver_template structure in
composite.c that is used in usb_composite_probe later (used by libcomposite
based gadgets). Since it's statically declared, 'udc_name' member is set
to NULL automatically.

Other gadgets (not based on libcomposite) use same approach with
statically declared usb_gadget_driver structure.

>
> (I have patch in my tree to make USB gadget work when it is not
> modular).

So this can be reproduced only on builtin gadget, right?

BTW, I have N900 and can try to play with it this weekend if you'll
give us more details.

Best regards,
Ruslan

>
> Best regards,
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
