From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] SDTI: Add netlink support for debug message output.
Date: Tue, 18 Nov 2008 15:26:44 +0200
Message-ID: <20081118132644.GX20808@gandalf.research.nokia.com>
References: <1225280368-24257-1-git-send-email-roman.tereshonkov@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:52929 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbYKRN1E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2008 08:27:04 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAIDQwAY018428
	for <linux-omap@vger.kernel.org>; Tue, 18 Nov 2008 07:27:02 -0600
Content-Disposition: inline
In-Reply-To: <1225280368-24257-1-git-send-email-roman.tereshonkov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Roman Tereshonkov <roman.tereshonkov@nokia.com>
Cc: linux-omap@vger.kernel.org

On Wed, Oct 29, 2008 at 01:39:28PM +0200, Tereshonkov Roman wrote:
> Add support for user to use netlink for message output to XTI.
> Add autoidle feature if SDTI is not used.
> 
> Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

> ---
>  drivers/misc/sti/Makefile      |    2 +-
>  drivers/misc/sti/sdti.c        |   14 ++++++++++----
>  drivers/misc/sti/sti-netlink.c |    8 +++++++-
>  3 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/sti/Makefile b/drivers/misc/sti/Makefile
> index aee30bd..43574d1 100644
> --- a/drivers/misc/sti/Makefile
> +++ b/drivers/misc/sti/Makefile
> @@ -2,7 +2,7 @@ ifeq ($(CONFIG_ARCH_OMAP3),y)
>  obj-$(CONFIG_OMAP_STI)	+= sdti.o
>  else
>  obj-$(CONFIG_OMAP_STI)	+= sti.o sti-fifo.o
> -obj-$(CONFIG_NET)	+= sti-netlink.o
>  endif
>  
> +obj-$(CONFIG_NET)	+= sti-netlink.o
>  obj-$(CONFIG_OMAP_STI_CONSOLE)	+= sti-console.o
> diff --git a/drivers/misc/sti/sdti.c b/drivers/misc/sti/sdti.c
> index 4514783..92ce57b 100644
> --- a/drivers/misc/sti/sdti.c
> +++ b/drivers/misc/sti/sdti.c
> @@ -31,11 +31,14 @@
>  #define CPU1_TRACE_EN		0x01
>  #define CPU2_TRACE_EN		0x02
>  
> +#define SDTI_SYSCONFIG_SOFTRESET	(1 << 1)
> +#define SDTI_SYSCONFIG_AUTOIDLE		(1 << 0)
> +
>  static struct clk *sdti_ck;
>  void __iomem *sti_base, *sti_channel_base;
>  static DEFINE_SPINLOCK(sdti_lock);
>  
> -void omap_sti_channel_write_trace(int len, int id, void *data,
> +void sti_channel_write_trace(int len, int id, void *data,
>  				unsigned int channel)
>  {
>  	const u8 *tpntr = data;
> @@ -49,13 +52,13 @@ void omap_sti_channel_write_trace(int len, int id, void *data,
>  
>  	spin_unlock_irq(&sdti_lock);
>  }
> -EXPORT_SYMBOL(omap_sti_channel_write_trace);
> +EXPORT_SYMBOL(sti_channel_write_trace);
>  
>  static void omap_sdti_reset(void)
>  {
>  	int i;
>  
> -	sti_writel(0x02, SDTI_SYSCONFIG);
> +	sti_writel(SDTI_SYSCONFIG_SOFTRESET, SDTI_SYSCONFIG);
>  
>  	for (i = 0; i < 10000; i++)
>  		if (sti_readl(SDTI_SYSSTATUS) & 1)
> @@ -79,6 +82,9 @@ static int __init omap_sdti_init(void)
>  	omap_sdti_reset();
>  	sti_writel(0xC5ACCE55, SDTI_LOCK_ACCESS);
>  
> +	/* Autoidle */
> +	sti_writel(SDTI_SYSCONFIG_AUTOIDLE, SDTI_SYSCONFIG);
> +
>  	/* Claim SDTI */
>  	sti_writel(1 << 30, SDTI_WINCTRL);
>  	i = sti_readl(SDTI_WINCTRL);
> @@ -99,7 +105,7 @@ static int __init omap_sdti_init(void)
>  	snprintf(buf, sizeof(buf), "OMAP SDTI support loaded (HW v%u.%u)\n",
>  		(i >> 4) & 0x0f, i & 0x0f);
>  	printk(KERN_INFO "%s", buf);
> -	omap_sti_channel_write_trace(strlen(buf), 0xc3, buf, 239);
> +	sti_channel_write_trace(strlen(buf), 0xc3, buf, 239);
>  
>  	return 0;
>  }
> diff --git a/drivers/misc/sti/sti-netlink.c b/drivers/misc/sti/sti-netlink.c
> index f1f8a48..b198e4c 100644
> --- a/drivers/misc/sti/sti-netlink.c
> +++ b/drivers/misc/sti/sti-netlink.c
> @@ -25,6 +25,7 @@ enum {
>  	STI_WRITE,
>  };
>  
> +#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2)
>  static int sti_netlink_read(int pid, int seq, void *payload, int size)
>  {
>  	struct sk_buff *skb;
> @@ -55,6 +56,7 @@ nlmsg_failure:
>  
>  	return -EINVAL;
>  }
> +#endif
>  
>  /*
>   * We abuse nlmsg_type and nlmsg_flags for our purposes.
> @@ -66,7 +68,7 @@ static int sti_netlink_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  {
>  	void *data;
>  	u8 chan, id;
> -	int size, ret = 0, len = 0;
> +	int size, ret = 0;
>  
>  	data	= NLMSG_DATA(nlh);
>  	chan	= (nlh->nlmsg_flags >> 8) & 0xff;
> @@ -77,7 +79,10 @@ static int sti_netlink_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  	case STI_WRITE:
>  		sti_channel_write_trace(size, id, data, chan);
>  		break;
> +#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2)
>  	case STI_READ:
> +		int len = 0;
> +
>  		data = kmalloc(size, GFP_KERNEL);
>  		if (!data)
>  			return -ENOMEM;
> @@ -88,6 +93,7 @@ static int sti_netlink_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  				       data, len);
>  		kfree(data);
>  		break;
> +#endif
>  	default:
>  		return -ENOTTY;
>  	}
> -- 
> 1.5.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
