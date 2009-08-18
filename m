From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 01/11] OMAP: powerdomain: Fix overflow when doing powerdomain
	deps lookups.
Date: Tue, 18 Aug 2009 14:56:21 +0300
Message-ID: <20090818115616.14171.74181.stgit@localhost.localdomain>
References: <20090818115147.14171.55785.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090818115147.14171.55785.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Chan <mike-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

At the end of the list pd is a pointer to a NULL struct, so checking
if the address == NULL doesn't help here. In fact the original code
will just keep running past the struct to read who knows what in
memory.

This case manifests itself when from clkdms_setup() when enabling auto
idle for a clock domain and the clockdomain usecount is greater than
0. When _clkdm_add_autodeps() tries to add the a dependency that does
not exist in the powerdomain->wkdep_srcs array the for loop will run
past the wkdep_srcs array.

Currently in linux-omap you won't hit this because the not found case
is never executed, unless you start modifying powerdomains and their
wakeup/sleep deps.

Signed-off-by: Mike Chan <mike-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-omap2/powerdomain.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 983f1cb..66206b6 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -83,7 +83,7 @@ static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrdm,
 	if (!pwrdm || !deps || !omap_chip_is(pwrdm->omap_chip))
 		return ERR_PTR(-EINVAL);
 
-	for (pd = deps; pd; pd++) {
+	for (pd = deps; pd->pwrdm_name; pd++) {
 
 		if (!omap_chip_is(pd->omap_chip))
 			continue;
@@ -96,7 +96,7 @@ static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrdm,
 
 	}
 
-	if (!pd)
+	if (!pd->pwrdm_name)
 		return ERR_PTR(-ENOENT);
 
 	return pd->pwrdm;


--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
