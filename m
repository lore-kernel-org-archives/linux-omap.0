From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 4/4] OMAP3/4: iommu: adapt to runtime pm
Date: Tue, 27 Dec 2011 11:41:29 +0200
Message-ID: <CAMP44s2zKVRd3+uJUAo+WaaV=n9LvM-5q_cFivEtE=iTzFbfeg@mail.gmail.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
	<1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
	<CAMP44s3Jb9DZLUyDVU_HmQbaJKp=2qym7Z6uauNchJh0fPL4hQ@mail.gmail.com>
	<CAB-zwWhpmwRP2mNu-CdX-RVgmTRjw0UsYckAVsM+qztmVdvc7A@mail.gmail.com>
	<CAMP44s0hYWiZ8OnjQ6Jy_W7MCveP+WyHG18Tt2jRGzxSwoQP3w@mail.gmail.com>
	<CAB-zwWio5iMTyofv3Hx5Q7G7rYY5cRU4kXNQzMF0NRprEd8=5g@mail.gmail.com>
	<CAMP44s2JWRN4XVCVrbVUJwZK9zkT6p2dPnK2SPuZXJPj71c4Yg@mail.gmail.com>
	<CAB-zwWicBq8sUZCiRLP_6QX3jL7gsTvF0-NP1r+AvDWP+aWsMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41425 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813Ab1L0Jlb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Dec 2011 04:41:31 -0500
In-Reply-To: <CAB-zwWicBq8sUZCiRLP_6QX3jL7gsTvF0-NP1r+AvDWP+aWsMg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, iommu@lists.linux-foundation.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

On Sun, Dec 25, 2011 at 2:03 AM, Ramirez Luna, Omar <omar.ramirez@ti.com> wrote:
> On Fri, Dec 23, 2011 at 11:04 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Which omap-iommu? The platform driver, or the device stuff? The device
>> stuff is always built-in, but not the platform driver
>> (drivers/iommu/omap-iommu.c), that can be a module.
>
> Both, I can't recall exactly when it changed (prior to being moved to
> drivers/iommu it could be built as a module), but now
> CONFIG_OMAP_IOMMU is boolean type.

I see. Still, it looks like the proper way to use the API is to call
_enable() on the platform driver.

-- 
Felipe Contreras
