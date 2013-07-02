From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/4] davinci: da8xx/omap-l1: Remove hard coding of rtc
	device wakeup
Date: Tue, 2 Jul 2013 11:10:14 +0530
Message-ID: <51D267BE.8090605@ti.com>
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
	<1372412109-986-3-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1372412109-986-3-git-send-email-gururaja.hebbar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, b-cousson-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


On 6/28/2013 3:05 PM, Hebbar Gururaja wrote:
> Since now rtc-omap driver itself calls deice_init_wakeup(dev, true),
> duplicate call from the rtc device registration can be removed.
> 
> This is basically a partial revert of the prev commit
> 
> commit 75c99bb0006ee065b4e2995078d779418b0fab54
> Author: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> 
>     davinci: da8xx/omap-l1: mark RTC as a wakeup source
> 
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
> Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>

Subject line should be prefixed with ARM: keeping with arch/arm
convention. Otherwise looks good.

Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

Thanks,
Sekhar
