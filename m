From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Mainline OMAP3 breakage (and other OMAP?)
Date: Fri, 3 Dec 2010 14:10:23 +0200
Message-ID: <AANLkTim3573_MUZNpo2+tKa=ZJgQf26x5of_ZkMM6BR8@mail.gmail.com>
References: <20101202211421.GG10461@n2100.arm.linux.org.uk>
	<20101202215837.GW17222@atomide.com>
	<20101202221612.GJ10461@n2100.arm.linux.org.uk>
	<20101202223208.GA17222@atomide.com>
	<20101203030954.GD3367@linux-sh.org>
	<20101203084102.GA30957@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:32841 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355Ab0LCMK1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 07:10:27 -0500
In-Reply-To: <20101203084102.GA30957@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Mundt <lethal@linux-sh.org>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Dec 3, 2010 at 10:41 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Dec 03, 2010 at 12:09:55PM +0900, Paul Mundt wrote:
>> This has been fixed since -rc2.
>
> So it is. =C2=A0However, the ioremap fix is wrong.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0paddr =3D memb=
lock_alloc(size, PAGE_SIZE);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0memblock_free(paddr, size);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0memblock_remove(paddr, size);
>
> Didn't I say that such blocks were supposed to be aligned to a 2MB
> boundary - and the size also so aligned?

I asked you if there was something special and I didn't receive any res=
ponse:
http://article.gmane.org/gmane.linux.kernel/1048434

So, why SZ_2M?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
