From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [OMAPZOOM][PATCH 5/5] DSPBRIDGE: Remove unnecessary checks in
 	HW_MBOX_IsFull
Date: Wed, 4 Mar 2009 11:59:04 -0600
Message-ID: <496565EC904933469F292DDA3F1663E60287B853AF@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E60287B84DFA@dlee06.ent.ti.com>
	 <94a0d4530903022322mad6ff40v806c3be7f897939f@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E60287B84F0E@dlee06.ent.ti.com>
 <94a0d4530903031016x7a6750caxa4d2b539e13d84d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45484 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755120AbZCDR7N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 12:59:13 -0500
In-Reply-To: <94a0d4530903031016x7a6750caxa4d2b539e13d84d@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguilar Pena, Leed" <leed.aguilar@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>


This patch has been spitted in two patches I will send them as PATCH 5a=
/5 DSPBRIDGE: cleanup of HW_MBOX_IsFull function and PATCH 5b/5 DSPBRID=
GE: wait less and check the mailbox more.

Regards,
=46ernando
Guzman
Lugo.

-----Original Message-----
=46rom: Felipe Contreras [mailto:felipe.contreras@gmail.com]=20
Sent: Tuesday, March 03, 2009 12:16 PM
To: Guzman Lugo, Fernando
Cc: Pandita, Vikram; Kanigeri, Hari; Aguilar Pena, Leed; linux-omap@vge=
r.kernel.org
Subject: Re: [OMAPZOOM][PATCH 5/5] DSPBRIDGE: Remove unnecessary checks=
 in HW_MBOX_IsFull

On Tue, Mar 3, 2009 at 6:34 PM, Guzman Lugo, Fernando <x0095840@ti.com>=
 wrote:
>
> Hi Felipe,
>
> =A0 =A0 =A0 =A0This patch is base on your patch about increase the pe=
rformance waiting less and checking more the mail box.

Exactly, but that's not what the commit message says.

Besides, you are are doing multiple things in the same patch, which is
the same mistake I did in the original patch that Hiroshi pointed out:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg09875.html

--=20
=46elipe Contreras

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
