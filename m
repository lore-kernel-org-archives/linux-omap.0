From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [RFC] Change ECC algorithm from userspace
Date: Fri, 28 Oct 2011 13:10:49 +0200
Message-ID: <CAAwP0s32AJCm_AjxubDSu8ikzhXeRWUqqsPrBmygUHPkRvtv8g@mail.gmail.com>
References: <CAAwP0s059H3BGhYbYLux2gR6ZNb+sFDue676OM2Evz5cA2q6DA@mail.gmail.com>
 <4EAA845B.1020009@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52011 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab1J1LLK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Oct 2011 07:11:10 -0400
Received: by gyb13 with SMTP id 13so3546663gyb.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Oct 2011 04:11:10 -0700 (PDT)
In-Reply-To: <4EAA845B.1020009@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@iseebcn.com>

On Fri, Oct 28, 2011 at 12:30 PM, Matthieu CASTET
<matthieu.castet@parrot.com> wrote:
> Hi,
>
> Javier Martinez Canillas a =C3=A9crit :
>> Hello,
>>
>> I want to be able to use 1-bit ECC for the first partition where I
>> save the loader binary and has to be accessed by the ROM boot but us=
e
>> a 4-bit ECC for my rootfs partition.
>>
>> Does anyone have this same issue?
> We use raw programming and compute the ecc in software.
>
>

Hi Matthieu,

We also thought that solution but it wasn't clear for me if doing a
RAW write to the mtd device I skip the NAND driver and could also
write the oob section without that value being recalculate and rewrite
by the driver.

>>
>> What is the best approach to store data in a NAND device using
>> different ECC techniques?
>>
>> I've think of two approaches:
>>
>> 1- Adding an ioctl to mtdchar (something like ECCSETBITS) to change
>> the ECC technique used.
> But this won't work if there is concurrent acess to mtd. One program =
may want 1
> bit ecc other want 4 bits ecc.
>
>> 2- Use a platform data field to notify the omap2 nand driver that th=
e
>> ROM boot only supports 1-bit ECC. So it can use a 1-bit ECC to write
>> and read the first 4 sectors but a 4-bit ECC for the rest.
> This may be better.
>
> Matthieu
>
> PS : note that some OMAP ROM support a better protection than Hamming=
 (but the
> details are not public AFAIK)
>
> From OMAP34xx Multimedia Device, Silicon Revision 3.1.x, public versi=
on :
>
> Pages can contain errors caused by memory alteration. To correct thes=
e errors,
> the ROM code uses ECC,
> based on Hamming codes for SLC NAND and BCH (Bose, Ray-Chaudhuri, Hoc=
quenghem)
> code for
> multilevel cell (MLC) devices. The computed ECC is compared to ECC st=
ored in the
> spare area of the
> corresponding page. If there are uncorrectable errors, the ROM code r=
eturns with
> FAIL.
>

Yes I've read that on the DM3730 TRM but as far as I understand only
applies to MLC devices, but ours is SLC.

Thank you and best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
