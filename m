From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: multiple linux-next OMAP3 build errors
Date: Mon, 4 Oct 2010 16:34:06 +0530
Message-ID: <AANLkTi=-xu5D6g+15AHtwWrUBjFfqEATkU+e=NXa8gAF@mail.gmail.com>
References: <AANLkTim9v1Y2o9QebYcJkh+QLVQq9fFOFE5P+OoyUHXa@mail.gmail.com> <1286173747.2358.4.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:60644 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755063Ab0JDLE2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Oct 2010 07:04:28 -0400
Received: by mail-ww0-f51.google.com with SMTP id 28so5095556wwb.20
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 04:04:26 -0700 (PDT)
In-Reply-To: <1286173747.2358.4.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: benh@kernel.crashing.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, ext Grazvydas Ignotas <notasas@gmail.com>

On Mon, Oct 4, 2010 at 11:59 AM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> On Fri, 2010-10-01 at 17:57 +0200, ext Grazvydas Ignotas wrote:
>> hi,
>>
>> I've been building linux-next for a while now and keep getting these
>> build errors, just posting them here in case not all are known. Not
>> familiar enough with that code to send patches unfortunately.
>
>> =A0 CC =A0 =A0 =A0drivers/video/omap2/vram.o
>> drivers/video/omap2/vram.c: In function 'omap_vram_reserve_sdram_mem=
block':
>> drivers/video/omap2/vram.c:568: error: implicit declaration of
>> function 'memblock_region_is_memory'
>
> Benjamin, your patch "memblock/arm: Use memblock_region_is_memory() f=
or
> omap fb" in linux-next seems to be broken. I believe the called funct=
ion
> should be memblock_is_region_memory, not memblock_region_is_memory?
>

I've posted this patch [1] for this. Could one of you please pick up,
or fold into
the original patch if it hasn't yet reached mainline?

- Anand

[1] https://patchwork.kernel.org/patch/224902/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
