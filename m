From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: Passing mem=1G to kernel on Panda, system is unstable.
Date: Fri, 14 Jan 2011 18:14:44 +0800
Message-ID: <AANLkTinU5b5e1PegdxzRaNL6J4q_FKKa04V51=ecdqru@mail.gmail.com>
References: <AANLkTin+ZjUoD9i+JxV7wW2+U6oEp42PdP5R4gdtzy=F@mail.gmail.com>
 <641ab84b6cedfd62b9b6bedeae077f1b@mail.gmail.com> <842cdfd0907812989c0dfda45a25c5d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36146 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393Ab1ANKPH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 05:15:07 -0500
Received: by qyj19 with SMTP id 19so6637773qyj.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 02:15:06 -0800 (PST)
In-Reply-To: <842cdfd0907812989c0dfda45a25c5d3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, "Jan, Sebastien" <s-jan@ti.com>
Cc: linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

On Fri, Jan 14, 2011 at 4:56 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
>> Sent: Friday, January 14, 2011 1:43 PM
>> To: Bryan Wu; linux-omap@vger.kernel.org; Ricardo Salveti de Araujo
>> Subject: RE: Passing mem=3D1G to kernel on Panda, system is unstable=
=2E
>>
>> Bryan,
>> > -----Original Message-----
>> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> > owner@vger.kernel.org] On Behalf Of Bryan Wu
>> > Sent: Tuesday, January 11, 2011 10:22 PM
>> > To: linux-omap@vger.kernel.org; Ricardo Salveti de Araujo
>> > Subject: Passing mem=3D1G to kernel on Panda, system is unstable.
>> >
>> > Hi folks,
>> >
>> > We are trying to build kernel package or GCC natively on OMAP4
>> panda
>> > board. With the mainline 2.6.37 kernel or Ubuntu Natty 2.6.35
>> based
>> > kernel, we met same instabilities on the system when we try to use
>> > mem=3D1G on the board.
>> >
>> > Please find our bug tracker here:
>> > https://bugs.launchpad.net/ubuntu/+source/linux-ti-
>> omap4/+bug/633227
>> > and I think another bug is also related:
>> > https://bugs.launchpad.net/ubuntu/+source/linux-ti-
>> > omap4/+bug/690370.
>> > System will freeze at all when building GCC natively on Panda.
>> >
>> > Did any folks meet this issue? or we need more simple test case to
>> > catch the root cause of this issue.
>> >
>> Haven't seen this issue on my SDP with 2.6.37.
>> Have you enabled HIGHMEM, when tried mem =3D 1G on 2.6.37 ?
>
> This patch may not be relevant but last week while scanning
> errata's I came across one which is applicable to OMAP4 ES2.x
>
> Am attaching it. Please give a try. Have boot tested with latest
> mainline tree.
>

No problem. I will try it later. Here is 4:15am, I'll try to sleep for =
a while.

Thanks,
--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
