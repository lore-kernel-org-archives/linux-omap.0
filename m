From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: Passing mem=1G to kernel on Panda, system is unstable.
Date: Sat, 15 Jan 2011 02:41:18 +0800
Message-ID: <AANLkTime0otkEhqwFBS4k_aYiU7a8hnbhYQsfE=GBHdr@mail.gmail.com>
References: <AANLkTin+ZjUoD9i+JxV7wW2+U6oEp42PdP5R4gdtzy=F@mail.gmail.com>
 <alpine.DEB.2.00.1101121649560.5731@utopia.booyaka.com> <AANLkTi=X-yUNvSkn-qNrAGSUoy_sNy9FzkeCzFECsBZF@mail.gmail.com>
 <alpine.DEB.2.00.1101132240220.28621@utopia.booyaka.com> <AANLkTimoSGkQV8suHD0-KFBq1wZc-VkzZ8ziZ81QaL9V@mail.gmail.com>
 <AANLkTimmnUq19qmBgAetA-+pkrCxwwfwA-kaBtAOqVeu@mail.gmail.com>
 <36befcf1947882da51ace32cbfb0b922@mail.gmail.com> <AANLkTim2dv+cKDsDgPMQFWgEcN_p1Q1_R6HFh3=v44Xk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56088 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab1ANSlj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 13:41:39 -0500
Received: by qwa26 with SMTP id 26so3016648qwa.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 10:41:38 -0800 (PST)
In-Reply-To: <AANLkTim2dv+cKDsDgPMQFWgEcN_p1Q1_R6HFh3=v44Xk@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Jan, Sebastien" <s-jan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

On Sat, Jan 15, 2011 at 1:48 AM, Jan, Sebastien <s-jan@ti.com> wrote:
> Hi Santosh,
>
> On Fri, Jan 14, 2011 at 6:22 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>>>
>>> I just tested with the 2.6.37 mainline kernel and Bryan config, and
>>> can reproduce the issue with CONFIG_SMP disabled.
>> Can you try the patch I sent on the list as well ?
>

Unfortunately, I still can reproduce this issue with mainline 2.6.37
kernel + the patch here:
---
[ 3391.102539] Unhandled fault: imprecise external abort (0x1406) at 0x4278f000
/home/ubuntu/ubuntu-natty/drivers/media/dvb/dvb-usb/a800.c:197:1:
internal compiler error: Bus error
Please submit a full bug report,
with preprocessed source if appropriate.
See <file:///usr/share/doc/gcc-4.5/README.Bugs> for instructions.
---

-Bryan

> Bryan is currently testing your patch. I have a build running with
> HIGHMEM deactivated.
>
> I'll also make a try on blaze board. I do not expect any difference
> here. Note that the only way to trigger this issue for me was to make
> native compilation of a big component (like native kernel
> compilation).
>
