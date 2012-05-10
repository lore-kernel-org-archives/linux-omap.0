From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2] gpio/omap: fix incorrect initialization of omap_gpio_mod_init
Date: Thu, 10 May 2012 07:23:56 -0700
Message-ID: <87mx5gm7wj.fsf@ti.com>
References: <1335770412-1344-1-git-send-email-tarun.kanti@ti.com>
	<CANOLnOO3bSxoE-8TaXd_Tz=taPOZpfQY+z-=6c7Ovfpf+FCAuw@mail.gmail.com>
	<CAC83ZvLYmPr3qTRUUTom1iOA-czef9EVcM229UMDePnw8sbA+w@mail.gmail.com>
	<1664819.7TVaX0jpJi@acer>
	<CAC83ZvKHDWmNneK5GQgSPhdg88apymEgUr0zm1EVYjfaWG2oXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:50441 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755623Ab2EJOYB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 10:24:01 -0400
Received: by dadv36 with SMTP id v36so1900356dad.41
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 07:23:59 -0700 (PDT)
In-Reply-To: <CAC83ZvKHDWmNneK5GQgSPhdg88apymEgUr0zm1EVYjfaWG2oXA@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Thu, 10 May 2012 10:45:13 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

Grant,

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> Hi,
>
> On Thu, May 10, 2012 at 3:06 AM, Janusz Krzysztofik
> <jkrzyszt@tis.icnet.pl> wrote:
>> On Mon, 7 May 2012 10:52:28 DebBarma, Tarun Kanti wrote:
>>> On Sun, May 6, 2012 at 3:25 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
>>> > On Mon, Apr 30, 2012 at 10:20 AM, Tarun Kanti DebBarma
>>> > <tarun.kanti@ti.com> wrote:
>>> >> Initialization of irqenable, irqstatus registers is the common
>>> >> operation done in this function for all OMAP platforms, viz. OMAP1,
>>> >> OMAP2+. The latter _gpio_rmw()'s which supposedly got introduced
>>> >> wrongly to take care of OMAP2+ platforms were overwriting initially
>>> >> programmed OMAP1 value breaking functionality on OMAP1.
>>
>> Hi,
>> I can confirm that my other issues with GPIO on Amstrad Delta were not
>> related, and this patch is still required for GPIO interrupts hardware
>> being correctly initialized on OMAP1 in 3.4-rc6. You can add my
>>
>> Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>>
>> if you wish.
> Thank you for confirming!!

We'd like to get this one in for v3.4-rc.  Can you queue it?

I added the tested-by from Janusz and my signoff, and pull request is
below.

Thanks,

Kevin



The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

  Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.5/fixes/gpio

for you to fetch changes up to 6edd94db250038c8fdf176f23ca4017d2f312509:

  gpio/omap: fix incorrect initialization of omap_gpio_mod_init (2012-05-10 07:16:15 -0700)

----------------------------------------------------------------
Tarun Kanti DebBarma (1):
      gpio/omap: fix incorrect initialization of omap_gpio_mod_init

 drivers/gpio/gpio-omap.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)



