From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: NAND ECC in linux-omap
Date: Tue, 24 Aug 2010 10:34:07 -0400
Message-ID: <AANLkTinuR_g53r4Q6a3LCmy4LR9ox8j7uCOFVB4OmRz4@mail.gmail.com>
References: <AANLkTimABq72N98Ca6yJ9FgYnyDpod3qRPoTypkDn-4A@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E8188DB@dbde02.ent.ti.com>
	<AANLkTik4+gApkw5fQ561QnJPLX5ED7oN3oU0P6F0+Gsv@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E9299EA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39862 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab0HXOeI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 10:34:08 -0400
Received: by ewy23 with SMTP id 23so3382206ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Aug 2010 07:34:07 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030E9299EA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>

On Tue, Aug 24, 2010 at 9:51 AM, Ghorai, Sukumar <s-ghorai@ti.com> wrot=
e:
>
>
>> -----Original Message-----
>> From: Cliff Brake [mailto:cliff.brake@gmail.com]
>> Sent: Wednesday, August 18, 2010 9:16 PM
>> To: Ghorai, Sukumar
>> Cc: Linux OMAP Users; Kamat, Nishant
>> Subject: Re: NAND ECC in linux-omap
>>
>> On Wed, Aug 18, 2010 at 12:14 AM, Ghorai, Sukumar <s-ghorai@ti.com> =
wrote:
>> > [Ghorai]
>> > 1. Can you send the git tree link and branch you are referring?
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.=
git
>> branch: pm
>> 95e42b92313f229cbc9fc81bf68fe60aaee515aa
>>
>> I'm pretty sure this branch tracks linux-omap. =A0I have not tested
>> linux-omap yet
>> (git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-
>> 2.6.git:master)
>>
>> > 2. I am working to support the NAND BCH and not upstream yet, how =
you
>> apply this patch in PM branch.
>>
>> What do you mean by upstream? =A0I'm not sure what NAND changes are =
in
>> the above pm branch -- that is what I'm trying to figure out :-)
>> Perhaps you can suggest if I'm using BCH, etc.
>>
>> > 3. which x-loader and u-boot you are referring? And no x-loader/ u=
-boot
>> supports the BCH
>>
>> I'm using the x-loader/u-boot from for the Gumstix Overo. =A0My
>> understanding is that it uses software -- likely not BCH, but I'm no=
t
>> sure.
>
> [Ghorai] understand the problem, it's a nand ECC layout (location whe=
re ECC stors) problem,
> I think you flush the JFFS2 flash filesystem from u-boot and kernel n=
ot able to mount it.
> So let boot the image form say from MMC/SD or NFS (1st time); and use=
 the utility after boot (flash_eraseall, nandwrite, ..) to write the JF=
=46S2 image in NAND. And you can check JFFS2 mount or any further test.
>
> If this does not help, send me the nanddump of the any page you write=
 the data from u-boot.

Thanks for the suggestions.  I did write the JFFS2 image with the
following commands:

flash_erasall -j /dev/mtd4

I then mounted the fs with:
mount -t jffs2 /dev/mtdblock4 /media/mtdblock4

and extracted a tar archive into it.  I immediately get some ECC
errors.  If I unmount, and re-mount I get continuous streaming ECC
errors.  As Linux is managing the entire process, it seems there must
be a disconnect somewhere.  Also, note that I disabled HW ECC in
drivers/mtd/nand/omap2.c so that I could get x-load and u-boot to work
with images written with nandwrite as noted previously in this thread.

I then reverted my change that disables hw ECC, and the above
procedure worked fine.  So I guess I need to figure out some way that
I can write images to the u-boot/kernel partitions that is compatible
with my x-loader/u-boot and at the same time keep JFFS2 working.  At
the present, it seems that:

- x-loader/u-boot will only read images written in Linux with hw ECC
disabled in omap2.c
- JFFS2 will only work with hw ECC enabled in omap2.c

Again, thanks for the explanation, and I appreciate any suggestions
going forward.

Thanks,
Cliff

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
http://bec-systems.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
