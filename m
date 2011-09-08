From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 06/10] hwspinlock: OMAP4: Add spinlock support in DT
Date: Thu, 8 Sep 2011 16:47:55 +0200
Message-ID: <201109081647.55377.arnd@arndb.de>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com> <4E6877A9.3090104@ti.com> <CAK=WgbbN-RYj2quMQOyYbEBBfV3gty4dOE7DgjvsRcoYO=F3kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64367 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab1IHOsI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 10:48:08 -0400
In-Reply-To: <CAK=WgbbN-RYj2quMQOyYbEBBfV3gty4dOE7DgjvsRcoYO=F3kw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "G, Manjunath Kondaiah" <manjugk@ti.com>, Mathieu Poirier <mathieu.poirier@linaro.org>

On Thursday 08 September 2011, Ohad Ben-Cohen wrote:
> On Thu, Sep 8, 2011 at 11:07 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> > The (small) issue for my point of view is that the #hwspinlock is already
> > encoded in the IP itself. So adding a baseid directly in DT will look like
> > duplicating indirectly something that is already there in the HW.
> > That being said, since we cannot rely on the order, we will not be able to
> > get the proper baseid until the driver probe every hwspinlock devices :-(
> > So baseid might be a easier choice.
> 
> Sounds good. Thanks a lot !

I think a number would work here but is not optimal for the device tree
representation. I think a better binding would be to encode it like
interrupt numbers, where every device that uses a hwspinlock will describe
that as a combination of phandle to the hwspinlock controller and
identifier to be used by that controller, e.g.

	spinlock1 {
		compatible = "ti,omap-spinlock";
		regs = ...
		interrupts = <42>;
		interrupt-parent = &irq-controller;
	};

	dsp {
		compatible = ...
		regs = ...
		spinlocks = <23>; // local number withing &spinlock1;
		spinlock-controller = &spinlock1;
	};

or possibly shorter

		spinlocks = <&spinlock1 23>;

	Arnd
