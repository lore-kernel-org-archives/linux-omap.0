From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC][PATCH 0/5] Convert GPMC to driver
Date: Fri, 23 Mar 2012 16:05:47 +0530
Message-ID: <CAMQu2gzSk26kWgB4+xjB007_zogxQkR9c0po42n56wYYySz65w@mail.gmail.com>
References: <1332484567-21710-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:50923 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753755Ab2CWKgJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Mar 2012 06:36:09 -0400
Received: by qcmt36 with SMTP id t36so1805578qcm.15
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 03:36:08 -0700 (PDT)
In-Reply-To: <1332484567-21710-1-git-send-email-afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Mar 23, 2012 at 12:06 PM, Afzal Mohammed <afzal@ti.com> wrote:
> Hi,
>
> Convert GPCM code to be a driver. Existing GPMC
> NAND platform handling has been modified to work
> with the new GPMC driver (patches 2 & 3). Patch 5
> is to test the driver in OMAP3EVM.
>
> Once all the users has been converted to use this
> driver, would be converted to MFD type.
>
Much needed series. Thanks Afzal for doing it.

> TODO:
> 1. Let OMAP NAND driver deal with GPMC NAND block
> 2. Remove struct gpmc * stored as static
> 3. Convert all peripherals to use GPMC driver
> 4. Devise method to handle OneNAND cleanly
> 5. Handle acquiring CS# cases
> 6. Convert to MFD driver
>


> Afzal Mohammed (5):
> =A0ARM: OMAP2+: gpmc: driver conversion
> =A0ARM: OMAP2+: nand: create platform data structure
> =A0ARM: OMAP2+: gpmc-nand: populate gpmc configs
> =A0mtd: nand: omap2: obtain memory from resource
> =A0OMAP3EVM: Test gpmc-nand
>
Will have a look at your series next week.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
