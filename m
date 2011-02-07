From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: Re: State of SDP4430 platform
Date: Mon, 7 Feb 2011 12:28:17 +0530
Message-ID: <AANLkTinCucO235HDDVs=kMXwKD7nBeUa__YZgBfaKo0n@mail.gmail.com>
References: <20110116010936.GA21795@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1101152255100.13225@utopia.booyaka.com>
	<a40bc7a304b60cef73a3a0cfb84b2ee8@mail.gmail.com>
	<ceedbf20a12a6e821fda1496b10297a2@mail.gmail.com>
	<20110206094919.GA11707@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:42136 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752476Ab1BGG6S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 01:58:18 -0500
Received: by mail-vw0-f49.google.com with SMTP id 5so2853459vws.22
        for <linux-omap@vger.kernel.org>; Sun, 06 Feb 2011 22:58:17 -0800 (PST)
In-Reply-To: <20110206094919.GA11707@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

On Sun, Feb 6, 2011 at 3:19 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> lm75 3-0048: hwmon0: sensor 'tmp105'
> omap_i2c omap_i2c.1: controller timed out
> omap_i2c omap_i2c.1: controller timed out
> omap_i2c omap_i2c.2: controller timed out
> omap_i2c omap_i2c.2: controller timed out
> omap_i2c omap_i2c.2: controller timed out
> omap_i2c omap_i2c.2: controller timed out
> omap_i2c omap_i2c.3: controller timed out
> omap_i2c omap_i2c.3: controller timed out
> omap_i2c omap_i2c.3: controller timed out
> omap_i2c omap_i2c.4: controller timed out
> omap_i2c omap_i2c.4: controller timed out
> omap_i2c omap_i2c.4: controller timed out
> omap_i2c omap_i2c.4: controller timed out

These timeouts are from tmp105 driver
lm75 - temperature sensor is trying to probe all i2c bus and it gets NACK.
i2c controller timeout after NACK is due to a bug in omap_i2c driver.
Will send a patch for this.

Can you disable LM75 untill then.
