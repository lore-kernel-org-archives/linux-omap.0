From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC PATCH v2 0/7] i2c: core: introduce atomic transfers
Date: Sat, 2 Mar 2019 18:22:08 +0200
Message-ID: <CAHp75Vc-WYUJgaDPuWUn-_0Cizq=MG7N2cdHJxaEbad+xntcjQ@mail.gmail.com>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Tero Kristo <t-kristo@ti.com>, Phil Reid <preid@electromag.com.au>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, linux-tegra@vger.kernel.org, Stefan Lengfeld <contact@stefanchrist.eu>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Rosin <peda@axentia.se>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Mar 2, 2019 at 3:49 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> So, finally, here is the second RFC for supporting I2C transfers in atomic
> contexts (i.e. very late). This will need some text because I tried some things
> on the way but had to discard them. However, I think it is important to have
> that documented.

> Sorry, no TLDR; text here - I think this topic deserves a few words ;)

Thank you for this work! It was indeed interesting reading.
And since your series is targetting some exiting use cases, I would
drop as well academic variants of brain-damaged hw design, I think it
worth to go.

WRT patches,

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

for patches 1-2
and FWIW for patches 3-4.

For the individual drivers I can't say much, code looks good, but I
dunno if it's correct or not.

>
> Looking forward to comments, thanks!
>
>    Wolfram
>
>
> [1] http://patchwork.ozlabs.org/patch/1044789/
>
>
> Tero Kristo (1):
>   i2c: busses: omap: Add the master_xfer_irqless hook
>
> Wolfram Sang (6):
>   i2c: apply coding style for struct i2c_adapter
>   i2c: core: use I2C locking behaviour also for SMBUS
>   i2c: core: introduce callbacks for atomic transfers
>   i2c: demux: WIP: handle the new atomic callbacks
>   i2c: tegra-bpmp: convert to use new atomic callbacks
>   i2c: algo: bit: HACK! add atomic callback
>
>  drivers/i2c/algos/i2c-algo-bit.c      |  5 ++-
>  drivers/i2c/busses/i2c-omap.c         | 79 +++++++++++++++++++++++++++++------
>  drivers/i2c/busses/i2c-tegra-bpmp.c   | 27 +++++++++---
>  drivers/i2c/i2c-core-base.c           | 17 ++++----
>  drivers/i2c/i2c-core-smbus.c          | 25 ++++++++---
>  drivers/i2c/i2c-core.h                | 15 +++++++
>  drivers/i2c/muxes/i2c-demux-pinctrl.c |  3 ++
>  include/linux/i2c.h                   | 38 +++++++++++------
>  8 files changed, 162 insertions(+), 47 deletions(-)
>
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
