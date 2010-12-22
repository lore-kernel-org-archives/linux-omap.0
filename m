From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: Huge ubi or ubifs sync slowdown since 2.6.32
Date: Wed, 22 Dec 2010 16:43:12 +0200
Message-ID: <1293028992.12773.18.camel@localhost>
References: <201012211136.22254.manningc2@actrix.gen.nz>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f45.google.com ([209.85.214.45]:50082 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab0LVOo1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 09:44:27 -0500
Received: by bwz16 with SMTP id 16so5785319bwz.4
        for <linux-omap@vger.kernel.org>; Wed, 22 Dec 2010 06:43:56 -0800 (PST)
In-Reply-To: <201012211136.22254.manningc2@actrix.gen.nz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charles Manning <manningc2@actrix.gen.nz>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, 2010-12-21 at 11:36 +1300, Charles Manning wrote:
> Hi All
>=20
> I've been looking into a ubifs performance regression on linux-omap 2=
=2E6.37.
>=20
> My test is pretty simple, copy a 2Mbyte file and sync.
>=20
> # sync; date; cp 2Mbyte-file foo; sync; date
>=20
> On 2.6.32 and earler, the time between the two dates was around 3 sec=
onds.
> On linux-omap master it is around 14 seconds. Ouch!
>=20
> At first I thought the problem was due to changes in the OMAP nand dr=
ivers,=20
> but raw randwrite speed is actually a bit faster. This suggest the fi=
nger=20
> should be pointed at ubi or ubifs.
>=20
> I then thought that perhaps the layout of my ubinized image might be =
a=20
> contributing factor so I erased the partition, ubiformatted and ubimk=
voled.=20
> The problem persisted,
>=20
> Any suggestions as to what might be broken or how to debug this deepe=
r?

Can you try this on nandsim and see if there are still differences? You
can make nandsim slower by injecting an udelay somewhere. Try this on
your x86 host - this way you'll narrow this down to an OMAP-specific or
platform-independent problem.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
