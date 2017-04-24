From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: cpsw regression in mainline with "cpsw/netcp: cpts depends on posix_timers"
Date: Mon, 24 Apr 2017 19:35:18 +0200
Message-ID: <CAK8P3a3kvMubq5Mtu3XKnityAgRv5R35dMtTX=BO8Qv_iX9=VQ@mail.gmail.com>
References: <20170424165104.GC3780@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170424165104.GC3780@atomide.com>
Sender: netdev-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Networking <netdev@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 24, 2017 at 6:51 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> Looks like commit 07fef3623407 ("cpsw/netcp: cpts depends on posix_timers")
> in mainline started triggering the following oops at least on j5eco-evm.
>
> Adding CONFIG_PTP_1588_CLOCK to .config solves it, but the oops hints
> something is wrong with the dependencies.. CONFIG_TI_CPTS defaults to N
> and not selecting it causes the oops.
>
> Any ideas what's needed to properly fix this?

Does your configuration have POSIX_TIMERS enabled? If not, then CPTS
is now also disabled. There are two issues here that we need to solve:

a) find out why POSIX_TIMERS got disabled, and make sure it's always
    turned on for normal users

b) find out what's wrong with the driver when CPTS is disabled. This would
    be an existing problem that you just never saw because CPTS was
    always enabled so far.

        Arnd
