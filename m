From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: DSP MMU Fault
Date: Thu, 4 Jun 2009 09:48:36 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2F13B302@dlee03.ent.ti.com>
References: <44449.139.179.13.76.1244116436.squirrel@newmail.bilkent.edu.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57683 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753904AbZFDOtW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 10:49:22 -0400
In-Reply-To: <44449.139.179.13.76.1244116436.squirrel@newmail.bilkent.edu.tr>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Can Bal <canbal@ee.bilkent.edu.tr>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Can,

> Do you have any ideas why this might be happening and how to fix it?
> Thanks a lot.

Most probably you might not have mapped the address 0x230674a0.


Thank you,
Best regards,
Hari

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Can Bal
> Sent: Thursday, June 04, 2009 6:54 AM
> To: linux-omap@vger.kernel.org
> Subject: DSP MMU Fault
> 
> Hi everyone,
> 
> I'm implementing a code on DSP but at the time I do a memory allocation at
> the DSP side as:
> 
> short *a;
> a = malloc(192); // (short*)malloc(192) does not work either
> 
> But at this line I get the following error and DSP fails afterwards. Then
> I need to reboot until I can run the application again.
> 
> <6>***** DSPMMU FAULT ***** IRQStatus 0x2
> ***** DSPMMU FAULT ***** IRQStatus 0x2
> <6>***** DSPMMU FAULT ***** faultAddr 0x230674a0
> ***** DSPMMU FAULT ***** faultAddr 0x230674a0
> <6>WMD_DEH_Notify: ********** DEVICE EXCEPTION **********
> WMD_DEH_Notify: ********** DEVICE EXCEPTION **********
> <6>WMD_DEH_Notify: DSP_MMUFAULT,errInfo = 0x0
> WMD_DEH_Notify: DSP_MMUFAULT,errInfo = 0x0
> <6>WMD_DEH_Notify: DSP_MMUFAULT, High Address = 0x2306
> WMD_DEH_Notify: DSP_MMUFAULT, High Address = 0x2306
> <6>WMD_DEH_Notify: DSP_MMUFAULT, Low Address = 0x74a0
> WMD_DEH_Notify: DSP_MMUFAULT, Low Address = 0x74a0
> <6>WMD_DEH_Notify: DSP_MMUFAULT, fault address = 0x230674a0
> WMD_DEH_Notify: DSP_MMUFAULT, fault address = 0x230674a0
> 
> Do you have any ideas why this might be happening and how to fix it?
> Thanks a lot.
> 
> Can
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

