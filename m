From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v5 0/5] omap: mailbox: hwmod support
Date: Thu, 10 Feb 2011 13:12:52 -0800
Message-ID: <8739nvioff.fsf@ti.com>
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
	<AANLkTimah86Mj37rCMYnuprUfeP1XwmxcNBD9S=8g6_N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:41039 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755660Ab1BJVM7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 16:12:59 -0500
Received: by mail-px0-f172.google.com with SMTP id 6so372285pxi.31
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 13:12:59 -0800 (PST)
In-Reply-To: <AANLkTimah86Mj37rCMYnuprUfeP1XwmxcNBD9S=8g6_N@mail.gmail.com>
	(Sourav Poddar's message of "Thu, 10 Feb 2011 11:04:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, lo <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, lak <linux-arm-kernel@lists.infradead.org>

"Poddar, Sourav" <sourav.poddar@ti.com> writes:

> On Thu, Feb 3, 2011 at 12:57 AM, Omar Ramirez Luna <omar.ramirez@ti.c=
om> wrote:
>> Mailbox hwmod support for OMAP 2,3,4.
>>
>> This was tested on OMAP3 (3430, 3630), minor testing
>> was made on OMAP4.
>>
>> No testing on OMAP2 since I don't have the hardware.
>>
>> Highlights from v5 include the comments received from
>> previous version v4[1].
>>
>> Benoit Cousson (1):
>> =C2=A0OMAP4: hwmod data: add mailbox data
>>
>> Felipe Contreras (2):
>> =C2=A0OMAP3: hwmod data: add mailbox data
>> =C2=A0OMAP: mailbox: build device using omap_device/omap_hwmod
>>
>> Omar Ramirez Luna (1):
>> =C2=A0OMAP: mailbox: use runtime pm for clk and sysc handling
>>
>> omar ramirez (1):
>> =C2=A0OMAP2: hwmod data: add mailbox data
>>
>> =C2=A0arch/arm/mach-omap2/devices.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 98 +++++-----------------------
>> =C2=A0arch/arm/mach-omap2/mailbox.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 67 ++-----------------
>> =C2=A0arch/arm/mach-omap2/omap_hwmod_2420_data.c | =C2=A0 74 +++++++=
++++++++++++++
>> =C2=A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =C2=A0 73 +++++++=
++++++++++++++
>> =C2=A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =C2=A0 72 +++++++=
+++++++++++++
>> =C2=A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =C2=A0 67 +++++++=
++++++++++++
>> =C2=A06 files changed, 308 insertions(+), 143 deletions(-)
>
> Boot tested mainline v2.6.38-rc4 along with this 5 patch series on
> Omap 2420,2430 SDPs.
>
> Tested-by: Sourav Poddar<sourav.poddar@ti.com>

Boot testing is a start, but I'm pretty sure that bootup does not use
the mailbox on any of these platforms.  This needs to be tested with
something that actually uses the mailbox.

Kevin




--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
