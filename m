From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 02/12] arm: omap3: Only sleep during cpu_idle if I/O wake-ups
 work
Date: Wed, 11 Apr 2012 18:42:44 -0500
Message-ID: <4F8616F4.4010109@ti.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com> <1334171147-7517-3-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38915 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965265Ab2DKXmr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 19:42:47 -0400
In-Reply-To: <1334171147-7517-3-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, paul@pwsan.com

Hi Mark,

On 04/11/2012 02:05 PM, Mark A. Greer wrote:
> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Currently in the OMAP3 code, cpu_idle() calls pm_idle(),
> which is a function pointer set to omap3_pm_idle()).
> omap3_pm_idle() calls omap_sram_idle() which eventually
> causes a 'wfi' instruction to be executed effectively
> putting the system to sleep.  It is assumed that an
> I/O wake-up event will occur to wake the system up again.
> This doesn't work on systems that don't support I/O wake-ups
> (indicated by omap3_has_io_wakeup() returning false).
> 
> Leaving pm_idle() pointing to default_idle() won't work
> either because the cpu_<processor>_do_idle() routine which
> is eventually called may also execute a 'wfi' instruction
> (e.g., cpu_v7_do_idle()).

So with this change you will never execute wfi?

I would have thought a timer or peripheral interrupt would be able to
bring you out of wfi. IO wake-ups would only be needed for very low
power states. At least that is how it is on OMAP devices. I am not sure
how the AMxxx devices differ.

Cheers
Jon
