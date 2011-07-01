From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [linux-pm] runtime PM usage_count during driver_probe_device()?
Date: Fri, 1 Jul 2011 19:32:33 +0800
Message-ID: <BANLkTimRRZ9Ld5rtpQMT3PhmOCn+qOxBcQ@mail.gmail.com>
References: <87k4c3dktm.fsf@ti.com>
	<87vcvmaml6.fsf@ti.com>
	<201107010233.12377.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:59471 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab1GALcd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 07:32:33 -0400
Received: by yia27 with SMTP id 27so1264969yia.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 04:32:33 -0700 (PDT)
In-Reply-To: <201107010233.12377.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Kevin Hilman <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>

Hi,

On Fri, Jul 1, 2011 at 8:33 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> In theory it is possible that a subsystem (e.g. bus type) will enable
> runtime PM for devices without drivers and will (for example) put the=
m
> into low power states until the drivers are loaded. =A0Then, it makes
> sense for the core to prevent such transitions from racing with .prob=
e().
>
> I'm not sure if this happens in practice, though, but also I'm not su=
re
> whether or not that's used by USB. =A0Moreover, even if that doesn't =
happen
> right now, it may start to happen at one point.

It should be used by USB, for example, uvcvideo driver has enabled
auto suspend already:

    - rmmod uvcvideo

    - usb video class device auto suspended

    - modprobe uvcvideo       #driver_probe_device()


thanks,
--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
