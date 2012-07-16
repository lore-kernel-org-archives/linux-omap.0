From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] gpio/omap: add *remove* callback in platform_driver
Date: Mon, 16 Jul 2012 15:01:13 -0700
Message-ID: <87y5mjcqmu.fsf@ti.com>
References: <1341997995-14020-1-git-send-email-tarun.kanti@ti.com>
	<1341997995-14020-3-git-send-email-tarun.kanti@ti.com>
	<87394xhocn.fsf@ti.com>
	<CACRpkdZMG_ZHW_eGGrdrJh1SuO_=hOObijzmxG1ob6RoNf_dwg@mail.gmail.com>
	<87a9z4g9bi.fsf@ti.com>
	<CACRpkdZxUpQ=a-yQ8b4bnX3S9penPWkxJ+PG2Zi4i9YZibYRiw@mail.gmail.com>
	<87ipdnein1.fsf@ti.com>
	<CACRpkdYMzdjFXBMs6do-yqiBFV5ru28SftA5u+ZkP5KO+PhjCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYMzdjFXBMs6do-yqiBFV5ru28SftA5u+ZkP5KO+PhjCA@mail.gmail.com>
	(Linus Walleij's message of "Mon, 16 Jul 2012 22:49:17 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Mon, Jul 16, 2012 at 7:10 PM, Kevin Hilman <khilman@ti.com> wrote:
>
>> Subject: [PATCH] MAINTAINERS: add entry OMAP GPIO driver
>>
>> Since I've been maintaining this, making it official at the request of the
>> GPIO maintainers.
>>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> Thank! Applied, but:
>
>> +F:     drivers/gpio/gpio.omap.c
>
> I replaced the period with a dash:
> drivers/gpio/gpio-omap.c

Ah, you caught me again trying to avoid getting mail for that driver. ;)

Kevin
