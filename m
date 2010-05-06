From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PM][PATCH v3 2/4] OMAP3: Serial: Errata i202: fix for MDR1
	access
Date: Thu, 6 May 2010 16:29:45 +0530
Message-ID: <m2pd6a0f7aa1005060359o6727fa78w174efe8f3d4f7a24@mail.gmail.com>
References: <1271097933-22981-1-git-send-email-nm@ti.com>
	 <87d3x9ykdf.fsf@deeprootsystems.com>
	 <FCCFB4CDC6E5564B9182F639FC3560870304F5B1AE@dbde02.ent.ti.com>
	 <u2id6a0f7aa1005060254v17bb0018seb3ddb90e6221e4a@mail.gmail.com>
	 <4BE29D8B.2070403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f189.google.com ([209.85.221.189]:59459 "EHLO
	mail-qy0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488Ab0EFK7r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 May 2010 06:59:47 -0400
Received: by qyk27 with SMTP id 27so12119338qyk.23
        for <linux-omap@vger.kernel.org>; Thu, 06 May 2010 03:59:46 -0700 (PDT)
In-Reply-To: <4BE29D8B.2070403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Kattungal, Deepak" <deepak.k@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, "Raja, Govindraj" <govindraj.raja@ti.com>, Tero Kristo <tero.kristo@nokia.com>

On Thu, May 6, 2010 at 4:14 PM, Nishanth Menon <nm@ti.com> wrote:
> Govindraj had written, on 05/06/2010 04:54 AM, the following:
>>
>> On Thu, May 6, 2010 at 5:49 AM, Kattungal, Deepak <deepak.k@ti.com> =
wrote:
>>>
>>> Hi Kevin,
>>>
>>> My Comments as below.
>>>
>>> Regards
>>> Deepak
>>>
>>> -----Original Message-----
>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>> Sent: Wednesday, May 05, 2010 6:55 PM
>>> To: Menon, Nishanth
>>> Cc: linux-omap; Kattungal, Deepak; Raja, Govindraj; Tero Kristo
>>> Subject: Re: [PM][PATCH v3 2/4] OMAP3: Serial: Errata i202: fix for=
 MDR1
>>> access
>>>
>>> Nishanth Menon <nm@ti.com> writes:
>>>
>>>> From: Deepak K <deepak.k@ti.com>
>>>>
>>>> Original patch:
>>>>
>>>> http://git.omapzoom.org/?p=3Dkernel/omap.git;a=3Dcommitdiff;h=3D42=
d4a342c009bd9727c100abc8a4bc3063c22f0c
>>>>
>>>> Errata i202 (OMAP3430 - 1.12, OMAP3630 - 1.6):
>>>
>>> This workaround is currently done for all OMAPs.
>>>
>>> Presumably, this errata will eventually be fixed. =A0So, as with ot=
her
>>> errata fixes, we need some sort of SoC-rev based flag and the errat=
a
>>> workaround done based on that flag.
>>>
>>> Deepak : This would be a good fix, thanks for the suggestion.
>>>
>>> Also, shouldn't there be a fix for this in the 8250 and omap-serial
>>> drivers too?
>>>
>>>
>>> Deepak : The 8250 is not using the MDR Register. This would be need=
ed
>>> only by the omap-serial. The 8250 being a general driver we may not=
 require
>>> the access to MDR1 register. Hence the fix not required for 8250.
>>>
>>
>> Why do you say this fix is not necessary for 8250?
>
> drivers/serial/8250.c does not use mdr register. it does not make sen=
se for
> a generic driver like this to have OMAP specific register access.
>
>>
>> Isn't the omap_uart_reset configuring uart for 16x mode?
>>
>> Context save and restore is an common for whether it is 8250 or
>> omap-serial.c
>
> ack.
>
>>
>> The only difference here wrt to MDR and 8250 is
>> -> MDR though not accesed by 8250 currently serial.c sets it to uart=
16x
>> mode.
>
>>
>> In omap-serial.c we configure MDR based on baudrate as we have an ua=
rt13x
>> mode
>> which is ignored in 8250 and thus 8250 may not support 13x baud's
>> correctly
>> which is taken care in omap-serial.
>
> given that MDR register deals with mostly IRDA settings, i am curious=
 to see
> how omap-serial hits on a shared register here :).

MDR is not for only IrDA,

MDR ---> Mode Definition register

There are two MDR register:

MDR1 [2:0]

MODE_SELECT: UART-IrDA-CIR mode selection

MDR2 ---> IR-IrDA and IR-CIR modes only


>
>>
>> I think this patch is fine and only concern is to make it applicable
>> to appropriate socs as kevin said.
>
> Sure. trivial to do. Could you comment on the proposal i posted earli=
er?

As said in previous mail I have no issue with the function added.
Except if taken care to handle the comment from kevin.


--=20
---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
