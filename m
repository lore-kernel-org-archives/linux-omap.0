From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [4.8.0-rc1] am335x-evm boot failure: n_tty_receive_buf_common:
 "Unable to handle kernel paging request.."
Date: Sat, 10 Sep 2016 00:23:16 +0200
Message-ID: <CAALWOA_=9fMG156H_XSZBjeckQUK-moDWoRE6_kr-8=Z_-KZuA@mail.gmail.com>
References: <87ceb885-94a6-b9b3-60b3-2017198c4338@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87ceb885-94a6-b9b3-60b3-2017198c4338@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Peter Hurley <peter@hurleysoftware.com>, Lokesh Vutla <lokeshvutla@ti.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

If you look more carefully the first problem is actually a bus error:
[ 15.776190] Unhandled fault: external abort on non-linefetch (0x1028)
at 0xf9e3e044
[ 15.825925] PC is at omap_hwmod_read+0x14/0x28
[ 15.830583] LR is at omap_rtc_wait_not_busy+0x1c/0x44

I have no idea how the kernel manages to continue after a bus error in
a driver (inside local_irq_disable even), but I wouldn't be inclined
to take any later errors seriously.

See also the "4.8 crash on BeagleBone" thread on linux-omap.

Matthijs
