From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v1 0/3] PM / AVS: SmartReflex: driver misc fixes
Date: Tue, 28 May 2013 14:03:08 -0700
Message-ID: <87li6ybywj.fsf@linaro.org>
References: <1369652846-14412-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369652846-14412-1-git-send-email-andrii.tseglytskyi@ti.com>
	(Andrii Tseglytskyi's message of "Mon, 27 May 2013 14:07:23 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Cc: J Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Andrii Tseglytskyi <andrii.tseglytskyi@ti.com> writes:

> The following patch series contain several misc fixes to SmartReflex driver:
>
> 1. disable errgen before vpbound disable. Critical fix, needed for
> proper work of AVS-VP communicaton protocol.
>
> 2. disable runtime PM on driver remove. Trivial - runtime PM cleanup.
>
> 3. fix driver name. Trivial - proper DRIVER_NAME was not defined
> since SmartReflex driver was introduced with initial commit.
>
> Patches are based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> tag: v3.10-rc2
>
> Verified on OMAP4430. Boot - OK. SmartReflex registers debug dump - OK
>
> Available on GitHub:
> https://github.com/andriit/linux-omap-k3.8/commits/avs_sr_driver_misc_fixes_v01
>
> Andrii Tseglytskyi (2):
>   PM / AVS: SmartReflex: disable runtime PM on driver remove
>   PM / AVS: SmartReflex: fix driver name
>
> Nishanth Menon (1):
>   PM / AVS: SmartReflex: disable errgen before vpbound disable
>
>  drivers/power/avs/smartreflex.c |   15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

I had a minor comment on PATCH 1/3, otherwise these look good for v3.11
(since they are not regressions, they don't qualify for v3.10.)

Please repost with the changes and be sure to copy linux-pm@vger.kernel.org

Thanks,

Kevin
