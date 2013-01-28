From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 1/4] drm/tilcdc: add TI LCD Controller DRM driver (v3)
Date: Mon, 28 Jan 2013 10:37:13 -0600
Message-ID: <CAF6AEGtZvjh+==3rFo5gnZqF=orY=YqXf1fndYhE5s74v=rT1Q@mail.gmail.com>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
	<1358894185-21617-2-git-send-email-robdclark@gmail.com>
	<C8443D0743D26F4388EA172BF4E2A7A93EA939BB@DBDE01.ent.ti.com>
	<CAF6AEGsqkUr0R3eYa4P371tUPq_NLSJLhH=N_MkyJF31s068+g@mail.gmail.com>
	<C8443D0743D26F4388EA172BF4E2A7A93EA93A7D@DBDE01.ent.ti.com>
	<CAF6AEGtrHBxvnp052K6z3aj3dAxJf1hy7H72EoAWr6PhTtwr8Q@mail.gmail.com>
	<C8443D0743D26F4388EA172BF4E2A7A93EA944D2@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:57284 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757384Ab3A1QhO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jan 2013 11:37:14 -0500
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA944D2@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "patches@linaro.org" <patches@linaro.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, "Nori, Sekhar" <nsekhar@ti.com>

On Mon, Jan 28, 2013 at 3:56 AM, Mohammed, Afzal <afzal@ti.com> wrote:
> Hi Rob,
>
> On Fri, Jan 25, 2013 at 20:22:55, Rob Clark wrote:
>> On Fri, Jan 25, 2013 at 8:15 AM, Mohammed, Afzal <afzal@ti.com> wrote:
>
>> > It's not about being simple, but not doing the wrong way, here you are
>> > relying on a platform specific clock in a driver, think about the case
>> > where same IP is used on another platform. Either way it is not a good
>> > thing to handle platform specific details (about disp_clk) in driver.
>
>> Right, but I was trying to understand what was the benefit that the
>> added complexity is.  I didn't realize on davinci that you are limited
>
> Here I am referring to usage of disp_clk,
>
> Driver is not supposed to do platform hacks - here you are trying to
> configure something (PLL) in your driver which is not part of LCDC IP.
> And LCDC IP is not aware of PLL which is a platform specific matter
> (existent only in AM335x), it is only aware of functional clock.
>
> You can set the rate on "fck" (functional clock) in AM335x using my patch,
> "ARM: AM33XX: clock: SET_RATE_PARENT in lcd path", and there
> would not be any need for driver to be aware of platform specific PLL.

right, but I think it would be better to just make another patch that
changes tilcdc to just set rate on fck after that patch is merged.  I
mean, I'd rather have the driver at least usable on AM33xx until then,
rather than broken for everyone.

BR,
-R

>> >> >> +     priv->clk = clk_get(dev->dev, "fck");
>
>> >> >> +     priv->disp_clk = clk_get(dev->dev, "dpll_disp_ck");
>
>> at the moment all this discussion is a bit moot.  I'd propose leaving
>> the driver as it is for now, because that at least makes it useful on
>> am33xx.  And when CCF and davinci have the needed support in place,
>
> Let's forget about leveraging CCF in driver, but sane solution w.r.t PLL
> configuration would be to do as mentioned above.
>
> Regards
> Afzal
>
