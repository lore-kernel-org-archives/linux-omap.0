From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Mon, 24 May 2010 22:49:20 +0300
Message-ID: <AANLkTil4oTPcGC7XRY_HyY0pJ6C_huKTHQcZGH9-fjfZ@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	<AANLkTimmvjlsgRmjn7NokL4RnXU8nRA-D2pbCJwJ3axk@mail.gmail.com>
	<AANLkTiktBVZx5ZFbU49w0IsfuUbdWD5XDsHVgmBpE9Fv@mail.gmail.com>
	<AANLkTil-R_R66WxbLRjFp7uHBtQ6-FNLgifqyka0NIQh@mail.gmail.com>
	<AANLkTikamXrz9kwL6OhO2-llzU51WpGSn91UZOnlkBki@mail.gmail.com>
	<AANLkTimeUwfnmj5pcabFuqGKZ2ExEcf-GPopGDjeV-XB@mail.gmail.com>
	<AANLkTimAZLGNQsOCqHsk5QbbquIoDIYCtIW2NJqVcoup@mail.gmail.com>
	<AANLkTim9HXNk-9P_lGtGy32lLQrVl2bfN-qKTY5Qm9xR@mail.gmail.com>
	<AANLkTimr6_rmx3_wQSc4nnVqZyi2dLu26d6Y8Cd2MMCB@mail.gmail.com>
	<AANLkTimRQ4mfpHb4ij3tWXDBnkUItPIr06jG7lMmF0p9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62882 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173Ab0EXTtl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 15:49:41 -0400
Received: by gwaa20 with SMTP id a20so1654522gwa.19
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 12:49:40 -0700 (PDT)
In-Reply-To: <AANLkTimRQ4mfpHb4ij3tWXDBnkUItPIr06jG7lMmF0p9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Mon, May 24, 2010 at 10:21 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, May 24, 2010 at 7:19 PM, Ohad Ben-Cohen <ohad@wizery.com> wro=
te:
>> On Fri, May 21, 2010 at 12:42 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> Although I'm still worried that VM_IO !=3D write-combine, but I gue=
ss
>>> it's a safe assumption to do for now.
>>
>> small update we missed:
>>
>> The original code is ignoring VM_IO buffers as well:
>>
>> static int memory_sync_vma(unsigned long start, u32 len,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum dsp_flushty=
pe ftype)
>> {
>> ...
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (vma->vm_flags & (VM_IO | VM_PFNMA=
P))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> ...
>> }
>>
>> So the new code is actually behaving in exactly the same manner
>> (besides the error code, which is now -EFAULT and not -EINVAL).
>
> That's what I said in my original comment:

Oh I missed that one, and thought you meant this is rather a new behavi=
or.

One thing I can think of to make this dspbridge VM_IO assumption
stronger is this:

diff --git a/drivers/dsp/bridge/core/tiomap3430.c
b/drivers/dsp/bridge/core/tiomap3430.c
index e122f04..7030012 100644
--- a/drivers/dsp/bridge/core/tiomap3430.c
+++ b/drivers/dsp/bridge/core/tiomap3430.c
@@ -1326,7 +1326,7 @@ static dsp_status bridge_brd_mem_map(struct
bridge_dev_context *hDevContext,
                goto func_cont;
        }

-       if (vma->vm_flags & VM_IO) {
+       if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
                num_usr_pgs =3D ul_num_bytes / PG_SIZE4K;
                mpu_addr =3D ul_mpu_addr;

This is exactly what __get_user_pages is checking for as well, and it
applies to our framebuffer use case.

Anyway I wonder if we have such dspbridge scenarios in which vm_flags
& VM_IO is true, but vm_flags & VM_PFNMAP is false.

Obviously this all issue has nothing to do with the current mem/cache
API patches.

Thanks,
Ohad.

>> Reading your patches I see the ioctl to start the dmap operations wo=
uld
>> simply error out, but from the looks of it, they would be failing al=
ready,
>> which is weird, because we are already using framebuffer memory for =
video
>> decoding + rendering.
>
> --
> Felipe Contreras
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
