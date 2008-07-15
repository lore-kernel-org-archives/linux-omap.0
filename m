From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 00/11] OMAP3 CPUidle patches
Date: Tue, 15 Jul 2008 18:50:27 +0530
Message-ID: <032001c8e67d$8cf11750$68bf18ac@ent.ti.com>
References: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:53511 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755555AbYGONUf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jul 2008 09:20:35 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m6FDKSqF023910
	for <linux-omap@vger.kernel.org>; Tue, 15 Jul 2008 08:20:34 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m6FDKQgA003799
	for <linux-omap@vger.kernel.org>; Tue, 15 Jul 2008 18:50:27 +0530 (IST)
In-Reply-To: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Did some idle measurements with these.. 

VDD1 : 2.0 mA
VDD2 : 2.3 mA

The numbers are on the higher side as the thresholds are still not optimal. 
Currently C6 has a threshold set to 300 ms which seems to be very low.
We are working on deriving the optimal thresholds for each C state. 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Rajendra Nayak
> Sent: Tuesday, July 01, 2008 7:46 PM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH 00/11] OMAP3 CPUidle patches
> 
> Hi,
> 
> The following patches define and enable all of the below 
> mentioned C states for OMAP3. 
> These are tested with a minimal kernel config on OMAP3430sdp 
> as most drivers today don't have context save/restore in place and
> some even lack aggresive clock handling. 
> These apply on top of the workaround patch set submitted by Jouni. 
> ([PATCH 0/6] 34XX: PM: Workarounds to get omap3 to retention 4th.)
> 
> The following is neccessay even with a minimal config to achieve OFF.
>  $ echo 1 > /sys/power/sleep_while_idle
>  $ echo 1 > /sys/power/clocks_off_while_idle
>   
> The following C states are defined
> C0 - System executing code
> C1 - MPU WFI + Core active
> C2 - MPU CSWR + Core active
> C3 - MPU OFF + Core active
> C4 - MPU CSWR + Core CSWR
> C5 - MPU OFF + Core CSWR
> C6 - MPU OFF + Core OFF
>  
> regards,
> Rajendra
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

