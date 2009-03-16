From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/12] ARM: OMAP3: mmc-twl4030 allow arbitrary slot
	names
Date: Mon, 16 Mar 2009 11:01:22 -0700
Message-ID: <20090316180122.GF19229@atomide.com>
References: <20090310205824.16425.97745.stgit@localhost> <20090310211352.16425.44160.stgit@localhost> <20090315160838.GF10786@n2100.arm.linux.org.uk> <49BE2453.9020801@nokia.com> <20090316101648.GB31868@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVh9lyqKgK19OcEf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54590 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090AbZCPSB2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 14:01:28 -0400
Content-Disposition: inline
In-Reply-To: <20090316101648.GB31868@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, David Brownell <dbrownell@users.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090316 03:17]:
> On Mon, Mar 16, 2009 at 12:05:07PM +0200, Adrian Hunter wrote:
> >> From 9b04f19a7e88f8877176c25845c38676ee3127c1 Mon Sep 17 00:00:00 2001
> > From: Adrian Hunter <adrian.hunter@nokia.com>
> > Date: Tue, 10 Mar 2009 22:13:52 +0100
> > Subject: [PATCH] ARM: OMAP3: mmc-twl4030 allow arbitrary slot names
> >
> > Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> > ---
> > arch/arm/mach-omap2/mmc-twl4030.c |    6 +++++-
> > arch/arm/mach-omap2/mmc-twl4030.h |    1 +
> > 2 files changed, 6 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
> > index a612a02..88b4bed 100644
> > --- a/arch/arm/mach-omap2/mmc-twl4030.c
> > +++ b/arch/arm/mach-omap2/mmc-twl4030.c
> > @@ -328,7 +328,11 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
> > 			return;
> > 		}
> >
> > -		sprintf(twl->name, "mmc%islot%i", c->mmc, 1);
> > +		if (c->name)
> > +			strlcpy(twl->name, c->name, ARRAY_SIZE(twl->name));
> > +		else
> > +			snprintf(twl->name, ARRAY_SIZE(twl->name),
> > +				 "mmc%islot%i", c->mmc, 1);
> 
> Good, except now we have a confusion over which patch does what...

Here's this one updated to apply with snprintf moved to the earlier
patch in the series.

Tony

--EVh9lyqKgK19OcEf
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="hsmmc-slot-names-v3.patch"

>From 10e3a1012fce568e4be375102bf7af33543cb072 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Mon, 16 Mar 2009 10:57:32 -0700
Subject: [PATCH] ARM: OMAP3: mmc-twl4030 allow arbitrary slot names, v3

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index e2b2aeb..dc40b3e 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -402,8 +402,11 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 			return;
 		}
 
-		snprintf(twl->name, ARRAY_SIZE(twl->name), "mmc%islot%i",
-				c->mmc, 1);
+		if (c->name)
+			strncpy(twl->name, c->name, HSMMC_NAME_LEN);
+		else
+			snprintf(twl->name, ARRAY_SIZE(twl->name),
+				"mmc%islot%i", c->mmc, 1);
 		mmc->slots[0].name = twl->name;
 		mmc->nr_slots = 1;
 		mmc->slots[0].wires = c->wires;
diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-twl4030.h
index 0aa1686..ea59e86 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -14,6 +14,7 @@ struct twl4030_hsmmc_info {
 	bool	cover_only;	/* No card detect - just cover switch */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
+	char	*name;		/* or NULL for default */
 	struct device *dev;	/* returned: pointer to mmc adapter */
 };
 

--EVh9lyqKgK19OcEf--
