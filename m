From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC PATCH 06/10] hwspinlock: OMAP4: Add spinlock support in DT
Date: Thu, 8 Sep 2011 11:11:35 +0300
Message-ID: <CAK=WgbbN-RYj2quMQOyYbEBBfV3gty4dOE7DgjvsRcoYO=F3kw@mail.gmail.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
 <1314191356-10963-7-git-send-email-b-cousson@ti.com> <CAK=WgbYX50R_MCgwdzywgrAEDJkmDSmeSSCuuqst5UBYk_sYow@mail.gmail.com>
 <4E686B71.2060107@ti.com> <CAK=WgbYgatyLWqmrZnUfSGxCkZsRiJ3sbQwmenxyiJ6JBw5vJA@mail.gmail.com>
 <4E6877A9.3090104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33128 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932252Ab1IHIL4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 04:11:56 -0400
Received: by wwf5 with SMTP id 5so586407wwf.1
        for <linux-omap@vger.kernel.org>; Thu, 08 Sep 2011 01:11:55 -0700 (PDT)
In-Reply-To: <4E6877A9.3090104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "G, Manjunath Kondaiah" <manjugk@ti.com>, Arnd Bergmann <arnd@arndb.de>, Mathieu Poirier <mathieu.poirier@linaro.org>

On Thu, Sep 8, 2011 at 11:07 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> The (small) issue for my point of view is that the #hwspinlock is already
> encoded in the IP itself. So adding a baseid directly in DT will look like
> duplicating indirectly something that is already there in the HW.
> That being said, since we cannot rely on the order, we will not be able to
> get the proper baseid until the driver probe every hwspinlock devices :-(
> So baseid might be a easier choice.

Sounds good. Thanks a lot !
