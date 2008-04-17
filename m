From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: [PATCH 3/4] Adding support for OMAP3 Beagle Board
Date: Thu, 17 Apr 2008 20:13:12 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A0018C8CCF@dbde01.ent.ti.com>
References: <7EAD1AEEA7621C45899FE99123E124A0018C8B09@dbde01.ent.ti.com> <48075F66.8020408@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60013 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756139AbYDQOsm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 10:48:42 -0400
Content-class: urn:content-classes:message
In-Reply-To: <48075F66.8020408@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap@vger.kernel.org, discussion@beagleboard.org, Koen Kooi <k.kooi@student.utwente.nl>

Hi Dirk,

> > +}
> > +
> > +static struct omap_board_config_kernel omap3_beagle_config[] __initdata
> = {
> > +	{OMAP_TAG_UART,	&omap3_beagle_uart_config },
> > +};
> > +
> > +static void __init omap3_beagle_init(void)
> > +{
> > +	omap_board_config = omap3_beagle_config;
> > +	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
> > +	omap_serial_init();
> 
> Do you like to add here MMC and USB init like recently proposed by
> Koen Kooi?
>
They are any ways adding new functionality we can bring them in as new patches. Just trying to avoid another round of testing :)
 
> If I understand correctly, these patches currently won't boot on
> BeagleBoard if MMC and USB are missing?
> 
I have tried with Ramdisk. Kernel boots on Beagle with out USB and MMC.

Regards,
Khasim

