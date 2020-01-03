From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v4 0/4] Use ARM SMC Calling Convention when OP-TEE is
 available
Date: Fri, 3 Jan 2020 10:16:39 +0530
Message-ID: <4d45ed64-c3f5-4074-d95a-dd52f355a22b@ti.com>
References: <20200102211943.20480-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200102211943.20480-1-afd@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 03/01/20 2:49 AM, Andrew F. Davis wrote:
> Hello all,
> 
> This is the reworked patch turned into a series to allow upstream kernels
> to make use of OP-TEE on the OMAP2+ platform.

FWIW:

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

> 
> Thanks,
> Andrew
> 
> Changes from v1:
>  - Split into logical patches
>  - Check for OP-TEE in DT only once
>  - Check the OP-TEE node is "okay"
> 
> Changes from v2:
>  - Add HS patch using 'optee_available'
> 
> Changes from v3:
>  - Add comments as suggested by Tony and Lokesh
> 
> Andrew F. Davis (4):
>   ARM: OMAP2+: Add omap_secure_init callback hook for secure
>     initialization
>   ARM: OMAP2+: Introduce check for OP-TEE in omap_secure_init()
>   ARM: OMAP2+: Use ARM SMC Calling Convention when OP-TEE is available
>   ARM: OMAP2+: sleep43xx: Call secure suspend/resume handlers
> 
>  arch/arm/mach-omap2/common.h      |  2 +-
>  arch/arm/mach-omap2/io.c          | 11 +++++++
>  arch/arm/mach-omap2/omap-secure.c | 50 +++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap-secure.h | 10 +++++++
>  arch/arm/mach-omap2/omap-smc.S    |  6 ++--
>  arch/arm/mach-omap2/pm33xx-core.c | 24 +++++++++++++++
>  6 files changed, 99 insertions(+), 4 deletions(-)
> 
