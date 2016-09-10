From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: L3 error handling (was: Re: [4.8.0-rc1] am335x-evm boot failure:
 n_tty_receive_buf_common: "Unable to handle kernel paging request..")
Date: Sat, 10 Sep 2016 16:46:49 +0200
Message-ID: <CAALWOA_7qGg0WyHPE3biVLka7CdLj8VgsGzf1WMG62Rt-oONkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 10 September 2016 at 15:10, Tony Lindgren <tony@atomide.com> wrote:
> Yeah I don't think we have L3 interrupts working for am335x.

It probably doesn't help that the L3 interconnect registers on the
am335x aren't documented in the TRM. See below for its list of
components, target IDs, address mapping, and L3 error irq routing
(obtained by mostly-automated scanning/testing).

The problem you mention of getting a useless traceback is indeed
annoying, but on a cortex-a8 it wouldn't happen for device accesses:
external aborts on device reads (and strongly-ordered reads/writes)
are synchronous and taken before the irq. If you'd hook into that
handler and grab/clear the corresponding L3 error to make the abort
more informative then the irq will never be taken. Bus errors on
device writes outside the cortex-A8 subsystem never result in an abort
reported to the cpu and by the time the irq is taken the traceback may
be less informative (although there's still good chance it's not far
from the culprit).

On the cortex-A9 I don't know what the situation is.

On the cortex-A15 I don't think your advice actually helps since all
bus errors seem to result in async aborts reported really ridiculously
late: I've seen bus errors in a userspace process actually get
reported by the L3 noc driver (complete with useless traceback),
resulting in a task switch to systemd-journald to log all that spam,
and only *then* the async abort was taken resulting in a perfectly
innocent process getting killed with a SIGBUS.

Needless to say, this is just... wrong.

Matthijs
