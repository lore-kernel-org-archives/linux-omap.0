From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 0/5] Minor ti-sysc cleanups
Date: Mon, 1 Jul 2019 10:18:09 +0300
Message-ID: <f4b63a80-560e-377c-0e4e-5b8711990747@ti.com>
References: <20190625233315.22301-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625233315.22301-1-s-anna@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 26/06/2019 02:33, Suman Anna wrote:
> Hi Tony,
> 
> The following series includes minor cleanup patches against the ti-sysc
> code. Patches are based on top of all your 5.3 staged branches. Feel free
> to pick them up for either 5.3 (if it is not too late) or 5.4 merge window. 
> 
> The first 4 patches are non-coding changes, and the last patch is a minor
> fixup cleaning up the code flow on failure error paths in sysc_probe()
> function. I have boot tested on the limited boards that I have - AM335x
> BeagleBone Black, AM437x IDK, AM57xx GP EVM, OMAP4 PandaBoard and OMAP5
> uEVM.
> 
> regards
> Suman
> 
> Suman Anna (5):
>   MAINTAINERS: Add ti-sysc files under the OMAP2+ entry
>   dt-bindings: ti-sysc: Add SPDX license identifier
>   bus: ti-sysc: Switch to SPDX license identifier
>   bus: ti-sysc: Add missing kerneldoc comments
>   bus: ti-sysc: Simplify cleanup upon failures in sysc_probe()

For all patches.

Acked-by: Roger Quadros <rogerq@ti.com>

> 
>  MAINTAINERS                           |  2 ++
>  drivers/bus/ti-sysc.c                 | 31 +++++++++++++--------------
>  include/dt-bindings/bus/ti-sysc.h     |  1 +
>  include/linux/platform_data/ti-sysc.h |  7 ++++--
>  4 files changed, 23 insertions(+), 18 deletions(-)
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
