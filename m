From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: Re: build error on Linux-2.6.15-omap1
Date: Thu, 12 Jan 2006 20:29:04 +0900 (JST)
Message-ID: <20060112.202904.59649446.kaminaga@sm.sony.co.jp>
References: <20060112.135142.74755663.kaminaga@sm.sony.co.jp>
	<1137035283.11250.50.camel@pismo>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1137035283.11250.50.camel@pismo>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Craps@kristian-m.de
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

> I guess there must be something wrong with your patch since in
> linux-2.6.15-omap1 pm.c and Sleep.S are already in mach-omap1 
> 
> That is since 1st december last year:
> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=a57a89ee9ad70186e4f7be46e0930fcb8fb53bb6
> 

Oh!
It is fixed in source code management system!

However, I looked Linux-2.6.15-omap1 patch again, and it was as follows:

* * *

diff --git a/arch/arm/plat-omap/pm.c b/arch/arm/mach-omap1/pm.c
similarity index 83%
rename from arch/arm/plat-omap/pm.c
rename to arch/arm/mach-omap1/pm.c
index 1a24e2c..d483ac4 100644
--- a/arch/arm/plat-omap/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -40,22 +40,26 @@
 #include <linux/proc_fs.h>
 #include <linux/pm.h>
 #include <linux/interrupt.h>
+#include <linux/sysfs.h>
+#include <linux/module.h>
... 

* * *

the `+++' part is mach-omap1, but `---' part was plat-omap, and
after patching, pm.c was still in plat-omap...

I'm using FC3 as host, diff version 2.8.1, patch version 2.5.4, 
I guess `rename from' and `rename to' line didn't do what is intended?!


# Or I'm downloading different file? I downloaded:
# http://www.muru.com/linux/omap/ -> Linux-2.6.15-omap1


Best Regards,

HK.
--
