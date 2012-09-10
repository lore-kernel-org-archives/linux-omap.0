From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH v2] watchdog: omap_wdt: convert to new watchdog core
Date: Mon, 10 Sep 2012 09:45:58 +0300
Message-ID: <20120910094558.b4e569e67505d3f61bead2d5@bitmer.com>
References: <1347127441-23125-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347127441-23125-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, jarkko.nikula@jollamobile.com
List-Id: linux-omap@vger.kernel.org

On Sat,  8 Sep 2012 21:04:01 +0300
Aaro Koskinen <aaro.koskinen@iki.fi> wrote:

> Convert omap_wdt to new watchdog core. On OMAP boards, there are usually
> multiple watchdogs. Since the new watchdog core supports multiple
> watchdogs, all watchdog drivers used on OMAP should be converted.
> 
> The legacy watchdog device node is still created, so this should not
> break existing users.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
> 
> v2: Fix a bug in the first version of the patch: __omap_wdt_disable()
> in probe was mistakenly moved outside PM runtime calls. This caused a
> crash as device was probably accessed with some clocks off. Thanks to
> Jarkko Nikula <jarkko.nikula@bitmer.com> for reporting this.
> 
>  drivers/watchdog/Kconfig    |    1 +
>  drivers/watchdog/omap_wdt.c |  266 ++++++++++++++++++-------------------------
>  2 files changed, 114 insertions(+), 153 deletions(-)
> 
Tested-by: Jarkko Nikula <jarkko.nikula@jollamobile.com>
