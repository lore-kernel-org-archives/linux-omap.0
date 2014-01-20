From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: AM335x USB DMA seems broken on ISOC URBs
Date: Mon, 20 Jan 2014 20:26:16 -0300
Message-ID: <20140120232615.GA25258@localhost>
References: <20131222055945.GA7194@localhost>
 <20140117162723.GB3843@localhost>
 <52DA99D8.8010003@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:38396 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752775AbaATX0D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jan 2014 18:26:03 -0500
Content-Disposition: inline
In-Reply-To: <52DA99D8.8010003@zonque.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Felipe Balbi <balbi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Hi Daniel,

On Sat, Jan 18, 2014 at 04:12:24PM +0100, Daniel Mack wrote:
> On 01/17/2014 05:27 PM, Ezequiel Garcia wrote:
> > On Sun, Dec 22, 2013 at 02:59:45AM -0300, Ezequiel Garcia wrote:
[..]
>=20
> Did you try this with a different type of peripheral hardware, a USB
> audio device for example?
>=20
[..]

=46inally I found some time to setup the board and do some new tests us=
ing
an UVC webcam (which might behave better given it should transfer
smaller buffers).

The result is not encouraging! Device is detected regularly, but then I=
 get
some ugly messages on the first command:

# yavta /dev/video0 -l
[   21.279722] BUG: spinlock cpu recursion on CPU#0, kworker/0:2/46
[   21.286041]  lock: 0xdf01e010, .magic: dead4ead, .owner: yavta/78, .=
owner_cpu: 0
[   21.293800] CPU: 0 PID: 46 Comm: kworker/0:2 Not tainted 3.13.0-rc8-=
next-20140120-dirty #69
[   21.302571] Workqueue: events musb_host_finish_resume
[   21.307899] [<c000faa1>] (unwind_backtrace) from [<c000e8db>] (show_=
stack+0xb/0xc)
[   21.315844] [<c000e8db>] (show_stack) from [<c003f981>] (do_raw_spin=
_lock+0xc5/0xe8)
[   21.323969] [<c003f981>] (do_raw_spin_lock) from [<c030c949>] (_raw_=
spin_lock_irqsave+0xd/0x10)
[   21.333094] [<c030c949>] (_raw_spin_lock_irqsave) from [<c021927b>] =
(musb_host_finish_resume+0xf/0x60)
[   21.342860] [<c021927b>] (musb_host_finish_resume) from [<c0031709>]=
 (process_one_work+0xad/0x224)
[   21.352258] [<c0031709>] (process_one_work) from [<c0031b19>] (worke=
r_thread+0xc9/0x270)
[   21.360750] [<c0031b19>] (worker_thread) from [<c00355c7>] (kthread+=
0x7b/0x94)
[   21.368325] [<c00355c7>] (kthread) from [<c000cb7d>] (ret_from_fork+=
0x11/0x34)
[   27.352780] BUG: spinlock lockup suspected on CPU#0, kworker/0:2/46
[   27.359350]  lock: 0xdf01e010, .magic: dead4ead, .owner: yavta/78, .=
owner_cpu: 0
[   27.367104] CPU: 0 PID: 46 Comm: kworker/0:2 Not tainted 3.13.0-rc8-=
next-20140120-dirty #69
[   27.375860] Workqueue: events musb_host_finish_resume
[   27.381162] [<c000faa1>] (unwind_backtrace) from [<c000e8db>] (show_=
stack+0xb/0xc)
[   27.389103] [<c000e8db>] (show_stack) from [<c003f971>] (do_raw_spin=
_lock+0xb5/0xe8)
[   27.397224] [<c003f971>] (do_raw_spin_lock) from [<c030c949>] (_raw_=
spin_lock_irqsave+0xd/0x10)
[   27.406348] [<c030c949>] (_raw_spin_lock_irqsave) from [<c021927b>] =
(musb_host_finish_resume+0xf/0x60)
[   27.416109] [<c021927b>] (musb_host_finish_resume) from [<c0031709>]=
 (process_one_work+0xad/0x224)
[   27.425506] [<c0031709>] (process_one_work) from [<c0031b19>] (worke=
r_thread+0xc9/0x270)
[   27.433991] [<c0031b19>] (worker_thread) from [<c00355c7>] (kthread+=
0x7b/0x94)
[   27.441566] [<c00355c7>] (kthread) from [<c000cb7d>] (ret_from_fork+=
0x11/0x34)

Any ideas from the maintainers?

PS: As expected TI's PSP v3.2 driver works just fine :P
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
