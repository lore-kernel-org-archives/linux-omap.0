From: Ameya Palande <2ameya@gmail.com>
Subject: Re: [PATCH 1/4] [OMAPZOOM] [UPDATE] DSPBRIDGE: Memory lock for DMM.
Date: Tue, 7 Apr 2009 23:49:13 +0300
Message-ID: <269694c00904071349w141e1b7cjae10e70f8ac994af@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E60287FB05ED@dlee06.ent.ti.com>
	 <269694c00904071319i1ba7f00cie08d9ecf9ffe2ce2@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E23781F34@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:50469 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761077AbZDGUtP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 16:49:15 -0400
Received: by bwz17 with SMTP id 17so2487713bwz.37
        for <linux-omap@vger.kernel.org>; Tue, 07 Apr 2009 13:49:13 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E23781F34@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Hari,

On Tue, Apr 7, 2009 at 11:27 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wr=
ote:
> Ameya,
>
>> If this is the case then what is the point of having following code?
>> if (page_count(pg) < 1) =C2=A0<-- This will always evaluate to FALSE=
=2E
>
> -- As you mentioned this case shouldn't be hit. This check is to only=
 to ensure that the >translations from user space VA to Physical addres=
s is taking place correctly and flag the >user if something went bad.

get_page() function has following check inside it:
VM_BUG_ON(atomic_read(&page->_count) =3D=3D 0);

Why we need to repeat it again?
I guess we can completely remove following check which is in my
opinion completely
redundant:

if (page_count(pg) < 1) {
}

Cheers,
Ameya.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
