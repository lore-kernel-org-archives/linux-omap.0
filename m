From: Andreas Werner <andreas.werner@men.de>
Subject: Re: [PATCH 09/20] mfd: menf21bmc: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Tue, 5 Apr 2016 15:00:30 +0200
Message-ID: <20160405130030.GA25674@awelinux>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
 <1459856912-17859-10-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459856912-17859-10-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: lee.jones@linaro.org, corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 05, 2016 at 05:18:21PM +0530, Laxman Dewangan wrote:
> Use devm_mfd_add_devices() for mfd devices registration and get
> rid of .remove callback to remove mfd devices. This is done
> by managed device framework.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Andreas Werner <andreas.werner@men.de>
> ---

Thanks for the Patch, looks good to me.

Reviewed-by: Andreas Werner <andreas.werner@men.de>
