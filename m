From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [Patch v4] OMAP: sDMA driver: descriptor autoloading feature
Date: Wed, 6 Jan 2010 20:15:07 +0530
Message-ID: <618f0c911001060645g4580a83je653fcdb3d0f2e7@mail.gmail.com>
References: <618f0c910912110701p771dcf6fg655bb0a7b9bdc96d@mail.gmail.com>
	 <20091228214846.GP3512@atomide.com>
	 <618f0c911001032303p5d103f3et6271a71e1e5fbc96@mail.gmail.com>
	 <4B448D11.5060400@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:52460 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206Ab0AFOpI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 09:45:08 -0500
Received: by pxi4 with SMTP id 4so394723pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 06:45:07 -0800 (PST)
In-Reply-To: <4B448D11.5060400@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Lavinen Jarkko (Nokia-M/Helsinki)" <jarkko.lavinen@nokia.com>

On Wed, Jan 6, 2010 at 6:46 PM, Adrian Hunter <adrian.hunter@nokia.com>=
 wrote:
> Venkatraman S wrote:
>>
>> On Tue, Dec 29, 2009 at 3:18 AM, Tony Lindgren <tony@atomide.com> wr=
ote:
>>>
>>> * Venkatraman S <svenkatr@ti.com> [091211 07:01]:
>>>>
>>>> Here is the most updated version of the patch (thanks to Russell's
>>>> review). This patch is applicable to OMAP4xxx as well as OMAP3630
>>>> Reference to previous posts
>>>> v1 =A0http://marc.info/?l=3Dlinux-omap&m=3D125012097403050&w=3D2
>>>> v2 =A0http://marc.info/?l=3Dlinux-omap&m=3D125137152606644&w=3D2
>>>> v3 =A0http://patchwork.kernel.org/patch/45408/
>>>
>>> Do you have a patch for drivers/mmc/host/omap_hsmmc.c to
>>> use this feature? Or some other driver?
>>>
>>> Regards,
>>>
>>> Tony
>>
>> I am about to start working on omap_hsmmc to use the descriptor load
>> feature. If the DMA changes are acceptable, I can post the driver
>> patch as well.
>
> I presume this is about performance. =A0How does it compare to chaine=
d DMA?
> We have a patch for omap_hsmmc for chained DMA that we are still test=
ing.
>
 The main difference would be the number of logical channels used.
With chaining, I assume you'd request for (or the API internally
reserves) as many logical channels as there are segments. Here a
single logical channel would do.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
