From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v8 REPOST 21/24] gpio/omap: save and restore debounce registers
Date: Mon, 7 Nov 2011 16:41:37 +0530
Message-ID: <CAC83ZvK=8DiiBeHHK+yKkn4UwRkdkd58m+F52L9NjJUqRW9wcw@mail.gmail.com>
References: <1318422730-22282-1-git-send-email-tarun.kanti@ti.com>
	<87zkgbbzaq.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:49897 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753001Ab1KGLLj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Nov 2011 06:11:39 -0500
Received: by mail-qy0-f178.google.com with SMTP id 14so3440123qyg.9
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 03:11:38 -0800 (PST)
In-Reply-To: <87zkgbbzaq.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org

On Fri, Nov 4, 2011 at 10:27 PM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Nishanth Menon <nm@ti.com>
>>
>> GPIO debounce registers need to be saved and restored for proper fun=
ctioning
>> of driver.
>
> OK.
>
>> To save the registers, we cannot cut the clock before the save,
>> hence move the clk disable after the save.
>
> This patch doesn't move any clk disable.
>
> I suspect you made some changes to the original patch from Nishanth.
> Please note that in the changelog. =A0This is typically done by addin=
g
> something like:
>
> [my@email.addr: describe changes made]
>
> just before your signoff.
Yes, quite a bit of changes happened which not captured in the descript=
ion.
The save context has been moved from *_runtime_suspend() to _set_gpio_d=
ebounce()
as part of your comment in v6 to reduce overhead.
Also, the clock disable is moved to *_prepare_for_idle().
I will add changelog to capture above changes.
--
Tarun
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
