From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: OMAP1 realtime patch
Date: Thu, 08 Feb 2007 16:01:59 +0100
Message-ID: <45CB3B67.3090907@googlemail.com>
References: <45C785A4.6080007@googlemail.com>
	<1170882015.11368.25.camel@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1170882015.11368.25.camel@vence.hilman.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Kevin Hilman wrote:
> On Mon, 2007-02-05 at 20:29 +0100, Dirk Behme wrote:
> 
>>For everybody interested please find in attachment my OMAP1
>>realtime patch.
>  
> Was there a reason for the raw_spinlock conversions? 

Not really ;)

> Did you run into
> specific issues for converting those?  

There was this ethernet/irq/gpio issue we fixed with 
workaround in kernel/irq/manage.c. Until we had this the 
root cause was unclear so a lot of raw_spinlock to be on the 
safe side for debugging. Then, I posted my patch to have a 
starting point people can try and improve, as you did :)

> Here is a patch which leaves out the raw_spinlock conversions.  It goes
> on the OMAP git tree on top of -rt5 (ignoring conflicts.)  I've left out
> all the raw_spinlock conversions.  This has been tested on an
> OMAP1623/H2 platform.

Many thanks for the update!

> Index: dev/kernel/printk.c
> ===================================================================
> --- dev.orig/kernel/printk.c
> +++ dev/kernel/printk.c
> @@ -464,6 +464,7 @@ static void zap_locks(void)
>  	spin_lock_init(&logbuf_lock);
>  	/* And make sure that we print immediately */
>  	init_MUTEX(&console_sem);
> +	zap_rt_locks();
>  }

What's this?

Btw: You removed the HRTIMER_MODE_REL and enum 
hrtimer_restart changes in 
drivers/input/touchscreen/ads7846.c as well?

Cheers

Dirk
