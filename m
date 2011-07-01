From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [linux-pm] runtime PM usage_count during driver_probe_device()?
Date: Fri, 1 Jul 2011 08:57:40 +0300
Message-ID: <BANLkTikLna-jbrNfD2fz_QC1BfrCHpByNA@mail.gmail.com>
References: <87k4c3dktm.fsf@ti.com> <87vcvmaml6.fsf@ti.com> <201107010233.12377.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61953 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab1GAF6C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 01:58:02 -0400
Received: by wwe5 with SMTP id 5so2904533wwe.1
        for <linux-omap@vger.kernel.org>; Thu, 30 Jun 2011 22:58:00 -0700 (PDT)
In-Reply-To: <201107010233.12377.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Kevin Hilman <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>

On Fri, Jul 1, 2011 at 3:33 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> In theory it is possible that a subsystem (e.g. bus type) will enable
> runtime PM for devices without drivers and will (for example) put the=
m
> into low power states until the drivers are loaded. =A0Then, it makes
> sense for the core to prevent such transitions from racing with .prob=
e().
>
> I'm not sure if this happens in practice, though,

Yeah, this is exactly what the SDIO subsystem is doing.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
