From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH] OMAP4460: Hwmod: Add hwmod for thermal sensor
Date: Thu, 21 Jul 2011 20:56:53 +0530
Message-ID: <CAJ6a13brXSxeK82wg86x9gS4=UMAXJaXnR9hPwLzGJrBvh9AOg@mail.gmail.com>
References: <1309877932-27202-1-git-send-email-vishwanath.bs@ti.com>
	<alpine.DEB.2.00.1107070328150.30028@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:36649 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752002Ab1GUP0y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 11:26:54 -0400
Received: by mail-iy0-f181.google.com with SMTP id 40so1103738iyf.12
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 08:26:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1107070328150.30028@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: Vishwanath BS <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

On Thu, Jul 7, 2011 at 2:59 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Tue, 5 Jul 2011, Vishwanath BS wrote:
>
>> From: Keerthy <j-keerthy@ti.com>
>>
>> Patch adds hwmod entry for 4460 thermal sensor module. Thermal senso=
r module
>> is part of Control module sharing its address space and clocked via =
Bandgap
>> Functional Clock. Adding a seperate hwmod entry for thermal sensor w=
ill
>> enable thermal sensor driver to manage its clock cleanly using PM ru=
ntime
>> interfaces.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Signed-off-by: Vishwnath BS <vishwanath.bs@ti.com>
>
> This needs to be coordinated with Beno=EEt, since he's the maintainer=
 of
> this file. =A0Since he's away at the moment, this is probably 3.2 mat=
erial.
>

Hello Paul/Tony,

This hwmod is specific to OMAP4460. When i tried to compile i see that
CHIP_IS_OMAP446X is missing. Since this is very much specific to
OMAP4460 is there another way to differentiate between OMAP4430 and
OMAP4460?

>
> - Paul



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
