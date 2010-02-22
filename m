From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: Dereference of NULL autodep in _autodep_lookup()
Date: Mon, 22 Feb 2010 14:06:26 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002221357280.2701@utopia.booyaka.com>
References: <4B781E05.9040502@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B781E05.9040502@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Roel,

On Sun, 14 Feb 2010, Roel Kluin wrote:

> Don't dereference autodep when it's NULL. In _autodep_lookup() an
> ERR_PTR(-ENOENT) is assigned to autodep->pwrdm.ptr if pwrdm_lookup() fails.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Thanks for the patch, but I don't understand what problem you're
pointing out.  If autodeps is NULL entering clkdm_init(), then the
for-loop won't even be entered.

It looks like there may be a problem, however, in _clkdm_add_autodeps() 
and _clkdm_del_autodeps() if no autodeps were passed in.  What do you 
think about something like the following instead?


- Paul


From: Paul Walmsley <paul@pwsan.com>
Date: Mon, 22 Feb 2010 14:01:45 -0700
Subject: [PATCH] OMAP clockdomain: if no autodeps exist, don't try to add or remove them

_clkdm_add_autodeps() and _clkdm_del_autodeps() will attempt to dereference
a NULL pointer if no autodeps were supplied to clkdm_init().

Based on a patch from Roel Kluin <roel.kluin@gmail.com> - thanks Roel.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Roel Kluin <roel.kluin@gmail.com>
---
 arch/arm/mach-omap2/clockdomain.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index de4278c..b26d30a 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -173,6 +173,9 @@ static void _clkdm_add_autodeps(struct clockdomain *clkdm)
 {
 	struct clkdm_autodep *autodep;
 
+	if (!autodeps)
+		return;
+
 	for (autodep = autodeps; autodep->clkdm.ptr; autodep++) {
 		if (IS_ERR(autodep->clkdm.ptr))
 			continue;
@@ -201,6 +204,9 @@ static void _clkdm_del_autodeps(struct clockdomain *clkdm)
 {
 	struct clkdm_autodep *autodep;
 
+	if (!autodeps)
+		return;
+
 	for (autodep = autodeps; autodep->clkdm.ptr; autodep++) {
 		if (IS_ERR(autodep->clkdm.ptr))
 			continue;
-- 
1.6.6.GIT
