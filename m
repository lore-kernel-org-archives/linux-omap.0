From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH] ARM: OMAP2+: Fix updating of sysconfig register
Date: Tue, 8 Mar 2016 07:01:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603080656210.4974@utopia.booyaka.com>
References: <1456832887-5312-1-git-send-email-lokeshvutla@ti.com>
 <alpine.DEB.2.02.1603011703170.14948@utopia.booyaka.com>
 <56D65FD4.4090206@ti.com> <56D69883.6070603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <56D69883.6070603@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lokesh Vutla <a0131933@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, jonathanh@nvidia.com, Tero Kristo <t-kristo@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, 2 Mar 2016, Tero Kristo wrote:

> On 03/02/2016 05:36 AM, Lokesh Vutla wrote:
> > On Tuesday 01 March 2016 10:33 PM, Paul Walmsley wrote:
> > > + Jon Hunter
> > > 
> > > On Tue, 1 Mar 2016, Lokesh Vutla wrote:
> > > 
> > > > commit 127500ccb766f ("ARM: OMAP2+: Only write the sysconfig on idle
> > > > when necessary") talks about verification of sysconfig cache value
> > > > before
> > > > updating it, only during idle path. But the patch is adding the
> > > > verification in the enable path. So, adding the check in a proper place
> > > > as per the commit description.
> > > > 
> > > > Not keeping this check during enable path as there is a chance of losing
> > > > context and it is safe to do on idle as the context of the register will
> > > > never be lost while the device is active.
> > 
> > When the patch was originally posted[1], this check was in proper place
> > itself. Not sure what happened after that.
> 
> Looks like a merge conflict to me.
> 
> The patch from Lokesh fixes it, so:
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

Yep, this one looks like I (accidentally) caused this one.

Will queue the following patch for v4.6-rc.


- Paul


From: Lokesh Vutla <lokeshvutla@ti.com>
Date: Tue, 1 Mar 2016 17:18:07 +0530
Subject: [PATCH] ARM: OMAP2+: hwmod: Fix updating of sysconfig register

Commit 127500ccb766f ("ARM: OMAP2+: Only write the sysconfig on idle
when necessary") talks about verification of sysconfig cache value before
updating it, only during idle path. But the patch is adding the
verification in the enable path. So, adding the check in a proper place
as per the commit description.

Not keeping this check during enable path as there is a chance of losing
context and it is safe to do on idle as the context of the register will
never be lost while the device is active.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Tero Kristo <t-kristo@ti.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: <stable@vger.kernel.org> # 3.12+
Fixes: commit 127500ccb766 "ARM: OMAP2+: Only write the sysconfig on idle when necessary"
[paul@pwsan.com: appears to have been caused by my own mismerge of the
 originally posted patch]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e9f65fec55c0..71b374790c76 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1416,9 +1416,7 @@ static void _enable_sysc(struct omap_hwmod *oh)
 	    (sf & SYSC_HAS_CLOCKACTIVITY))
 		_set_clockactivity(oh, oh->class->sysc->clockact, &v);
 
-	/* If the cached value is the same as the new value, skip the write */
-	if (oh->_sysc_cache != v)
-		_write_sysconfig(v, oh);
+	_write_sysconfig(v, oh);
 
 	/*
 	 * Set the autoidle bit only after setting the smartidle bit
@@ -1481,7 +1479,9 @@ static void _idle_sysc(struct omap_hwmod *oh)
 		_set_master_standbymode(oh, idlemode, &v);
 	}
 
-	_write_sysconfig(v, oh);
+	/* If the cached value is the same as the new value, skip the write */
+	if (oh->_sysc_cache != v)
+		_write_sysconfig(v, oh);
 }
 
 /**
-- 
2.7.0
