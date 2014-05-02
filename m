From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: Display not working if omapdrm is builtin with 3.15rc
Date: Fri, 2 May 2014 13:25:52 +0200
Message-ID: <CABxcv==fYi6fhTj9_qdoozooi6Su7KCao+GY9cx242_BwvC+Ew@mail.gmail.com>
References: <3A6485D2-7FEA-4C7E-9541-B814DFEE17A2@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:44838 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbaEBLZy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2014 07:25:54 -0400
Received: by mail-we0-f175.google.com with SMTP id q58so4447610wes.34
        for <linux-omap@vger.kernel.org>; Fri, 02 May 2014 04:25:52 -0700 (PDT)
In-Reply-To: <3A6485D2-7FEA-4C7E-9541-B814DFEE17A2@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hello Koen,

On Fri, May 2, 2014 at 12:47 PM, Koen Kooi <koen@dominion.thruhere.net> wrote:
> Hi,
>
> I've been trying to get DVI on my beagleboard XM to output a picture with mainline and with 3.15rc it still doesn't work. If I statically build in everything the drm encoders and connectors all go into deferred probe mode and fail, falling back to 1024x768. I with omapdrm and encoders/outputs/etc as modules deferred probe is avoided, far fewer error messages and a 1280x1024 resolution is being used. But still the monitor still says 'no signal' detected.
>
> So what's the magic to get an actual signal on the hdmi connector?
>
> regards,
>
> Koen--

This is a known issue as far as I know. You need [0] to correctly set
the display PLL clock rates.

Best regards,
Javier

[0]: http://permalink.gmane.org/gmane.linux.ports.arm.kernel/295077
