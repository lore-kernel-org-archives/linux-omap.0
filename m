From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PM][PATCH v3 2/4] OMAP3: Serial: Errata i202: fix for MDR1
	access
Date: Thu, 6 May 2010 15:24:43 +0530
Message-ID: <u2id6a0f7aa1005060254v17bb0018seb3ddb90e6221e4a@mail.gmail.com>
References: <1271097933-22981-1-git-send-email-nm@ti.com>
	 <87d3x9ykdf.fsf@deeprootsystems.com>
	 <FCCFB4CDC6E5564B9182F639FC3560870304F5B1AE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f189.google.com ([209.85.221.189]:51072 "EHLO
	mail-qy0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757397Ab0EFJyo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 May 2010 05:54:44 -0400
Received: by qyk27 with SMTP id 27so12037073qyk.23
        for <linux-omap@vger.kernel.org>; Thu, 06 May 2010 02:54:43 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870304F5B1AE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kattungal, Deepak" <deepak.k@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Raja, Govindraj" <govindraj.raja@ti.com>, Tero Kristo <tero.kristo@nokia.com>

On Thu, May 6, 2010 at 5:49 AM, Kattungal, Deepak <deepak.k@ti.com> wro=
te:
> Hi Kevin,
>
> My Comments as below.
>
> Regards
> Deepak
>
> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Wednesday, May 05, 2010 6:55 PM
> To: Menon, Nishanth
> Cc: linux-omap; Kattungal, Deepak; Raja, Govindraj; Tero Kristo
> Subject: Re: [PM][PATCH v3 2/4] OMAP3: Serial: Errata i202: fix for M=
DR1 access
>
> Nishanth Menon <nm@ti.com> writes:
>
>> From: Deepak K <deepak.k@ti.com>
>>
>> Original patch:
>> http://git.omapzoom.org/?p=3Dkernel/omap.git;a=3Dcommitdiff;h=3D42d4=
a342c009bd9727c100abc8a4bc3063c22f0c
>>
>> Errata i202 (OMAP3430 - 1.12, OMAP3630 - 1.6):
>
> This workaround is currently done for all OMAPs.
>
> Presumably, this errata will eventually be fixed. =A0So, as with othe=
r
> errata fixes, we need some sort of SoC-rev based flag and the errata
> workaround done based on that flag.
>
> Deepak : This would be a good fix, thanks for the suggestion.
>
> Also, shouldn't there be a fix for this in the 8250 and omap-serial
> drivers too?
>
>
> Deepak : The 8250 is not using the MDR Register. This would be needed=
 only by the omap-serial. The 8250 being a general driver we may not re=
quire the access to MDR1 register. Hence the fix not required for 8250.
>

Why do you say this fix is not necessary for 8250?

Isn't the omap_uart_reset configuring uart for 16x mode?

Context save and restore is an common for whether it is 8250 or omap-se=
rial.c

The only difference here wrt to MDR and 8250 is
-> MDR though not accesed by 8250 currently serial.c sets it to uart16x=
 mode.

In omap-serial.c we configure MDR based on baudrate as we have an uart1=
3x mode
which is ignored in 8250 and thus 8250 may not support 13x baud's corre=
ctly
which is taken care in omap-serial.

I think this patch is fine and only concern is to make it applicable
to appropriate socs as kevin said.

---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
