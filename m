From: Nishanth Menon <nm@ti.com>
Subject: Re: OMAP 4430 SDP: rather sick with recent kernels
Date: Wed, 17 Dec 2014 11:33:03 -0600
Message-ID: <CAGo_u6oS_xyboNZcUsQ8LFrhFhkR6yvr8r_XBj3-yTmqZnqYGA@mail.gmail.com>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk>
	<20141217172333.GE23854@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:52648 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbaLQRdF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Dec 2014 12:33:05 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so15343226ier.41
        for <linux-omap@vger.kernel.org>; Wed, 17 Dec 2014 09:33:04 -0800 (PST)
In-Reply-To: <20141217172333.GE23854@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Joel Fernandes <joelf@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>

On Wed, Dec 17, 2014 at 11:23 AM, Tony Lindgren <tony@atomide.com> wrote:
>
>> twl: not initialized
>> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
>> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
>> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
>> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
>> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
>> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
>> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1410000 Vs max 1316660
>
> This seems to be some twl related init order issue, I'll take a
> look at this one.
>
>> omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu
>> omap2_set_init_voltage: unable to set vdd_mpu
>> omap2_set_init_voltage: unable to find boot up OPP for vdd_core
>> omap2_set_init_voltage: unable to set vdd_core
>> omap2_set_init_voltage: unable to find boot up OPP for vdd_iva
>> omap2_set_init_voltage: unable to set vdd_iva
>
> I believe Nishanth has some plans for these?


Not in the near future. looks like converting VC/VP into regulator and
fit inside DT world has gone no where..

Regards,
Nishanth Menon

-- 
---
Regards,
Nishanth Menon
