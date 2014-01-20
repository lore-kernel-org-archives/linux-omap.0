From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 0/3] ARM: OMAP: clk-next-omap emergency fixes
Date: Sun, 19 Jan 2014 23:43:54 -0800
Message-ID: <CAPtuhTg8YO6nG8rL8ZFTp78m_AqHnoaZ-LtTTW3_o3QKmRoovA@mail.gmail.com>
References: <1389990340-23358-1-git-send-email-t-kristo@ti.com>
 <20140117213729.4167.55693@quantum> <20140118175020.GF7235@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:56299 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbaATHoP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jan 2014 02:44:15 -0500
Received: by mail-we0-f181.google.com with SMTP id u56so6379002wes.26
        for <linux-omap@vger.kernel.org>; Sun, 19 Jan 2014 23:44:14 -0800 (PST)
In-Reply-To: <20140118175020.GF7235@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Jan 18, 2014 at 9:50 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Mike Turquette <mturquette@linaro.org> [140117 13:39]:
>> Quoting Tero Kristo (2014-01-17 12:25:37)
>> > Hi,
>> >
>> > Quick emergency band-aid for the build breakages introduced in clk-next
>> > by Mike. I didn't have time to test this out (Nishanth will provide some
>> > logs) and I will leave the decision whether/how to use these patches or not
>> > to Tony + Mike.
>> >
>> > I also pushed a test branch based on top of clk-next here:
>> > tree: https://github.com/t-kristo/linux-pm.git
>> > branch: clk-next-omap-fixes
>>
>> Thanks Tero. I force updated the clk tree with the right branch, so
>> these should not be necessary now.
>
> Great, and just for reference if I did not do it yet for these:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

I applied your Ack to entire series (these fixes, clock drivers and
arch/arm changes).

Regards,
Mike
