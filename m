From: Tony Lindgren <tony@atomide.com>
Subject: Re: build error on Linux-2.6.15-omap1
Date: Thu, 12 Jan 2006 14:43:50 -0800
Message-ID: <20060112224350.GJ5461@atomide.com>
References: <20060112.135142.74755663.kaminaga@sm.sony.co.jp>
	<1137035283.11250.50.camel@pismo>
	<20060112.202904.59649446.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060112.202904.59649446.kaminaga@sm.sony.co.jp>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Cc: linux-omap-open-source@linux.omap.com, Craps@kristian-m.de
List-Id: linux-omap@vger.kernel.org

* Hiroki Kaminaga <kaminaga@sm.sony.co.jp> [060112 03:36]:
> Hi,
> 
> > I guess there must be something wrong with your patch since in
> > linux-2.6.15-omap1 pm.c and Sleep.S are already in mach-omap1 
> > 
> > That is since 1st december last year:
> > http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=a57a89ee9ad70186e4f7be46e0930fcb8fb53bb6
> > 
> 
> Oh!
> It is fixed in source code management system!
> 
> However, I looked Linux-2.6.15-omap1 patch again, and it was as follows:
> 
> * * *
> 
> diff --git a/arch/arm/plat-omap/pm.c b/arch/arm/mach-omap1/pm.c
> similarity index 83%
> rename from arch/arm/plat-omap/pm.c
> rename to arch/arm/mach-omap1/pm.c
> index 1a24e2c..d483ac4 100644
> --- a/arch/arm/plat-omap/pm.c
> +++ b/arch/arm/mach-omap1/pm.c
> @@ -40,22 +40,26 @@
>  #include <linux/proc_fs.h>
>  #include <linux/pm.h>
>  #include <linux/interrupt.h>
> +#include <linux/sysfs.h>
> +#include <linux/module.h>
> ... 
> 
> * * *
> 
> the `+++' part is mach-omap1, but `---' part was plat-omap, and
> after patching, pm.c was still in plat-omap...
> 
> I'm using FC3 as host, diff version 2.8.1, patch version 2.5.4, 
> I guess `rename from' and `rename to' line didn't do what is intended?!

Ah, thanks for catching it! This sounds like a bug in git. I've been
using this to generate the patch:

$ git diff 88026842b0a760145aa71d69e74fbc9ec118ca44..165e0bcd61404f0418fc70f07a6a23124fa0d206 
 
> # Or I'm downloading different file? I downloaded:
> # http://www.muru.com/linux/omap/ -> Linux-2.6.15-omap1

No that's right. I'll produce 2.6.15-omap2 patch soon and will fix it in
the patch.

Regards,

Tony
