From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [RFC] Change ECC algorithm from userspace
Date: Fri, 28 Oct 2011 14:00:30 +0200
Message-ID: <CAAwP0s0EG1cNZbDYwPe6ezD+r+1nQVJ4gd8+hCFjtyEAPVJLvA@mail.gmail.com>
References: <CAAwP0s059H3BGhYbYLux2gR6ZNb+sFDue676OM2Evz5cA2q6DA@mail.gmail.com>
 <4EAA845B.1020009@parrot.com> <CAAwP0s32AJCm_AjxubDSu8ikzhXeRWUqqsPrBmygUHPkRvtv8g@mail.gmail.com>
 <4EAA973F.8060104@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47664 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576Ab1J1MAv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Oct 2011 08:00:51 -0400
Received: by ywm3 with SMTP id 3so3585895ywm.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Oct 2011 05:00:51 -0700 (PDT)
In-Reply-To: <4EAA973F.8060104@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@iseebcn.com>

On Fri, Oct 28, 2011 at 1:51 PM, Matthieu CASTET
<matthieu.castet@parrot.com> wrote:
> Javier Martinez Canillas a =C3=A9crit :
>> On Fri, Oct 28, 2011 at 12:30 PM, Matthieu CASTET
>> <matthieu.castet@parrot.com> wrote:
>>> PS : note that some OMAP ROM support a better protection than Hammi=
ng (but the
>>> details are not public AFAIK)
>>>
>>> From OMAP34xx Multimedia Device, Silicon Revision 3.1.x, public ver=
sion :
>>>
>>> Pages can contain errors caused by memory alteration. To correct th=
ese errors,
>>> the ROM code uses ECC,
>>> based on Hamming codes for SLC NAND and BCH (Bose, Ray-Chaudhuri, H=
ocquenghem)
>>> code for
>>> multilevel cell (MLC) devices. The computed ECC is compared to ECC =
stored in the
>>> spare area of the
>>> corresponding page. If there are uncorrectable errors, the ROM code=
 returns with
>>> FAIL.
>>>
>>
>> Yes I've read that on the DM3730 TRM but as far as I understand only
>> applies to MLC devices, but ours is SLC.
>>
> It also works on SLC devices. We are using it on micron slc that need=
 4 bits ECC.
>

That is a great thing to know, I didn't get that from the
documentation (DM3730 TRM).

And this ECC scheme that is supported for SLC devices it is also BCH?
Or the ROM boot uses a different algorithm to calculate the codes to
be stored on the oob?

Thank and best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
