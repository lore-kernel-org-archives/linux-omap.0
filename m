From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] Running linux on qemu omap
Date: Fri, 24 May 2019 10:08:09 +0100
Message-ID: <CAFEAcA8C0WN5FwaW2kfWiRm1T8wML_fWXDKqRXP-Lv_P7ysy8A@mail.gmail.com>
References: <20190520190533.GA28160@Red> <20190521232323.GD3621@darkstar.musicnaut.iki.fi>
 <20190522093341.GA32154@Red> <20190522181904.GE3621@darkstar.musicnaut.iki.fi>
 <8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com> <c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
 <20190523183623.GB5234@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190523183623.GB5234@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, Corentin Labbe <clabbe.montjoie@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 23 May 2019 at 19:36, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Cheetah works with serial console. I tried with console on display,
> and it seems to boot up, and the frame buffer window gets correctly
> sized but for some reason it just stays blank.

As a general question, when you're doing these tests are you
using a kernel image that is known to work on real hardware?
One problem we have with some of these older QEMU platforms
is that it turns out that QEMU is only tested with the kernel,
and the kernel support for the platform is only tested with
QEMU, and so you get equal and opposite bugs in QEMU and the
kernel that cancel each other out and don't get noticed...

(On the QEMU side these platforms are all basically orphaned:
if somebody submits patches to fix bugs we'll review them,
but they're unlikely to get a great deal of attention otherwise.
They're also quite near the top of the "maybe we'll just
deprecate and then delete these" list, since we have not
historically had any working guest images to test against.
If there's a real userbase that wants them to continue to
exist that's a different matter, of course.)

thanks
- PMM
