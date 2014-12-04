From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] hsi / OMAP / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Thu, 04 Dec 2014 10:23:35 +0100
Message-ID: <8906994.EV0QeHVvVO@wuerfel>
References: <6319344.XVfdONE5DJ@vostro.rjw.lan> <2553100.3OLsEPLv6G@wuerfel> <22524926.vCRamu0d6Y@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <22524926.vCRamu0d6Y@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 03 December 2014 23:45:22 Rafael J. Wysocki wrote:
> http://marc.info/?l=linux-kernel&m=141712284917133&w=4
> 
> > Before we do lots of s/CONFIG_PM_SLEEP/CONFIG_PM/ changes in lots of
> > other drivers, it would be nice to come up with a new set of macros
> > to replace all the SET_RUNTIME_PM_OPS/SIMPLE_DEV_PM_OPS/..._OPS
> > with a version that avoided the #ifdefs altogether.
> 
> I don't think we can avoid all of the #ifdefs and the macros still work
> (except for one which is redundant, but I have a patch to clean that up).

Right, while we can create a version that does not require the #ifdef,
that would still mean we'd have to touch every file and replace
SET_RUNTIME_PM_OPS with PM_SET_RUNTIME_OPS or something like that
because the new macro would not work if the function is not defined.

	Arnd
