From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Build break on mainline tree for 3430 SDP
Date: Thu, 24 Sep 2009 17:28:05 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDA2D724@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A1C58F1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46946 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050AbZIXL6F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 07:58:05 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8OBw7Zv031988
	for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2009 06:58:08 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n8OBw7a4004122
	for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2009 17:28:07 +0530 (IST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A1C58F1@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Gadiyar, Anand
> Sent: Thursday, September 24, 2009 4:38 PM
> To: linux-omap@vger.kernel.org
> Subject: Build break on mainline tree for 3430 SDP
> 
> Build break compiling Linus' git tree for 3430 SDP.
> 
> I get this with the default SDP config. Haven't looked at the
> code yet to find a fix.
> 
> - Anand
> 
>   CC      arch/arm/mach-omap2/board-3430sdp.o
> In file included from arch/arm/mach-omap2/board-3430sdp.c:41:
> arch/arm/plat-omap/include/mach/keypad.h:38:1: warning: "KEY" 
> redefined
> In file included from include/linux/i2c/twl4030.h:29,
>                  from arch/arm/mach-omap2/board-3430sdp.c:22:
> include/linux/input/matrix_keypad.h:10:1: warning: this is 
> the location of the previous definition
> In file included from arch/arm/mach-omap2/board-3430sdp.c:41:
> arch/arm/plat-omap/include/mach/keypad.h:39:1: warning: 
> "PERSISTENT_KEY" redefined
> In file included from arch/arm/mach-omap2/board-3430sdp.c:22:
> include/linux/i2c/twl4030.h:356:1: warning: this is the 
> location of the previous definition
> arch/arm/mach-omap2/board-3430sdp.c:94: error: unknown field 
> 'keymap' specified in initializer
> arch/arm/mach-omap2/board-3430sdp.c:94: warning: the address 
> of 'sdp3430_keymap' will always evaluate as 'true'
> arch/arm/mach-omap2/board-3430sdp.c:95: error: unknown field 
> 'keymapsize' specified in initializer
> arch/arm/mach-omap2/board-3430sdp.c:95: warning: excess 
> elements in struct initializer
> arch/arm/mach-omap2/board-3430sdp.c:95: warning: (near 
> initialization for 'sdp3430_kp_data')
> make[1]: *** [arch/arm/mach-omap2/board-3430sdp.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2

I had found similar issues on 2.6.30. Had submitted a patch
to remove duplicate definition of KET and PERSISTENT_KEY.

Look for patch title "Remove duplicate definitions" on JUN 16.
(Unfortunately marc.info is not showing patches for last 2 weeks
in June) 
http://markmail.org/search/?q=sanjeev#query:sanjeev%20from%3A%22Sanjeev%20Premi%22%20list%3Aorg.kernel.vger.linux-omap+page:2+mid:t7fonfanbf7736fz+state:results

Best regards,
Sanjeev

> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 