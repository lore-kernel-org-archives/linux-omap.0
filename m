From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [RFC] Change ECC algorithm from userspace
Date: Fri, 28 Oct 2011 13:51:27 +0200
Message-ID: <4EAA973F.8060104@parrot.com>
References: <CAAwP0s059H3BGhYbYLux2gR6ZNb+sFDue676OM2Evz5cA2q6DA@mail.gmail.com> <4EAA845B.1020009@parrot.com> <CAAwP0s32AJCm_AjxubDSu8ikzhXeRWUqqsPrBmygUHPkRvtv8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:59406 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755370Ab1J1Lvw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Oct 2011 07:51:52 -0400
In-Reply-To: <CAAwP0s32AJCm_AjxubDSu8ikzhXeRWUqqsPrBmygUHPkRvtv8g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@iseebcn.com>

Javier Martinez Canillas a =C3=A9crit :
> On Fri, Oct 28, 2011 at 12:30 PM, Matthieu CASTET
> <matthieu.castet@parrot.com> wrote:
>> PS : note that some OMAP ROM support a better protection than Hammin=
g (but the
>> details are not public AFAIK)
>>
>> From OMAP34xx Multimedia Device, Silicon Revision 3.1.x, public vers=
ion :
>>
>> Pages can contain errors caused by memory alteration. To correct the=
se errors,
>> the ROM code uses ECC,
>> based on Hamming codes for SLC NAND and BCH (Bose, Ray-Chaudhuri, Ho=
cquenghem)
>> code for
>> multilevel cell (MLC) devices. The computed ECC is compared to ECC s=
tored in the
>> spare area of the
>> corresponding page. If there are uncorrectable errors, the ROM code =
returns with
>> FAIL.
>>
>
> Yes I've read that on the DM3730 TRM but as far as I understand only
> applies to MLC devices, but ours is SLC.
>
It also works on SLC devices. We are using it on micron slc that need 4=
 bits ECC.


Matthieu
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
