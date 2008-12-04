From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2 STI: fix build breakage
Date: Thu, 4 Dec 2008 15:29:49 -0800
Message-ID: <20081204232948.GI7054@atomide.com>
References: <alpine.DEB.2.00.0812010027440.31066@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53792 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbYLDX3v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 18:29:51 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0812010027440.31066@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, roman.tereshonkov@nokia.com, felipe.balbi@nokia.com

* Paul Walmsley <paul@pwsan.com> [081130 23:29]:
> 
> n800_defconfig no longer builds after commit
> 8423eaf634aa187e2ab3cd1018ea0f2f7d31148a; fix.
> 
>   CC      drivers/misc/sti/sti-netlink.o
> drivers/misc/sti/sti-netlink.c: In function 'sti_netlink_receive_msg':
> drivers/misc/sti/sti-netlink.c:84: error: expected expression before 'int'
> drivers/misc/sti/sti-netlink.c:91: error: 'len' undeclared (first use in this function)
> drivers/misc/sti/sti-netlink.c:91: error: (Each undeclared identifier is reported only once
> drivers/misc/sti/sti-netlink.c:91: error: for each function it appears in.)

Pushing today.

Tony


> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Roman Tereshenkov <roman.tereshonkov@nokia.com>
> Cc: Felipe Balbi <felipe.balbi@nokia.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/misc/sti/sti-netlink.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/sti/sti-netlink.c b/drivers/misc/sti/sti-netlink.c
> index b198e4c..dbd6a03 100644
> --- a/drivers/misc/sti/sti-netlink.c
> +++ b/drivers/misc/sti/sti-netlink.c
> @@ -68,7 +68,8 @@ static int sti_netlink_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  {
>  	void *data;
>  	u8 chan, id;
> -	int size, ret = 0;
> +	int size;
> +	int ret = 0, len = 0;
>  
>  	data	= NLMSG_DATA(nlh);
>  	chan	= (nlh->nlmsg_flags >> 8) & 0xff;
> @@ -81,8 +82,6 @@ static int sti_netlink_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  		break;
>  #if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2)
>  	case STI_READ:
> -		int len = 0;
> -
>  		data = kmalloc(size, GFP_KERNEL);
>  		if (!data)
>  			return -ENOMEM;
