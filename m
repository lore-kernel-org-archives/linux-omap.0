From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] watchdog: omap_wdt: convert to new watchdog core
Date: Fri, 7 Sep 2012 16:31:07 +0300
Message-ID: <20120907133107.GA14585@bitmer.com>
References: <1346769684-25543-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1346769684-25543-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi

On Tue, Sep 04, 2012 at 05:41:24PM +0300, Aaro Koskinen wrote:
> Convert omap_wdt to new watchdog core. On OMAP boards, there are usually
> multiple watchdogs. Since the new watchdog core supports multiple
> watchdogs, all watchdog drivers used on OMAP should be converted.
> 
> The legacy watchdog device node is still created, so this should not
> break existing users.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/watchdog/Kconfig    |    1 +
>  drivers/watchdog/omap_wdt.c |  268 ++++++++++++++++++-------------------------
>  2 files changed, 115 insertions(+), 154 deletions(-)
> 
Am I missing some extra patch but this causes a crash on top of v3.6-rc4
commit eeea3ac?

Crash happens in omap_wdt.c:99 on Nokia N9.

-- 
Jarkko
