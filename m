From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [Patch v4] OMAP: sDMA driver: descriptor autoloading feature
Date: Mon, 4 Jan 2010 12:33:11 +0530
Message-ID: <618f0c911001032303p5d103f3et6271a71e1e5fbc96@mail.gmail.com>
References: <618f0c910912110701p771dcf6fg655bb0a7b9bdc96d@mail.gmail.com>
	 <20091228214846.GP3512@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:47239 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab0ADHDM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jan 2010 02:03:12 -0500
Received: by pwj9 with SMTP id 9so9109945pwj.21
        for <linux-omap@vger.kernel.org>; Sun, 03 Jan 2010 23:03:11 -0800 (PST)
In-Reply-To: <20091228214846.GP3512@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Dec 29, 2009 at 3:18 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Venkatraman S <svenkatr@ti.com> [091211 07:01]:
>> Here is the most updated version of the patch (thanks to Russell's
>> review). This patch is applicable to OMAP4xxx as well as OMAP3630
>> Reference to previous posts
>> v1 =A0http://marc.info/?l=3Dlinux-omap&m=3D125012097403050&w=3D2
>> v2 =A0http://marc.info/?l=3Dlinux-omap&m=3D125137152606644&w=3D2
>> v3 =A0http://patchwork.kernel.org/patch/45408/
>
> Do you have a patch for drivers/mmc/host/omap_hsmmc.c to
> use this feature? Or some other driver?
>
> Regards,
>
> Tony

I am about to start working on omap_hsmmc to use the descriptor load
feature. If the DMA changes are acceptable, I can post the driver
patch as well.

Best regards,

Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
