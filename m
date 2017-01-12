From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 4/6] power: bq24190_charger: Don't read fault register
 outside irq_handle_thread()
Date: Wed, 11 Jan 2017 17:32:54 -0800
Message-ID: <CAKvHMgTrw4DqC5UUbnUXG5kpUAxTn2y5v8QvqHBtx40===xcew@mail.gmail.com>
References: <20170112004154.31568-1-tony@atomide.com> <20170112004154.31568-5-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170112004154.31568-5-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 11, 2017 at 4:41 PM, Tony Lindgren <tony@atomide.com> wrote:
> From: Liam Breck <kernel@networkimprov.net>
>
> Caching the fault register after a single read may not keep an accurate
> value.
>
> Fix the issue by doing two reads of the fault register as specified in the
> data sheet. And let's do this only irq_handle_thread() to avoid accidentally
> clearing the fault status as specified in the data sheet:
>
> "When a fault occurs, the charger device sends out INT
>  and keeps the fault state in REG09 until the host reads the fault register.
>  Before the host reads REG09 and all the faults are cleared, the charger
>  device would not send any INT upon new faults. In order to read the
>  current fault status, the host has to read REG09 two times consecutively.
>  The 1st reads fault register status from the last read [1] and the 2nd reads
>  the current fault register status."
>
> [1] presumably a typo; should be "last fault"
>
> Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190 Battery
> Charger")
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Cc: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> [tony@atomide.com: cleaned up a bit]
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/power/supply/bq24190_charger.c | 99 ++++++++++------------------------
>  1 file changed, 29 insertions(+), 70 deletions(-)

This got a bit mangled in transition, and the fix will prevent the
following patches from applying.

I'll post a fix shortly.
