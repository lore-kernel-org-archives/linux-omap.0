From: Kevin Hilman <khilman@ti.com>
Subject: Re: CPUFREQ maintainence.
Date: Tue, 08 May 2012 09:56:51 -0700
Message-ID: <877gwmr4q4.fsf@ti.com>
References: <20120430140645.GB12583@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20120430140645.GB12583@redhat.com> (Dave Jones's message of
	"Mon, 30 Apr 2012 10:06:45 -0400")
Sender: cpufreq-owner@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> This last few releases I've been more of a hindrance than help to getting
> some of the patches merged upstream, so due to my lack of time, I'm considering
> removing myself as maintainer, and having patches routed as such instead...

Thanks Dave for your work in maintaining the core all this time!

> ARM -> Russell/relevant ARM subtree maintainers
> x86 driver patches -> x86@vger.kernel.org
> (All the other archs currently supported already go through the arch trees mips/sparc etc)

I will continue to handle the OMAP driver.

> The core doesn't see a huge amount of change these days, I figure patches for
> that can just go to lkml & Linus/Andrew like any other subsystem.
>
> comments?

I suppose we should we create separate MAINTAINERS entries for each of
the drivers?

If so, here's one to add the OMAP CPUfreq driver to the rest of the OMAP
PM stuff I maintain.  I Cc'd the linux-omap list in case there are any
objections to me adding myself.

Kevin

>From 307f4150416c34936d7f0011d7f1b2146c13f9a0 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Tue, 8 May 2012 09:51:22 -0700
Subject: [PATCH] MAINTAINERS: add OMAP CPUfreq driver to OMAP Power
 Management section

Add the OMAP CPUFreq driver to the list of files in the OMAP Power
Management section.

I've already been maintaining this driver, this just makes it
official.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7071633..3f5212b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4788,6 +4788,7 @@ M:	Kevin Hilman <khilman@ti.com>
 L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	arch/arm/*omap*/*pm*
+F:	drivers/cpufreq/omap-cpufreq.c
 
 OMAP POWERDOMAIN/CLOCKDOMAIN SOC ADAPTATION LAYER SUPPORT
 M:	Rajendra Nayak <rnayak@ti.com>
-- 
1.7.9.2


