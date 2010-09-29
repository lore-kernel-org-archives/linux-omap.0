From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH v4] usb: musb: Adding names for IRQs in resource structure
Date: Wed, 29 Sep 2010 09:48:57 -0400
Message-ID: <AANLkTi=88-rc3T5Q=CKy3rUo10MbEPGWujMkA++Hc9ot@mail.gmail.com>
References: <1285777599-24245-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36772 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab0I2NtS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 09:49:18 -0400
In-Reply-To: <1285777599-24245-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Wed, Sep 29, 2010 at 12:26, Hema HK wrote:
> The resource data is getting automatically populated from a set of data
> generated from TI's hardware database for the OMAP platform,
> While we could hack in some exceptions to that tool to generate resources
> in a specific order, it seems less fragile to use the resource name
> instead.That way, no matter what order the resources are generated, the
> driver still work.
>
> Modified the OMAP,Blackfin and Davinci architecture files to add the name of the IRQs
> in the resource structures and musb driver to use the get_irq_byname() api to
> get the device and dma irq numbers instead of using the index.
>
> Signed-off-by: Hema HK <hemahk@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Mike Frysinger <vapier@gentoo.org>

if Felipe is ok with this, then i'm ok with this
Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
