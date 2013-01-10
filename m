From: Dave Airlie <airlied@gmail.com>
Subject: Re: [RFC 0/4] TI LCDC DRM driver
Date: Thu, 10 Jan 2013 10:16:10 +1000
Message-ID: <CAPM=9tzZiQuVNdNhm9=iNWqAwk+uZRh0_YC3QLkyZbne5dfeyg@mail.gmail.com>
References: <1357704685-3600-1-git-send-email-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:62025 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206Ab3AJAQL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jan 2013 19:16:11 -0500
Received: by mail-ob0-f171.google.com with SMTP id dn14so2845392obc.16
        for <linux-omap@vger.kernel.org>; Wed, 09 Jan 2013 16:16:10 -0800 (PST)
In-Reply-To: <1357704685-3600-1-git-send-email-robdclark@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Wed, Jan 9, 2013 at 2:11 PM, Rob Clark <robdclark@gmail.com> wrote:
> Updated version of DRM driver for TI LCD Controller.  Since the initial
> version of the patch, which only supported TFP410 DVI output, I've added
> an output driver for LCD panels (for example, LCD3 or LCD7 cape for the
> beagle-bone), and initial support for HDMI output via NXP TDA19988 HDMI
> encoder (via i2c encoder-slave output driver).
>
> At this point, I think the basic lcdc drm driver plus TFP410 DVI output
> (first patch) is in reasonable shape (barring potential rename, if lcdc
> is too generic of a name... but I was not feeling creative enough yet to
> pick a new name).

I'd like at least tilcdc :-)

Dave.
