From: tony@atomide.com
Subject: Re: [PATCH] ARM: OMAP: Disable 32kHz timer warning
Date: Thu, 10 Aug 2006 09:55:17 +0300
Message-ID: <20060810065516.GB30195@atomide.com>
References: <fb249edb0608092349l7af8a3a0sc34efd84013d8a8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0608092349l7af8a3a0sc34efd84013d8a8e@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrog@zabor.org> [060810 09:49]:
> This makes the following warning conditional as the 32kHz timer is
> only implemented for 16xx out of OMAP1 cpus:
> arch/arm/mach-omap1/pm.c:138:2: warning: #warning Enable 32kHz OS
> timer in order to allow sleep states in idle

The warning is still valid though. The current tree does not use sleep
states for idling for 15xx.

It may be worth checking if there is a continuously running 32KHz
timer somewhere on 15xx as it would allow using dynamic tick and sleep
states for idling. Last time I looked I did not find anything, but then
again I only browsed the TRM and did not scan registers for it.

Could somebody at TI confirm if 15xx has a continuously running 32KHz
timer at some register? If not, some other unused timer could be
set to run at 32KHz continuously to update time from it.

Regards,

Tony
