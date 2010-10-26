From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH 1/1] mtd: OneNAND: fix bufferram management when chip has 2-planes.
Date: Tue, 26 Oct 2010 19:29:38 +0900
Message-ID: <AANLkTikKNNgnzYZ50XcB+TqEGs=RBXUet=L5PsVy+r02@mail.gmail.com>
References: <1287841434-3349-1-git-send-email-eballetbo@gmail.com>
	<1287841434-3349-2-git-send-email-eballetbo@gmail.com>
	<1288085761.2227.40.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56381 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756503Ab0JZK3k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Oct 2010 06:29:40 -0400
Received: by wwe15 with SMTP id 15so4575032wwe.1
        for <linux-omap@vger.kernel.org>; Tue, 26 Oct 2010 03:29:38 -0700 (PDT)
In-Reply-To: <1288085761.2227.40.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem.Bityutskiy@nokia.com
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, dwmw2@infradead.org, adrian.hunter@nokia.com, m.szyprowski@samsung.com

On Tue, Oct 26, 2010 at 6:36 PM, Artem Bityutskiy
<Artem.Bityutskiy@nokia.com> wrote:
> On Sat, 2010-10-23 at 15:43 +0200, Enric Balletbo i Serra wrote:
>> This patch adds code that I think was lost when it was applied the c=
ommit
>> =C2=A0 5988af2319781bc8e0ce418affec4e09cfa77907 - mtd: Flex-OneNAND =
support
>>
>> Test case:
>> =C2=A01. Stress a jffs2 filesystem using
>> =C2=A0 =C2=A0 bonnie++ -u 0:0 -s 32 -m 16 -r 16
>> =C2=A02. dmesg shows various 'Header CRC failed' errors like:
>> =C2=A0 =C2=A0 Header CRC failed on REF_PRISTINE node at 0x1e81315c: =
Read 0x000000e0,
>> =C2=A0 =C2=A0 calculated 0x564fc9e8
>>
>> Tested on IGEP v2 board with a Muxed OneNAND(DDP) 512MB 1.8V 16-bit =
(0x58)
>> with 2 planes from Numonyx and CONFIG_MTD_ONENAND_2X_PROGRAM set to =
y
>>
>> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>
> Kyungmin, would be nice to have your ack/nack.
Sorry for late reply

One more check, it seems to use the invalidate instead of update buffer=
ram.
In case of 2X PROGRAM, it always uses the BUFFERRAM0 so invalidate
another bufferram.

Don't set the bufferram index.

Thank you,
Kyungmin Park
>
> --
> Best Regards,
> Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=
=8E=D1=86=D0=BA=D0=B8=D0=B9)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
