From: =?UTF-8?B?UGV0ZXIgS8O8bW1lbA==?= <syntheticpp@gmx.net>
Subject: Re: 3.18.1->3.19-rc2: In-band Error seen by MPU
Date: Fri, 02 Jan 2015 19:31:36 +0100
Message-ID: <54A6E408.1090908@gmx.net>
References: <54A58E23.5080103@gmx.net> <20150101182053.GG582@fuloong-minipc.musicnaut.iki.fi> <20150102161911.GA3298@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:56169 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745AbbABSbn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Jan 2015 13:31:43 -0500
In-Reply-To: <20150102161911.GA3298@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org



Am 02.01.2015 um 17:19 schrieb Tony Lindgren:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [150101 10:23]:
>> Hi,
>>
>> On Thu, Jan 01, 2015 at 07:12:51PM +0100, Peter K=C3=BCmmel wrote:
>>> When updating (custom DM3730 board) from 3.18.1 ro 3.19-rc2
>>> I see a "In-band ERROR" warning which wasn't present in 3.18.1.
>>> Could it be that I missed some DT updates?
>>
>>> [    0.366882] In-band Error seen by MPU  at address 0
>>> [    0.366912] ------------[ cut here ]------------
>>> [    0.366943] WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_smx.c:=
166 omap3_l3_app_irq+0x100/0x134()
>>
>> This appears also on N900/N950/N9...
>
> Do you have CONFIG_PREEMPT enabled? It seems there's some
> regression related to CONFIG_PREEMPT that started happening
> with the merge window?

Indeed, when I disable CONFIG_PREEMPT the warning is gone.

Thanks,
Peter

>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
