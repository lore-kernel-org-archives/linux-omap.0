From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC PATCH 03/14] ARM: OMAP1: ams-delta: Provide board specific partition info
Date: Wed, 12 Feb 2020 19:25:52 +0100
Message-ID: <4506487.GXAFRqVoOG@z50>
References: <20200212003929.6682-1-jmkrzyszt@gmail.com> <20200212003929.6682-4-jmkrzyszt@gmail.com> <20200212145154.GK64767@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43469 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLSZ5 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 12 Feb 2020 13:25:57 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so3453945ljm.10
        for <linux-omap@vger.kernel.org>; Wed, 12 Feb 2020 10:25:56 -0800 (PST)
In-Reply-To: <20200212145154.GK64767@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>

Hi Tony,

On Wednesday, February 12, 2020 3:51:54 P.M. CET Tony Lindgren wrote:
> * Janusz Krzysztofik <jmkrzyszt@gmail.com> [200212 00:41]:
> > Now as the Amstrad Delta NAND driver supports fetching information on
> > MTD partitions from device platform data, add partition info to the
> > NAND device configuration.
> 
> Fine if you want hardcoded partition info :) Not sure if the partition
> info coming from bootloader is any better either.. Ideally there would
> be a partition table somewhere on the device like we have for disks..

Yeah, but Amstrad didn't provide anything like that, and we may want to get 
convenient access to factory content of the flash.  We might use command line 
for that, though nobody seemed to really like my previous proposal to use 
command line partition info exclusively.

> Anyways, this is best merged together with the mtd patches so:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks for your A-b:.  BTW, patch 06/14 also touches the board file and would 
require your acceptance before being merged via mtd, so could you please have 
a look?

Thanks,
Janusz
