From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/10] OMAP: iommu: add initial debugfs support
Date: Fri, 28 Aug 2009 11:24:00 -0700
Message-ID: <20090828182400.GO25828@atomide.com>
References: <20090816151347.GZ7278@atomide.com> <20090816204732.GA23875@n2100.arm.linux.org.uk> <20090817.102805.48505615.Hiroshi.DOYU@nokia.com> <20090827.102539.246514996.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52267 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbZH1SYJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 14:24:09 -0400
Content-Disposition: inline
In-Reply-To: <20090827.102539.246514996.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, linux@arm.linux.org.uk

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [090827 00:26]:
> Hi Tony,
> 
> I fixed the error exit path as below and attached the updated verion
> of the patch. Please replace the old one in for-next with the attached
> one.

OK will update.

Tony

> 	Modified arch/arm/plat-omap/iommu-debug.c
> diff --git a/arch/arm/plat-omap/iommu-debug.c b/arch/arm/plat-omap/iommu-debug.c
> index 5a7e409..c799b3b 100644
> --- a/arch/arm/plat-omap/iommu-debug.c
> +++ b/arch/arm/plat-omap/iommu-debug.c
> @@ -268,14 +268,14 @@ static ssize_t debug_read_mem(struct file *file, char __user *userbuf,
>  
>  	area = find_iovm_area(obj, (u32)ppos);
>  	if (IS_ERR(area)) {
> -		mutex_unlock(&iommu_debug_lock);
> -		return -EINVAL;
> +		bytes = -EINVAL;
> +		goto err_out;
>  	}
>  	memcpy(p, area->va, count);
>  	p += count;
>  
>  	bytes = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
> -
> +err_out:
>  	mutex_unlock(&iommu_debug_lock);
>  	free_page((unsigned long)buf);
>  
> @@ -299,17 +299,17 @@ static ssize_t debug_write_mem(struct file *file, const char __user *userbuf,
>  	mutex_lock(&iommu_debug_lock);
>  
>  	if (copy_from_user(p, userbuf, count)) {
> -		mutex_unlock(&iommu_debug_lock);
> -		return -EFAULT;
> +		count =  -EFAULT;
> +		goto err_out;
>  	}
>  
>  	area = find_iovm_area(obj, (u32)ppos);
>  	if (IS_ERR(area)) {
> -		mutex_unlock(&iommu_debug_lock);
> -		return -EINVAL;
> +		count = -EINVAL;
> +		goto err_out;
>  	}
>  	memcpy(area->va, p, count);
> -
> +err_out:
>  	mutex_unlock(&iommu_debug_lock);
>  	free_page((unsigned long)buf);
>  


