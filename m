From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC PATCH 06/10] hwspinlock: OMAP4: Add spinlock support in DT
Date: Thu, 8 Sep 2011 10:56:17 +0300
Message-ID: <CAK=WgbYgatyLWqmrZnUfSGxCkZsRiJ3sbQwmenxyiJ6JBw5vJA@mail.gmail.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
 <1314191356-10963-7-git-send-email-b-cousson@ti.com> <CAK=WgbYX50R_MCgwdzywgrAEDJkmDSmeSSCuuqst5UBYk_sYow@mail.gmail.com>
 <4E686B71.2060107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37466 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192Ab1IHH4i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 03:56:38 -0400
Received: by wwf5 with SMTP id 5so570834wwf.1
        for <linux-omap@vger.kernel.org>; Thu, 08 Sep 2011 00:56:37 -0700 (PDT)
In-Reply-To: <4E686B71.2060107@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "G, Manjunath Kondaiah" <manjugk@ti.com>, Arnd Bergmann <arnd@arndb.de>, Mathieu Poirier <mathieu.poirier@linaro.org>

Hi Benoit,

On Thu, Sep 8, 2011 at 10:14 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hehe, I'm not the one who wrote that driver :-)
>
> This is not wrong for the current HW. The point is do we want to anticipate
> potential HW evolution that might never happen on that IP?

I originally really thought we can ignore those cases (hence the 0
base id ;), and personally I still think the scenario is a bit
fictional, and wouldn't even mind just having omap_hwspinlock_probe()
return an error if it is unexpectedly probed with a second device.

But if fixing this entirely only means doing a small change, then it's
surely nicer.

> This is no different than the multiple GPIO controllers we have today.
> Since we cannot rely on the DT nodes order, I added an explicit "id"
> attribute to provide that information to the driver. And then the baseid is
> "id * #gpios".

That would work if #hwspinlock is a fixed number, but a "baseid"
attribute would allow supporting devices with different #hwspinlocks
per device. Since I am not aware of any real hardware that does this
kind of blasphemy, I can't say if the latter is really necessary :) If
you prefer the former, I'm entirely fine with it.

Thanks,
Ohad.
