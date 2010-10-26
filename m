From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 0/8] staging: tidspbridge - misc fixes
Date: Mon, 25 Oct 2010 21:06:19 -0700
Message-ID: <20101026040619.GA8549@suse.de>
References: <1288054306-4361-1-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1288054306-4361-1-git-send-email-x0095840@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fernando Guzman Lugo <x0095840@ti.com>
Cc: felipe.contreras@nokia.com, Hiroshi.DOYU@nokia.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 25, 2010 at 07:51:38PM -0500, Fernando Guzman Lugo wrote:
> This set of patches fix some issues found in lastest tree.
> 
> Fernando Guzman Lugo (8):
>   staging: tidspbridge - remove req_addr from proc_map
>   staging: tidspbridge - add kconfig parameter for DMM size
>   staging: tidspbridge - change mmufault tasklet to a workqueue
>   staging: tidspbridge - fix timeout in dsp_gpt_wait_overflow
>   staging: tidspbridge - use GTP7 for DSP stack dump
>   staging: tidspbridge - remove disabling twl when printing DSP stack
>   staging: tidspbridge - fix some issues after iommu patches
>   staging: tidspbridge - make sync_wait_on_event interruptible

Are any of these really applicable for .37 after .37-rc1?  Or can they
wait for .38?

thanks,

greg k-h
