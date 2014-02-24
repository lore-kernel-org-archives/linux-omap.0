From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
Date: Mon, 24 Feb 2014 17:22:27 -0300
Message-ID: <CABxcv=kKxidVJWcMrueB+edW=g_6gcucvi6=7p=EZ_WooCpbMA@mail.gmail.com>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>
	<1393261669-32039-3-git-send-email-florian.vaussard@epfl.ch>
	<20140224180336.GU27282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:63287 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbaBXUW3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Feb 2014 15:22:29 -0500
Received: by mail-wg0-f41.google.com with SMTP id l18so3176469wgh.4
        for <linux-omap@vger.kernel.org>; Mon, 24 Feb 2014 12:22:28 -0800 (PST)
In-Reply-To: <20140224180336.GU27282@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ash Charles <ash@gumstix.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Russell,

On Mon, Feb 24, 2014 at 3:03 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Feb 24, 2014 at 06:07:49PM +0100, Florian Vaussard wrote:
>> +     hdmi0: connector@0 {
>> +             compatible = "hdmi-connector";
>
> This looks way to generic a compatible string.  Are you sure it's
> correct?
>

That compatible string is correct according to the latest series
posted by Tomi Valkeinen to add DT bindings for the OMAP Display
SubSystem (DSS) [0].

The property is added on this patch [1] and as far as I understood the
idea is that it could be a generic DT binding that can be used by
platform specific HDMI connectors like the omap dss HDMI connector
[2].

I'm adding Tomi to the cc list so he can a correct me if I'm wrong.

Thanks a lot and best regards,
Javier

[0]: http://www.spinics.net/lists/linux-omap/msg102522.html
[1]: http://www.spinics.net/lists/linux-omap/msg102559.html
[2]: http://www.spinics.net/lists/arm-kernel/msg302197.html
