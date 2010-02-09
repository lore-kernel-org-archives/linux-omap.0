From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Prevent memory corruption in
 	DRV_ProcFreeDMMRes
Date: Tue, 9 Feb 2010 14:22:40 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA725BDE@dlee06.ent.ti.com>
References: <441be695a293805f9de42ad5ce5bf6bca21434fc.1265660264.git.ameya.palande@nokia.com>
 <94a0d4531002090429n77e65230r4cb426e92384595c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55366 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834Ab0BIUWt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 15:22:49 -0500
In-Reply-To: <94a0d4531002090429n77e65230r4cb426e92384595c@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "ext-phil.2.carmody@nokia.com" <ext-phil.2.carmody@nokia.com>


Hi,

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Felipe Contreras
>Sent: Tuesday, February 09, 2010 6:30 AM
>To: Ameya Palande
>Cc: linux-omap@vger.kernel.org; Ramirez Luna, Omar; Menon, Nishanth;
>Chitriki Rudramuni, Deepak; felipe.contreras@nokia.com; ext-
>phil.2.carmody@nokia.com
>Subject: Re: [PATCH] DSPBRIDGE: Prevent memory corruption in
>DRV_ProcFreeDMMRes
>
>On Mon, Feb 8, 2010 at 10:25 PM, Ameya Palande <ameya.palande@nokia.com>
>wrote:
>> Background: bridge_close() has the responsibility to cleanup all the
>> resources allocated by user space process. One of those resources is
>> DMMRes which is used for tracking DMM resource allocation done in
>> PROC_Map() and PROC_UnMap().
>>
>> DRV_ProcFreeDMMRes() function was used for cleaning up DMMRes has
>following
>> problems which are fixed by this patch:
>>
>> 1. It access and modifies pDMMRes pointer when it is already freed by
>> PROC_UnMap()
>> 2. Instead of passing ulDSPAddr it passes ulDSPResAddr to PROC_UnMap()
>which
>> will not retrive correct DMMRes element.
>
>This patch is doing the right thing to me, however, it's a bit
>difficult to review because it's doing many changes at once.
>
>Personally I would
> 1) Fix the wrong dereferences in DRV_ProcFreeDMMRes
>[at this point the bug should be fixed]
>[the leaks would be freed by the outer loop]
>
> 2) Fix the wrong PROC_UnMap address passed in DRV_ProcFreeDMMRes
> 3) Remove the unnecessary outer loop in DRV_RemoveAllDMMResElements
>[at this point the code would actually make sense]
>
> 4) Merge DRV_ProcFreeDMMRes into DRV_RemoveAllDMMResElements
> 5) Improve coding style
>
>The end result would be the same, but easier to see what's going on :)
>
>Cheers.
>
>--
>Felipe Contreras

The root problem here is that remove the DMM element should be in PROC_UnMap but in PROC_UnReserveMemory, because apart of the problem your are seeing about memory corruption if the application does a PROC_ReserveMemory and then it finished unexpectedly the resource cleanup wont be able to unreserved the memory because there is no a DMMres element in process context struct, the same applies in the case of application calls  PROC_ReserveMemory, PROC_Map, PROC_UnMap but fails to do the PROC_UnReserveMemory.


So the right solution should be:

1 .- Remove DRV_InsertDMMResElement function from PROC_Map and put it on PROC_ReserveMemory.

2.- Keep DRV_UpdateDMMResElement function in PROC_Map.

3.- Remove DRV_RemoveDMMResElement function from PROC_UnMap and put it on ROC_UnReserveMemory function.

4.- Clear dmmAllocated flag in PROC_UnMap:

pDMMRes->dmmAllocated = 0;

5 .- in the function DRV_ProcFreeDMMRes, call PROC_UnMap "if (pDMMRes->dmmAllocated)" and always call PROC_UnReserveMemory not in this point is not needed the save hProcessor nor ulDSPResAddr addresses.

6 .- cleanup DRV_RemoveAllDMMResElements function (while loop is not needed).

Regards,
Fernando.


>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
