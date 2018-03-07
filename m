From: Maciej Purski <m.purski@samsung.com>
Subject: Re: Regulator regression in next-20180305
Date: Wed, 07 Mar 2018 13:57:12 +0100
Message-ID: <bb1adc11-40ff-d37d-60f1-d6e706b058a6@samsung.com>
References: <20180305231246.GB5799@atomide.com>
        <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
        <CGME20180306163044epcas2p1b5bc62e4cba6c6e8c8ea7e75329c11ef@epcas2p1.samsung.com>
        <20180306163035.GE13586@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180306163035.GE13586@sirena.org.uk>
Content-language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hi all,
sorry it took me so long to answer.

On 03/06/2018 05:30 PM, Mark Brown wrote:
> On Mon, Mar 05, 2018 at 08:22:26PM -0300, Fabio Estevam wrote:
>> On Mon, Mar 5, 2018 at 8:12 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
>>> Looks like with next-20180305 there's a regulator regression
>>> where mmc0 won't show any cards or produces errors:
> 
>>> mmcblk0: error -110 requesting status
>>> mmc1: new high speed SDIO card at address 0001
>>> mmcblk0: error -110 requesting status
>>> mmcblk0: recovery failed!
>>> print_req_error: I/O error, dev mmcblk0, sector 0
>>> Buffer I/O error on dev mmcblk0, logical block 0, async page read
>>> mmcblk0: error -110 requesting status
>>> mmcblk0: recovery failed!
> 
> No other error messages?  That seems like there's something going on
> that's very different to what Fabio was reporting...  I'm guessing some
> voltage application didn't go through but it's hard to tell with so
> little data.  dra7 does seem to have what Fabio had though so there's
> definitely some effect on the OMAP platforms.
>  >> I have also seen regulator issues due to this series:
>> https://lkml.org/lkml/2018/3/5/731
> 
> Looking at your stuff I'm having trouble figuring out what's going on -
> we're getting double locking of a parent regulator during enable
> according to your backtraces but it's not clear to me what took that
> lock already.  regulator_enable() walks the supplies before it takes
> the lock on the regulator it's immediately being called on, not holding
> any locks on supplies while enabling.  regulator_balance_voltage() then
> tries to lock the supplies again but lockdep says the lock is already
> held by regulator_enable().  It's also weird that this doesn't seem to
> be showing up on other boards in kernelci, the regulator setup on those
> i.MX boards looks to be quite simple so I'd expect a much wider impact.
>

I'm trying to figure out what is so special about these boards. The only strange 
thing, that I haven't noticed at first, is that all regulators share a common 
supply - dummy regulator. It is defined in anatop_regulator.c.


> I'm wondering if your case is more pain from mutex_lock_nested(), both
> regulator_lock_coupled() and regulator_lock_supply() will end up using
> indexes starting at 0 for the locking classes.  That doesn't smell right
> though, but in case my straw clutching works:
> 
> If we can't figure it out I'll just drop the series but I'd prefer to at
> least understand what's going on.
>

I have been struggling to reproduce the issue on my exynos boards, but all I 
have achieved is getting the same lockdep warning, but everything else works 
fine. I think it was a false positive caused by using the same indices in 
lock_coupled() and lock_supply().

> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index e685f8b94acf..2c5b20a97f51 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -159,7 +159,7 @@ static void regulator_lock_supply(struct regulator_dev *rdev)
>   {
>   	int i;
>   
> -	for (i = 0; rdev; rdev = rdev_get_supply(rdev), i++)
> +	for (i = 1000; rdev; rdev = rdev_get_supply(rdev), i++)
>   		mutex_lock_nested(&rdev->mutex, i);
>   }
>   
> 

Best regards,
Maciej Purski
