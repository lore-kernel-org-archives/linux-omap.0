From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [Qemu-devel] Running linux on qemu omap
Date: Fri, 24 May 2019 18:00:18 +0300
Message-ID: <20190524150018.GA3156@t60.musicnaut.iki.fi>
References: <20190520190533.GA28160@Red>
 <20190521232323.GD3621@darkstar.musicnaut.iki.fi>
 <20190522093341.GA32154@Red>
 <20190522181904.GE3621@darkstar.musicnaut.iki.fi>
 <8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com>
 <c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
 <20190523183623.GB5234@darkstar.musicnaut.iki.fi>
 <CAFEAcA8C0WN5FwaW2kfWiRm1T8wML_fWXDKqRXP-Lv_P7ysy8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFEAcA8C0WN5FwaW2kfWiRm1T8wML_fWXDKqRXP-Lv_P7ysy8A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Corentin Labbe <clabbe.montjoie@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, May 24, 2019 at 10:08:09AM +0100, Peter Maydell wrote:
> On Thu, 23 May 2019 at 19:36, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > Cheetah works with serial console. I tried with console on display,
> > and it seems to boot up, and the frame buffer window gets correctly
> > sized but for some reason it just stays blank.
> 
> As a general question, when you're doing these tests are you
> using a kernel image that is known to work on real hardware?

With Cheetah (I wonder where that name comes from?), yes, same for
N8x0. SX1 I don't have, but the SoC is the same as on Palm TE.

> One problem we have with some of these older QEMU platforms
> is that it turns out that QEMU is only tested with the kernel,
> and the kernel support for the platform is only tested with
> QEMU, and so you get equal and opposite bugs in QEMU and the
> kernel that cancel each other out and don't get noticed...
>
> (On the QEMU side these platforms are all basically orphaned:
> if somebody submits patches to fix bugs we'll review them,
> but they're unlikely to get a great deal of attention otherwise.
> They're also quite near the top of the "maybe we'll just
> deprecate and then delete these" list, since we have not
> historically had any working guest images to test against.
> If there's a real userbase that wants them to continue to
> exist that's a different matter, of course.)

Please don't delete OMAP boards quite yet :) In the mainline kernel
they are not orphaned, they frequently get tested using actual hardware,
and QEMU would help in additional testing. I'll try to get N8x0 boot to
work with the minimal kernel I use on real HW.

Regarding N8x0 and bluetooth (mentioned in one of the linked threads), I
guess the removal of the bluetooth subsystem can be done without removing
the whole machine: just don't pass the OMAP BT TAG to the kernel anymore,
and it should ignore the BT hardware (just an idea based on quick read
of vendor kernel sources, the mainline kernel does not support BT on
this board).

A.
