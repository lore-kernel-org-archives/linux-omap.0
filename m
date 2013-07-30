From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 06/21] ARM: OMAP: overo: use new display drivers
Date: Tue, 30 Jul 2013 12:37:24 +0530
Message-ID: <51F7662C.1060302@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com> <1374822504-28949-7-git-send-email-tomi.valkeinen@ti.com> <51F75B6A.6090900@ti.com> <51F75FA4.1050406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60101 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757646Ab3G3HIo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 03:08:44 -0400
In-Reply-To: <51F75FA4.1050406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 30 July 2013 12:09 PM, Tomi Valkeinen wrote:
> On 30/07/13 09:21, Archit Taneja wrote:
>> Hi,
>>
>> On Friday 26 July 2013 12:38 PM, Tomi Valkeinen wrote:
>>> Use the new display drivers for OMAP3 Overo board.
>>>
>>> The new OMAP display drivers were merged for 3.11, and we can now change
>>> the board files to use the new ones and phase out the old ones.
>>>
>>> Note that the LCD add-on boards for lcd43 and lcd35 use the same GPIOs
>>> for the panels. This means that both panel devices cannot be probed at
>>> the same time.
>>>
>>> DT will handle this correctly, i.e. the DT data will contain the panel
>>> device only for the add-on board that is attached. However, for the
>>> board file we need a hackish solution: We parse the kernel boot command
>>> line, and see whether lcd43 or lcd35 is set as a default display, and
>>> add the given one. Or, if neither is given, default to lcd43.
>>>
>>
>> <snip>
>>
>>>    static struct omap_dss_board_info overo_dss_data = {
>>> -    .num_devices    = ARRAY_SIZE(overo_dss_devices),
>>> -    .devices    = overo_dss_devices,
>>> -    .default_device    = &overo_dvi_device,
>>> +    .default_display_name = "lcd43",
>>>    };
>>
>> The default display previously was the dvi device, if both lcd43 and
>> lcd35 are on add-on boards, then we should probably stick to dvi itself,
>> right? The hack won't work if dvi is the default device though.
>
> DVI is also on an add-on board, but it doesn't conflict with lcd43 or lcd35.
>
> The hack works fine even if DVI is the default device. In that case, it
> doesn't matter if lcd43 or lcd35 is added, because the user doesn't use
> them (as long as only one of them is added, because otherwise there'll
> be an error during probe).
>
> If DVI is the default device, we could actually skip adding both lcd43
> and lcd35. I just wanted to minimize the code in this hack, so I didn't
> do that.

Okay, thanks for the clarification, looks fine then.

Archit

