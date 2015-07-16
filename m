From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/12] ARM: OMAP2+: Fix scrm compatible for dm814x
Date: Thu, 16 Jul 2015 02:11:09 -0700
Message-ID: <20150716091109.GK17550@atomide.com>
References: <1433348601-8966-1-git-send-email-tony@atomide.com>
 <1433348601-8966-3-git-send-email-tony@atomide.com>
 <556F50B8.6000903@cogentembedded.com>
 <20150603193806.GW30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150603193806.GW30984@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Matthijs van Duin <matthijsvanduin@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150603 12:39]:
> * Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> [150603 12:10]:
> > Hello.
> > 
> > On 06/03/2015 07:23 PM, Tony Lindgren wrote:
> > 
> > >Fix scrm compatible for dm814x.
> > 
> >    So, scrm...
> > 
> > >Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
> > >Signed-off-by: Tony Lindgren <tony@atomide.com>
> > >---
> > >  arch/arm/mach-omap2/control.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > >diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> > >index af95a62..364925c 100644
> > >--- a/arch/arm/mach-omap2/control.c
> > >+++ b/arch/arm/mach-omap2/control.c
> > >@@ -649,6 +649,7 @@ static const struct of_device_id omap_scrm_dt_match_table[] = {
> > >  	{ .compatible = "ti,am4-scm", .data = &ctrl_data },
> > >  	{ .compatible = "ti,omap2-scm", .data = &omap2_ctrl_data },
> > >  	{ .compatible = "ti,omap3-scm", .data = &omap2_ctrl_data },
> > >+	{ .compatible = "ti,dm814-scm", .data = &ctrl_data },
> > 
> >    ... or scm? :-)
> > 
> > >  	{ .compatible = "ti,dm816-scrm", .data = &ctrl_data },
> > >  	{ .compatible = "ti,omap4-scm-core", .data = &ctrl_data },
> > >  	{ .compatible = "ti,omap5-scm-core", .data = &ctrl_data },
> 
> Thanks, yeah we should standardize on scm.

Below is this one updated to use scm instead of scrm in the
description.

Regards,

Tony

8< -------------------
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 16 Jul 2015 01:55:57 -0700
Subject: [PATCH] ARM: OMAP2+: Fix scm compatible for dm814x

Fix scm compatible for dm814x.

Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -652,6 +652,7 @@ static const struct of_device_id omap_scrm_dt_match_table[] = {
 	{ .compatible = "ti,am4-scm", .data = &ctrl_data },
 	{ .compatible = "ti,omap2-scm", .data = &omap2_ctrl_data },
 	{ .compatible = "ti,omap3-scm", .data = &omap2_ctrl_data },
+	{ .compatible = "ti,dm814-scm", .data = &ctrl_data },
 	{ .compatible = "ti,dm816-scrm", .data = &ctrl_data },
 	{ .compatible = "ti,omap4-scm-core", .data = &ctrl_data },
 	{ .compatible = "ti,omap5-scm-core", .data = &ctrl_data },
