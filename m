From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Issue : jffs2 and ecc layout
Date: Fri, 24 Dec 2010 22:10:33 +0800
Message-ID: <AANLkTikNP4HU3cHHQXjSBCXqxz0ES1AhCZpt3ZqKu9KT@mail.gmail.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B03560990E3@dbde02.ent.ti.com>
	<AANLkTimJFsjLT15FA+TqDKzjvPXgxUAvovWpWKP3NCK4@mail.gmail.com>
	<201012241602.36582.manningc2@actrix.gen.nz>
	<AANLkTi=DfzP5mkwJ3zWePSp+gthWV-OT1_kBVFtkpNWU@mail.gmail.com>
	<AANLkTi=YM2ONPfA9g4tFDQcJwfstGi_FLsrXTEcyby7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44506 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab0LXOKf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Dec 2010 09:10:35 -0500
Received: by wwa36 with SMTP id 36so7404717wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Dec 2010 06:10:34 -0800 (PST)
In-Reply-To: <AANLkTi=YM2ONPfA9g4tFDQcJwfstGi_FLsrXTEcyby7b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Liu <r64343@freescale.com>, David.Woodhouse@intel.com
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Charles Manning <manningc2@actrix.gen.nz>

Hi Jason,

2010/12/24 Ming Lei <tom.leiming@gmail.com>:
> 2010/12/24 Ming Lei <tom.leiming@gmail.com>:
>> Hi,
>>
>> 2010/12/24 Charles Manning <manningc2@actrix.gen.nz>:
>>
>>> THis might be due to the way the omap2.c driver is now screwed up s=
o that it
>>> does not read when not u32 aligned.
>>>
>>> Try this:
>>> http://www.spinics.net/linux/lists/linux-omap/msg42422.html
>>>
>>> Please report back if that fixes the problem for you.
>>
>> No, the patch doesn't fix the issue.
>
> #mount -t jffs2 /dev/mtdblock4 /mnt/cf
>
> mount: /dev/mtdblock4: can't read superblock
>
> [ =A0 41.216796] nand_do_read_oob: Attempt to read past end of page
> [ =A0 41.216827] cannot read OOB for EB at 00000000, requested 152
> bytes, read 0 bytes, error -22

When I revert the patch below from Jason,

       http://marc.info/?l=3Dlinux-kernel&m=3D129015697513966&w=3D2

mount will be OK but with some info printed, see below:

root@beagleboard:~# mount -t jffs2 /dev/mtdblock4 /mnt/cf
[   39.662963] JFFS2 notice: (1324) jffs2_build_xattr_subsystem:
complete building xattr subsystem, 0
of xdatum (0 unchecked, 0 orphan) and 0 of xref (0 dead, 0 orphan) foun=
d.

#mount
=2E.....
/dev/mtdblock4 on /media/cf type jffs2 (rw,relatime)

So seems the patch from Jason does cause the issue, maybe should be
dropped or fixed further.

thanks,
--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
