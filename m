From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] fix ipt_IDLETIMER.c compilation
Date: Tue, 8 May 2007 14:40:09 -0700
Message-ID: <20070508214008.GM32547@atomide.com>
References: <20070508210138.371687586@pwsan.com>
	<20070508210156.312789620@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070508210156.312789620@pwsan.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [070508 14:03]:
> Update net/ipv4/netfilter/ipt_IDLETIMER.c to compile after recent
> changes to include/linux/netdevice.h (commit
> 4e9cac2ba437fcb093c7417b1cd91a77ebd1756a).  Compile-tested only.
> 
>   CC      net/ipv4/netfilter/ipt_IDLETIMER.o
> net/ipv4/netfilter/ipt_IDLETIMER.c: In function 'utimer_notifier_call':
> net/ipv4/netfilter/ipt_IDLETIMER.c:189: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
> net/ipv4/netfilter/ipt_IDLETIMER.c: In function 'utimer_fini':
> net/ipv4/netfilter/ipt_IDLETIMER.c:222: error: 'dev_base' undeclared (first use in this function)
> net/ipv4/netfilter/ipt_IDLETIMER.c:222: error: (Each undeclared identifier is reported only once
> net/ipv4/netfilter/ipt_IDLETIMER.c:222: error: for each function it appears in.)
> net/ipv4/netfilter/ipt_IDLETIMER.c:222: error: 'struct net_device' has no member named 'next'
> make[3]: *** [net/ipv4/netfilter/ipt_IDLETIMER.o] Error 1
> 
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> ---
>  net/ipv4/netfilter/ipt_IDLETIMER.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-omap-2.6/net/ipv4/netfilter/ipt_IDLETIMER.c
> ===================================================================
> --- linux-omap-2.6.orig/net/ipv4/netfilter/ipt_IDLETIMER.c
> +++ linux-omap-2.6/net/ipv4/netfilter/ipt_IDLETIMER.c
> @@ -219,7 +219,7 @@ static void utimer_fini(void)
>  
>  	rtnl_lock();
>  	unregister_netdevice_notifier(&utimer_notifier_block);
> -	for (dev = dev_base; dev; dev = dev->next)
> +	for_each_netdev(dev)
>  		utimer_notifier_call(&utimer_notifier_block,
>  				     NETDEV_DOWN, dev);
>  	rtnl_unlock();
> 
> -- 

Pushing this one too.

Tony
