From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] DSPGW: Fix build error with n800_defconfig
Date: Tue, 6 May 2008 15:13:46 -0700
Message-ID: <20080506221346.GH18682@atomide.com>
References: <1210070561-2275-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:57016 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761172AbYEFWNr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 18:13:47 -0400
Content-Disposition: inline
In-Reply-To: <1210070561-2275-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080506 03:43]:
> "3c18ddd160d1fcd46d1131d9ad6c594dd8e9af99" removed "->nopage()" from "vm_ops".
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  drivers/dsp/dspgateway/task.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dsp/dspgateway/task.c b/drivers/dsp/dspgateway/task.c
> index e5ee8e0..e3a0a02 100644
> --- a/drivers/dsp/dspgateway/task.c
> +++ b/drivers/dsp/dspgateway/task.c
> @@ -1311,16 +1311,15 @@ static void dsp_task_mmap_close(struct vm_area_struct *vma)
>   * On demand page allocation is not allowed. The mapping area is defined by
>   * corresponding DSP tasks.
>   */
> -static struct page *dsp_task_mmap_nopage(struct vm_area_struct *vma,
> -					 unsigned long address, int *type)
> +static int dsp_task_mmap_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
>  {
> -	return NOPAGE_SIGBUS;
> +	return VM_FAULT_NOPAGE;
>  }
>  
>  static struct vm_operations_struct dsp_task_vm_ops = {
>  	.open = dsp_task_mmap_open,
>  	.close = dsp_task_mmap_close,
> -	.nopage = dsp_task_mmap_nopage,
> +	.fault = dsp_task_mmap_fault,
>  };
>  
>  static int dsp_task_mmap(struct file *filp, struct vm_area_struct *vma)

Pushing.

Tony
