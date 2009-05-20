From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH v3 1/3] OMAP3:zoom2: Add support for OMAP3 Zoom2 board
Date: Wed, 20 May 2009 05:40:01 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F50968B4@dbde02.ent.ti.com>
References: <1242422451-21551-1-git-send-email-mlc@ti.com>
 <1242422451-21551-2-git-send-email-mlc@ti.com>
 <20090518212216.GR19742@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F50963E1@dbde02.ent.ti.com>
 <20090518213902.GS19742@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F5096447@dbde02.ent.ti.com>
 <20090519162940.GX19742@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F50968B0@dbde02.ent.ti.com>
 <20090519235520.GO19742@atomide.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F50968B2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51026 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754183AbZETAKM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 20:10:12 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F50968B2@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Christensen, Mikkel" <mlc@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>Pandita, Vikram
>Sent: Tuesday, May 19, 2009 7:01 PM
>To: Tony Lindgren
>Cc: Christensen, Mikkel; linux-omap@vger.kernel.org
>Subject: RE: [PATCH v3 1/3] OMAP3:zoom2: Add support for OMAP3 Zoom2 board
>
>
>
<snip>
>>
>>Well you still cannot have it as a late_initcall(), you should just call the
>>function from board-zoom2.c. Otherwise it will run for all the boards.

Way not execute the debug board function for other boards could be to put it under 
#ifdef CONFIG_MACH_OMAP_ZOOM2 

static int __init omap_zoom2_debugboard_init(void)
{
#ifdef CONFIG_MACH_OMAP_ZOOM2
        if (!omap_zoom2_debugboard_detect())
                return 0;

        zoom2_init_smsc911x();
        zoom2_init_quaduart();
        return platform_add_devices(zoom2_devices, ARRAY_SIZE(zoom2_devices));
#endif
}
late_initcall(omap_zoom2_debugboard_init);


The registration order of the UARTS with 8250 driver is all the reason we have to do this _initcall()


>
>The problem is that serial.c: platform_device_register() for UART1/2/3 happens as arch_init().
>
>We want that Quard/Dbg-board Uart console to appear as UART4(ttyS3) and so the
>platform_device_register() has to happen after the arch_init() call from serial.c
>
>If we put the dbg-board init in .init_machine   = omap_zoom2_init() function, then this gets called
>first before the serial.c:arch_init() and assigns ttyS0(UART0) to the debug board uart.
>
>This is not what we want to do.
>
>
>>
>>Regards,
>>
>>Tony
>>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

