From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 0/3] OMAP: Introduce Backlight driver for Sharp
 LS037V7DW01 LCD panel
Date: Wed, 01 Dec 2010 17:32:55 +0200
Message-ID: <1291217575.10133.165.camel@tubuntu>
References: <1291118860-10325-1-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:50448 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857Ab0LAPdM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Dec 2010 10:33:12 -0500
In-Reply-To: <1291118860-10325-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Bryan Wu <bryan.wu@canonical.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com, rpurdie@rpsys.net

Hi,

On Tue, 2010-11-30 at 20:07 +0800, ext Bryan Wu wrote:
> After instroducing generic DPI panel driver for OMAP DSS2 system, we need to
> split out backlight driver from Sharp LS037V7DW01 panel driver before we move
> to the generic DPI panel driver.
> 
> This patchset introcuded backlight driver and cleanup the old Sharp LS037V7DW01
> panel driver related code.
> 
> It's built on mainline 2.6.37-rc4
> 
> Bryan Wu (3):
>   Backlight: driver for Sharp LS037V7DW01 panel on OMAP machine
>   OMAP: move Sharp LS LCD panel device to generic DPI panel driver and new backlight driver
>   OMAP: DSS2: remove Sharp LS037V7DW01 panel driver

I don't think this is quite the right direction.

All the backlight driver does is call a function in the board file. It's
not really a "sharp ls backlight driver", but rather generic one. I'm
not even sure if it needs the dssdev pointer.

This kind of backlight is, in a sense, totally separate component from
the panel itself. All they have in common is that they are packaged in
the same physical display module, and they usually share the same
connector.

I have seen three kinds of backlights on OMAP devices:
- on/off GPIO (like on 3430 SDP)
- PWM based (zoom seems to have this)
- Panel controlled (Taal-panel. Also PWM based, but OMAP doesn't see
that)

The first two could (should?) be totally separate backlights from the
panel itself. For those, a generic backlight driver could perhaps work.
The third one needs to be quite tied to the panel driver, and I'm not
sure how easy it would be to have a separate driver for that.

 Tomi


