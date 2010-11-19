From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: No more software ECC in omap2.c NAND driver. Why?
Date: Fri, 19 Nov 2010 12:35:53 +0200
Message-ID: <AANLkTi=XLc==mqGcBck5P+xutxAOENX1o9Bz8qPN=fC_@mail.gmail.com>
References: <201011181406.15212.manningc2@actrix.gen.nz>
	<2A3DCF3DA181AD40BDE86A3150B27B6B036977BBA2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:65175 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab0KSKfy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 05:35:54 -0500
Received: by qyk35 with SMTP id 35so15738qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 02:35:53 -0800 (PST)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B036977BBA2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: Charles Manning <manningc2@actrix.gen.nz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Nov 18, 2010 at 4:33 PM, Ghorai, Sukumar <s-ghorai@ti.com> wrot=
e:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Charles Manning
>> Sent: Thursday, November 18, 2010 6:36 AM
>> To: linux-omap@vger.kernel.org
>> Subject: No more software ECC in omap2.c NAND driver. Why?
>>
>> Between 2.6.35 and 2.6.36 there have need quite a few changes in the=
 NAND
>> driver, including a change from software to hardware ECC.
>>
>> The new code has hardware ECC forced on by:
>>
>> #define CONFIG_MTD_NAND_OMAP_HWECC
>>
>> I am surprised that this was done. Surely this should have been a Kc=
onfig
>> option to select either sw ECC or hw ECC?
>>
>> Does moving to hardware ECC to the exclusion of software ECC reduce
>> functionality?
>
> [Ghorai] This is wrongly added by me, during last few patches. So I h=
ave
> send the fix as you mentioned too as.
> [PATCH] omap: nand: remove hardware ECC as default
>
> And please let me know still if it has any issue.

=46or me it makes normal sw ECC page IO work, but for subpages to work =
I
have to disable the prefetch option.

> And I am re-working on the patches for the different ecc schema inclu=
ding
> s/w, h/w or different, to pass it form board file.
>
>>
>> Does the new hwecc scheme still support sub-page writes or does it o=
nly
>> provide full page writes? If sub-page writes are lost then this has =
=A0a
>> ripple
>> effect in breaking the way some UBI stuff works.
>
> [Ghorai]
> 1. do you think this sub-page read/write support was there before, sa=
y in
> 2.6.35? And breaks in 2.6.36?

It certainly was there for sw ECC as we've been using UBI from 2.6.27
to 2.6.35 just fine.

> 2. In that case would you please let know what are the size(s) used f=
or
> sub-page/read write?

512 bytes.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
