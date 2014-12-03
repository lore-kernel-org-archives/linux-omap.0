From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] hsi / OMAP / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Wed, 03 Dec 2014 20:49:12 +0100
Message-ID: <2553100.3OLsEPLv6G@wuerfel>
References: <6319344.XVfdONE5DJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6319344.XVfdONE5DJ@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 03 December 2014 03:02:24 Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
> depending on CONFIG_PM_RUNTIME may now be changed to depend on
> CONFIG_PM.
> 
> Do that for the omap_ssi driver.
> 

Just for clarification: does that mean that PM, PM_RUNTIME, and PM_SLEEP
are all synonyms now, or is there still some other combination that
allows a subset to be set?

Before we do lots of s/CONFIG_PM_SLEEP/CONFIG_PM/ changes in lots of
other drivers, it would be nice to come up with a new set of macros
to replace all the SET_RUNTIME_PM_OPS/SIMPLE_DEV_PM_OPS/..._OPS
with a version that avoided the #ifdefs altogether.

	Arnd
