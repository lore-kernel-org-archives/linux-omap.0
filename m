From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: Passing mem=1G to kernel on Panda, system is unstable.
Date: Fri, 14 Jan 2011 18:12:59 +0800
Message-ID: <AANLkTi=EaxW9D_rtNuk3CT1K-CoTBXiy5qOW=EL9ay1d@mail.gmail.com>
References: <AANLkTin+ZjUoD9i+JxV7wW2+U6oEp42PdP5R4gdtzy=F@mail.gmail.com> <641ab84b6cedfd62b9b6bedeae077f1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57532 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757153Ab1ANKNU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 05:13:20 -0500
Received: by qyk12 with SMTP id 12so3181061qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 02:13:20 -0800 (PST)
In-Reply-To: <641ab84b6cedfd62b9b6bedeae077f1b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, "Jan, Sebastien" <s-jan@ti.com>
Cc: linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

On Fri, Jan 14, 2011 at 4:12 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Bryan,
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Bryan Wu
>> Sent: Tuesday, January 11, 2011 10:22 PM
>> To: linux-omap@vger.kernel.org; Ricardo Salveti de Araujo
>> Subject: Passing mem=3D1G to kernel on Panda, system is unstable.
>>
>> Hi folks,
>>
>> We are trying to build kernel package or GCC natively on OMAP4 panda
>> board. With the mainline 2.6.37 kernel or Ubuntu Natty 2.6.35 based
>> kernel, we met same instabilities on the system when we try to use
>> mem=3D1G on the board.
>>
>> Please find our bug tracker here:
>> https://bugs.launchpad.net/ubuntu/+source/linux-ti-omap4/+bug/633227
>> and I think another bug is also related:
>> https://bugs.launchpad.net/ubuntu/+source/linux-ti-
>> omap4/+bug/690370.
>> System will freeze at all when building GCC natively on Panda.
>>
>> Did any folks meet this issue? or we need more simple test case to
>> catch the root cause of this issue.
>>
> Haven't seen this issue on my SDP with 2.6.37.
Do you have Panda for testing? I don't have SDP. Maybe Sebastien can
help to verify on SDP.

> Have you enabled HIGHMEM, when tried mem =3D 1G on 2.6.37 ?
>

Yeah, CONFIG_HIGHMEM=3Dy for this mainline testing. Please use this
kernel config file:
http://launchpadlibrarian.net/62061659/mainline_config

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
