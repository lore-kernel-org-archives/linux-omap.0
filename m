From: Greg KH <greg@kroah.com>
Subject: Re: [RFC v2 5/8] TILER-DMM: TILER interface file and documentation
Date: Tue, 30 Nov 2010 16:53:32 -0800
Message-ID: <20101201005332.GA29171@kroah.com>
References: <1291147139-23472-1-git-send-email-davidsin@ti.com>
 <1291147139-23472-6-git-send-email-davidsin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1291147139-23472-6-git-send-email-davidsin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Sin <davidsin@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lajos Molnar <molnar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 30, 2010 at 01:58:56PM -0600, David Sin wrote:
> From: Lajos Molnar <molnar@ti.com>
> 
> This patch contains the TILER interface file and the documentation.
> 
> Signed-off-by: Lajos Molnar <molnar@ti.com>
> Signed-off-by: David Sin <davidsin@ti.com>
> ---
>  Documentation/arm/OMAP/TILER             |  126 ++++++++++++++++++++++
>  arch/arm/mach-omap2/include/mach/tiler.h |  173 ++++++++++++++++++++++++++++++

Shouldn't this .h file be in include/linux/ instead?  Why is it arch
specific?

thanks,

greg k-h
