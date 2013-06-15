From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] PM / AVS: SmartReflex: misc. cleanups for v3.11
Date: Sun, 16 Jun 2013 01:42:57 +0200
Message-ID: <4527471.8MLetdnxDa@vostro.rjw.lan>
References: <87r4g5ac75.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:38789 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237Ab3FOXdl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Jun 2013 19:33:41 -0400
In-Reply-To: <87r4g5ac75.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-omap <linux-omap@vger.kernel.org>, linux-pm@vger.kernel.org, nm@ti.com

On Thursday, June 13, 2013 03:16:30 PM Kevin Hilman wrote:
> Hi Rafael,
> 
> Please pull the following cleanups to  AVS/SmartReflex for v3.11.

Pulled, thanks Kevin!

Rafael


> The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:
> 
>   Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/omap-pm-v3.11/avs
> 
> for you to fetch changes up to efca406b940e93e6af38c597eecd5fb79b39b7ea:
> 
>   PM / AVS: SmartReflex: use devm_* API to initialize SmartReflex (2013-06-10 10:50:48 -0700)
> 
> ----------------------------------------------------------------
> PM / AVS: SmartReflex: misc. cleanups for v3.11
> 
> ----------------------------------------------------------------
> Andrii Tseglytskyi (6):
>       PM / AVS: SmartReflex: disable runtime PM on driver remove
>       PM / AVS: SmartReflex: fix driver name
>       PM / AVS: SmartReflex: use omap_sr * for errgen interfaces
>       PM / AVS: SmartReflex: use omap_sr * for minmax interfaces
>       PM / AVS: SmartReflex: use omap_sr * for enable/disable interface
>       PM / AVS: SmartReflex: use devm_* API to initialize SmartReflex
> 
> Nishanth Menon (1):
>       PM / AVS: SmartReflex: disable errgen before vpbound disable
> 
>  arch/arm/mach-omap2/smartreflex-class3.c |   8 +-
>  drivers/power/avs/smartreflex.c          | 154 +++++++++++++------------------
>  include/linux/power/smartreflex.h        |  10 +-
>  3 files changed, 72 insertions(+), 100 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
