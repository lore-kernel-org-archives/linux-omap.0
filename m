From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH v8 0/3] GPMC driver conversion
Date: Mon, 10 Sep 2012 10:30:14 +0200
Message-ID: <504DA516.1020405@epfl.ch>
References: <cover.1346846464.git.afzal@ti.com> <20120907221034.GP1303@atomide.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.218]:33478 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751594Ab2IJIaS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 04:30:18 -0400
In-Reply-To: <20120907221034.GP1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Afzal Mohammed <afzal@ti.com>, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

Le 08/09/2012 00:10, Tony Lindgren a =E9crit :
> * Afzal Mohammed <afzal@ti.com> [120905 05:37]:
>> Hi,
>>
>> Basic gpmc driver conversion series. Driver that is now created out =
of
>> gpmc code is a simple one, it handles tasks that were earlier execut=
ed
>> by gpmc_init. Now instead of relying on cpu_is_* checks, it obtains
>> resources and clk handle in the standard Linux way. The existing gpm=
c
>> interface works as was without this series.
>>
>> HWMOD patch also has been brought into this series back with v7 seri=
es
>>
>> As this creates only a basic driver, further gpmc driver work can be
>> based over this, while having a driver first in place.
>>
>> This series is based on l-o/testing-cleanup as on 5-Sep-12,
>> i.e. over commit,
>>
>> e3a5c14 ARM: OMAP1: Move SoC specific headers from plat to mach for =
omap1
>>
>> per Tony's suggestion.
>>
>> It is available
>> @git://gitorious.org/x0148406-public/linux-kernel.git gpmc-drv-v8
> Great, this all looks good to me. I suggest that on top of this
> we add minimal devicetree binding that does not even attempt to
> deal with the timings yet.
>
> Then once the minimal devicetree binding is in place, we can
> call the current GPMC timing functions using the compatible flags
> and auxdata in the gpmc.c driver.
>
> That way we get all the legacy boards booting with GPMC support
> for smsc911x etc, and can even remove some less used board-*.c
> files.

This would be great. If you happen to have DT bindings for GPMC,
I would be happy to test them with my Overo board, as well as
with my CAN chips on a custom board.

Regards,
=46lorian

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
