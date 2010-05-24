From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Mon, 24 May 2010 22:21:51 +0300
Message-ID: <AANLkTimRQ4mfpHb4ij3tWXDBnkUItPIr06jG7lMmF0p9@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	 <AANLkTin9Fe4qWoxUKlZvQ7RuTRDTka9QmcP_ATe-jgVa@mail.gmail.com>
	 <AANLkTimmvjlsgRmjn7NokL4RnXU8nRA-D2pbCJwJ3axk@mail.gmail.com>
	 <AANLkTiktBVZx5ZFbU49w0IsfuUbdWD5XDsHVgmBpE9Fv@mail.gmail.com>
	 <AANLkTil-R_R66WxbLRjFp7uHBtQ6-FNLgifqyka0NIQh@mail.gmail.com>
	 <AANLkTikamXrz9kwL6OhO2-llzU51WpGSn91UZOnlkBki@mail.gmail.com>
	 <AANLkTimeUwfnmj5pcabFuqGKZ2ExEcf-GPopGDjeV-XB@mail.gmail.com>
	 <AANLkTimAZLGNQsOCqHsk5QbbquIoDIYCtIW2NJqVcoup@mail.gmail.com>
	 <AANLkTim9HXNk-9P_lGtGy32lLQrVl2bfN-qKTY5Qm9xR@mail.gmail.com>
	 <AANLkTimr6_rmx3_wQSc4nnVqZyi2dLu26d6Y8Cd2MMCB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42911 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755733Ab0EXTVy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 15:21:54 -0400
Received: by bwz7 with SMTP id 7so1193085bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 12:21:53 -0700 (PDT)
In-Reply-To: <AANLkTimr6_rmx3_wQSc4nnVqZyi2dLu26d6Y8Cd2MMCB@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Mon, May 24, 2010 at 7:19 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> On Fri, May 21, 2010 at 12:42 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Although I'm still worried that VM_IO !=3D write-combine, but I gues=
s
>> it's a safe assumption to do for now.
>
> small update we missed:
>
> The original code is ignoring VM_IO buffers as well:
>
> static int memory_sync_vma(unsigned long start, u32 len,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 enum dsp_flushtype ftype)
> {
> ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vma->vm_fl=
ags & (VM_IO | VM_PFNMAP))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return -EINVAL;
> ...
> }
>
> So the new code is actually behaving in exactly the same manner
> (besides the error code, which is now -EFAULT and not -EINVAL).

That's what I said in my original comment:
> Reading your patches I see the ioctl to start the dmap operations wou=
ld
> simply error out, but from the looks of it, they would be failing alr=
eady,
> which is weird, because we are already using framebuffer memory for v=
ideo
> decoding + rendering.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
