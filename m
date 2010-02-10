From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Prevent memory corruption in
 	DRV_ProcFreeDMMRes
Date: Tue, 9 Feb 2010 22:06:26 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA725D82@dlee06.ent.ti.com>
References: <441be695a293805f9de42ad5ce5bf6bca21434fc.1265660264.git.ameya.palande@nokia.com>
	 <94a0d4531002090429n77e65230r4cb426e92384595c@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602AA725BDE@dlee06.ent.ti.com>
 <94a0d4531002091548n18897915kd236f9f7b332c1eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46454 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab0BJEGd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 23:06:33 -0500
In-Reply-To: <94a0d4531002091548n18897915kd236f9f7b332c1eb@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "ext-phil.2.carmody@nokia.com" <ext-phil.2.carmody@nokia.com>


Hi,

>-----Original Message-----
>From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>Sent: Tuesday, February 09, 2010 5:48 PM
>To: Guzman Lugo, Fernando
>Cc: Ameya Palande; linux-omap@vger.kernel.org; Ramirez Luna, Omar; Men=
on,
>Nishanth; Chitriki Rudramuni, Deepak; felipe.contreras@nokia.com; ext-
>phil.2.carmody@nokia.com
>Subject: Re: [PATCH] DSPBRIDGE: Prevent memory corruption in
>DRV_ProcFreeDMMRes
>
>On Tue, Feb 9, 2010 at 10:22 PM, Guzman Lugo, Fernando <x0095840@ti.co=
m>
>wrote:
>> The root problem here is that remove the DMM element should be in
>PROC_UnMap but in PROC_UnReserveMemory, because apart of the problem y=
our
>are seeing about memory corruption if the application does a
>PROC_ReserveMemory and then it finished unexpectedly the resource clea=
nup
>wont be able to unreserved the memory because there is no a DMMres ele=
ment
>in process context struct, the same applies in the case of application
>calls =A0PROC_ReserveMemory, PROC_Map, PROC_UnMap but fails to do the
>PROC_UnReserveMemory.
>
>No, that's a completely different issue, but also valid.
>
>> So the right solution should be:
>>
>> 1 .- Remove DRV_InsertDMMResElement function from PROC_Map and put i=
t on
>PROC_ReserveMemory.
>>
>> 2.- Keep DRV_UpdateDMMResElement function in PROC_Map.
>>
>> 3.- Remove DRV_RemoveDMMResElement function from PROC_UnMap and put =
it on
>ROC_UnReserveMemory function.
>>
>> 4.- Clear dmmAllocated flag in PROC_UnMap:
>>
>> pDMMRes->dmmAllocated =3D 0;
>
>At this point there's an obvious question; what's the point of
>reserving a memory region and not mapping it?
>
>I remember the answer from Hari was: some clients prefer to reserve a
>big region once, and map parts of it continuously. I have my doubts
>that the use-case even works with the current code-base. But assuming
>it does work, your proposed changes would break it.

Resource cleanup does not support that even without my proposed changes=
=2E I just proposed a solution which fixes two issues in one patch. Mor=
eover if this change is merged when the second issue be fixed this patc=
h will not needed anymore, so why don't merge the patch which fixes bot=
h errors at this moment?

Anyway, if you want to include this patch, the only comments we have is=
:

>+			 * PROC_UnMap will free memory allocated to p_cur_res
>+			 * pointer. So we need to save following data for the
>+			 * execution of PROC_UnReserveMemory()
>+			 */
>+			void *h_processor =3D p_cur_res->hProcessor;

You could use hProcessor store in p_ctxt instead of p_cur_res, so that =
you don't need to save hProcessor.

>+			u32 dsp_res_addr =3D p_cur_res->ulDSPResAddr;
>+
>+			status =3D PROC_UnMap(p_cur_res->hProcessor,
>+				 (void *)p_cur_res->ulDSPAddr, p_ctxt);
>
>It would be much easier to merge the two functions into one.

Yes, I am agreed.
>
>Anyway, please re-read Ameya's description carefully.
>
>--
>Felipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
