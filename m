From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [Patch v4] OMAP: sDMA driver: descriptor autoloading feature
Date: Mon, 4 Jan 2010 14:18:50 +0530
Message-ID: <618f0c911001040048h573b2137v4577b8e00b0121a3@mail.gmail.com>
References: <618f0c910912110701p771dcf6fg655bb0a7b9bdc96d@mail.gmail.com>
	 <20091228214846.GP3512@atomide.com>
	 <618f0c911001032303p5d103f3et6271a71e1e5fbc96@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C02E97E9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:63772 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab0ADIsv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jan 2010 03:48:51 -0500
Received: by pwj9 with SMTP id 9so9146852pwj.21
        for <linux-omap@vger.kernel.org>; Mon, 04 Jan 2010 00:48:50 -0800 (PST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C02E97E9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Santosh,

On Mon, Jan 4, 2010 at 12:40 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of S,=
 Venkatraman
>> Sent: Monday, January 04, 2010 12:33 PM
>> To: Tony Lindgren
>> Cc: Russell King - ARM Linux; Shilimkar, Santosh; Kevin Hilman; linu=
x-omap@vger.kernel.org; linux-
>> arm-kernel@lists.infradead.org
>> Subject: Re: [Patch v4] OMAP: sDMA driver: descriptor autoloading fe=
ature
>>
>> On Tue, Dec 29, 2009 at 3:18 AM, Tony Lindgren <tony@atomide.com> wr=
ote:
>> > * Venkatraman S <svenkatr@ti.com> [091211 07:01]:
>> >> Here is the most updated version of the patch (thanks to Russell'=
s
>> >> review). This patch is applicable to OMAP4xxx as well as OMAP3630
>> >> Reference to previous posts
>> >> v1 =A0http://marc.info/?l=3Dlinux-omap&m=3D125012097403050&w=3D2
>> >> v2 =A0http://marc.info/?l=3Dlinux-omap&m=3D125137152606644&w=3D2
>> >> v3 =A0http://patchwork.kernel.org/patch/45408/
>> >
>> > Do you have a patch for drivers/mmc/host/omap_hsmmc.c to
>> > use this feature? Or some other driver?
>> >
>> > Regards,
>> >
>> > Tony
>>
>> I am about to start working on omap_hsmmc to use the descriptor load
>> feature. If the DMA changes are acceptable, I can post the driver
>> patch as well.
>
> I don't think doing this for hsmmc makes any sense considering, the I=
C in which DMA descriptor
> is available( OMAP3630 and OMAP4), the HSMMC controller is already eq=
uipped with its dedicated
> DMA controller (ADMA)
>
> Regards,
> Santosh
> --

AFAIK, 3630 does not have ADMA feature.
In OMAP4, ADMA support is available for MMC controllers 1 and 2 only;
the other 3 controllers still use sDMA.

Best regards,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
