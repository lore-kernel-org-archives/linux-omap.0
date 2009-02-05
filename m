From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] OMAP: MMC: recover from transfer failures - Resend
Date: Thu, 5 Feb 2009 12:10:45 -0800
Message-ID: <20090205121045.4022c319.akpm@linux-foundation.org>
References: <20081207213617.10456.43951.stgit@localhost>
	<200902020946.16508.jpihet@mvista.com>
	<20090202190503.GT7215@atomide.com>
	<200902031505.58697.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <200902031505.58697.jpihet@mvista.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Jean Pihet <jpihet@mvista.com>
Cc: tony@atomide.com, ext-adrian.hunter@nokia.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, jarkko.lavinen@nokia.com, drzeus-mmc@drzeus.cx, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 3 Feb 2009 15:05:58 +0100
Jean Pihet <jpihet@mvista.com> wrote:

> +	while (OMAP_HSMMC_READ(host->base,
> + 			SYSCTL) & SRD)
> + 		;

Is a __raw_readl() sufficient to prevent the cpu from burning up here,
or should we add cpu_relax()?

An infinite loop which assumes the hardware is perfect is always a
worry.  But I see the driver already does that, so we're no worse off..


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
