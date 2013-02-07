From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: MUSB regression in linux next at least for pandboard
Date: Thu, 7 Feb 2013 16:10:31 +0200
Message-ID: <CANOLnOODiu+rEqCQH5BAzTXhWi4cUZO-OXO=-1xxyhMFW77UZQ@mail.gmail.com>
References: <Pine.LNX.4.44L0.1302061038310.1893-100000@iolanthe.rowland.org>
	<511370D7.9070509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:43657 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359Ab3BGOKc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Feb 2013 09:10:32 -0500
In-Reply-To: <511370D7.9070509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@ti.com>, Vivek Gautam <gautamvivek1987@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-usb@vger.kernel.org, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, linux-omap@vger.kernel.org

On Thu, Feb 7, 2013 at 11:16 AM, Roger Quadros <rogerq@ti.com> wrote:
<snip>
> It seems the beagleboard problem is related to OMAP silicon errata [1=
].
> Apparently, remote wakeup as well as host issued wakeup break omap-eh=
ci and have
> nothing to do with the hub or it's driver.
>
> I'll work on this issue after I'm done with device tree migration.

Looking forward to this, mainline has been suffering from this since
almost forever..


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
