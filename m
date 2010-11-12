From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Subject: Re: [PATCHv3 0/4] OMAP: Serial: remove magic and diplicates
Date: Fri, 12 Nov 2010 14:25:24 +0200
Message-ID: <AANLkTi=6qNSOuHxzbLjUAcg=Mn-ucO8KRZreiVQ9PAkM@mail.gmail.com>
References: <1289553702-28041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<AANLkTimd4AruJa2BvqOFw-aP9VpHubsx5Xrwkma+Um5X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43654 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505Ab0KLMZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Nov 2010 07:25:27 -0500
In-Reply-To: <AANLkTimd4AruJa2BvqOFw-aP9VpHubsx5Xrwkma+Um5X@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Nov 12, 2010 at 1:34 PM, Govindraj <govindraj.ti@gmail.com> wro=
te:
> Looks fine to me.
>
> I think you need to CC this patch series to
> arm list and serial list as well.

Govindraj, Do I need to resend the patch including arm and serial MLs?

Regards,
Andrei

>
> Thanks,
> Govindraj.R
>
>
> On Fri, Nov 12, 2010 at 2:51 PM, Emeltchenko Andrei
> <Andrei.Emeltchenko.news@gmail.com> wrote:
>> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>>
>> Add MDR1 Serial register definition to serial_reg and remove duplica=
ted
>> code.
>> *v2 add OMAP keyword to MDR1 definition
>> *v3 remove magic from serial drivers
>>
>> Andrei Emeltchenko (4):
>> =A0OMAP: Serial: Define OMAP uart MDR1 register definitions
>> =A0OMAP1: Serial: remobe magic from MDR1 register
>> =A0OMAP2: Serial: remobe magic from MDR1 register
>> =A0OMAP: Serial: remove redefined MDR1 register definitions
>>
>> =A0arch/arm/mach-omap1/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A06 ++++--
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 15 +++++++++------
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A03 ---
>> =A0drivers/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A06 +++---
>> =A0include/linux/serial_reg.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 12 ++++++++++++
>> =A05 files changed, 28 insertions(+), 14 deletions(-)
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at =A0http://www.tux.org/lkml/
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
