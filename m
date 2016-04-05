From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 14/20] mfd: rt5033: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Tue, 5 Apr 2016 08:54:30 -0400
Message-ID: <5703B586.4050407@osg.samsung.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
 <1459856912-17859-15-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-15-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org, corbet@lwn.net
Cc: andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Ingi Kim <ingi2.kim@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hello Laxman,

On 04/05/2016 07:48 AM, Laxman Dewangan wrote:
> Use devm_mfd_add_devices() for mfd devices registration and get
> rid of .remove callback to remove mfd devices. This is done
> by managed device framework.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Ingi Kim <ingi2.kim@samsung.com>
> CC: Javier Martinez Canillas <javier@osg.samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
