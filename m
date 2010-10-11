From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] omap: dsp: fix ioremap() usage
Date: Mon, 11 Oct 2010 22:05:38 +0300
Message-ID: <AANLkTinMhMJhTYoG7TRPUtb8DkTc8hCyH+GWEfKFD80d@mail.gmail.com>
References: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com>
	<1286732440-28644-3-git-send-email-felipe.contreras@gmail.com>
	<496565EC904933469F292DDA3F1663E602F47B2BCD@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45405 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab0JKTFk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 15:05:40 -0400
Received: by bwz15 with SMTP id 15so1901759bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 11 Oct 2010 12:05:39 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602F47B2BCD@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>

On Mon, Oct 11, 2010 at 6:15 PM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
>> +#if defined(CONFIG_TIDSPBRIDGE) || defined(CONFIG_TIDSPBRIDGE_MODUL=
E)
>> +
>> +static phys_addr_t omap_dsp_mempool_base;
>> +
>> +static void __init omap_dsp_reserve_mem(struct meminfo *mi) {
>> + =C2=A0 =C2=A0 phys_addr_t size =3D CONFIG_TIDSPBRIDGE_MEMPOOL_SIZE=
;
>> + =C2=A0 =C2=A0 phys_addr_t addr =3D ~0;
>> + =C2=A0 =C2=A0 int i;
>> +
>> + =C2=A0 =C2=A0 if (!size)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> +
>> + =C2=A0 =C2=A0 for (i =3D mi->nr_banks - 1; i >=3D 0; i--)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mi->bank[i].size >=3D=
 size) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mi->bank[i].size -=3D size;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 addr =3D mi->bank[i].start + mi->bank[i].size;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 break;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> Missing {} in "for" lopp. Even tough you are checking for success ins=
ide
> For loop why check again outside? And also not need to define addr.
> What do you think about this:

It comes directly from Russell's code:
http://article.gmane.org/gmane.linux.kernel/1046606

But I do prefer to add the braces. Your proposed patch is ok, although
I prefer to have the important code at the end of the function, and
the error check before that.

Anyway, Russell has come with a different approach, so I have to try
that instead.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
