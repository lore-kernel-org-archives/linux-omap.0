From: Laine Walker-Avina <lwalkera@ieee.org>
Subject: OMAP not resuming after waking from suspend to RAM after addition of
 the new OMAP serial drivers
Date: Thu, 4 Nov 2010 15:06:58 -0700
Message-ID: <AANLkTikVaBOtwSXHPPYyBHjFOS2yHODRAY7KV5Q3TjTL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40141 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab0KDWHA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Nov 2010 18:07:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi,

I'm having trouble resuming from RAM suspend with the recent addition
of the new omap-serial driver. It appears to be in some sort of loop
in serial_omap_console_putchar() sometime after console_release_sem()
is called in the resume path. Has this driver been tested going into
and out of suspend?

Thanks,
-- 
Laine Walker-Avina
Firmware Engineer
PASCO scientific
