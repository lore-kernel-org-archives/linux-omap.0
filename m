From: "Venkatesh, Subbu" <subbu.wrs@ti.com>
Subject: DSS2: Compilation Error on Git tree
  http://www.bat.org/~tomba/git/linux-omap-dss.git
Date: Wed, 3 Jun 2009 09:07:15 -0500
Message-ID: <5F744A5A3C131242B81CE5874BD2CFFB34E35EBA@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42208 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754100AbZFCOHY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2009 10:07:24 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "Shah, Hardik" <hardik.shah@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mande, Nikhil" <nikhil@ti.com>, "Castaneda Gonzalez, Axel" <x0055901@ti.com>, "Miesen, Sharon" <s-miesen@ti.com>

Hi Tomi,
I did git pull to update my tree, later compiling code for LDP, I am getting compilation error as show below. I see that I am missing declaration of  
 struct omap_dss_display_config in display.h file, could you please comment on it...

arch/arm/mach-omap2/board-ldp.c:368: warning: 'struct omap_display' declared inside parameter list
arch/arm/mach-omap2/board-ldp.c:368: warning: its scope is only this definition or declaration, which is probably not what you want
arch/arm/mach-omap2/board-ldp.c:383: warning: 'struct omap_display' declared inside parameter list
arch/arm/mach-omap2/board-ldp.c:393: error: variable 'omap_ldp_display_data_tv' has initializer but incomplete type
arch/arm/mach-omap2/board-ldp.c:394: error: unknown field 'type' specified in initializer
arch/arm/mach-omap2/board-ldp.c:394: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-ldp.c:394: warning: (near initialization for 'omap_ldp_display_data_tv')
arch/arm/mach-omap2/board-ldp.c:395: error: unknown field 'name' specified in initializer
arch/arm/mach-omap2/board-ldp.c:395: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-ldp.c:395: warning: (near initialization for 'omap_ldp_display_data_tv')
arch/arm/mach-omap2/board-ldp.c:396: error: unknown field 'u' specified in initializer
arch/arm/mach-omap2/board-ldp.c:396: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-ldp.c:396: warning: (near initialization for 'omap_ldp_display_data_tv')
arch/arm/mach-omap2/board-ldp.c:397: error: unknown field 'panel_enable' specified in initializer
arch/arm/mach-omap2/board-ldp.c:397: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-ldp.c:397: warning: (near initialization for 'omap_ldp_display_data_tv')
arch/arm/mach-omap2/board-ldp.c:398: error: unknown field 'panel_disable' specified in initializer
arch/arm/mach-omap2/board-ldp.c:398: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-ldp.c:398: warning: (near initialization for 'omap_ldp_display_data_tv')
arch/arm/mach-omap2/board-ldp.c:401: warning: 'struct omap_display' declared inside parameter list
arch/arm/mach-omap2/board-ldp.c:425: warning: 'struct omap_display' declared inside parameter list
arch/arm/mach-omap2/board-ldp.c:435: error: variable 'omap_ldp_display_data_lcd' has initializer but incomplete type
arch/arm/mach-omap2/board-ldp.c:436: error: unknown field 'type' specified in initializer
arch/arm/mach-omap2/board-ldp.c:436: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-ldp.c:436: warning: (near initialization for 'omap_ldp_display_data_lcd')
arch/arm/mach-omap2/board-ldp.c:437: error: unknown field 'name' specified in initializer
arch/arm/mach-omap2/board-ldp.c:437: warning: excess elements in struct initializer
arch/arm/mach-omap2/board-ldp.c:437: warning: (near initialization for 'omap_ldp_display_data_lcd')

Regards,
Subbu