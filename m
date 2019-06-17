From: Keerthy <j-keerthy@ti.com>
Subject: Re: [GIT PULL] Immutable branch between MFD and Regulator due for the
 v5.3 merge window
Date: Mon, 17 Jun 2019 12:45:48 +0530
Message-ID: <2a3240e2-75f5-ef87-8fa7-0162a84fb590@ti.com>
References: <20190612144620.28331-1-j-keerthy@ti.com>
 <20190617070341.GC16364@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190617070341.GC16364@dell>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On 17/06/19 12:33 PM, Lee Jones wrote:
> Enjoy!
> 
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>    Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-regulator-v5.3
> 
> for you to fetch changes up to 7ee63bd74750a2c6fac31805ca0ac67f2522bfa5:
> 
>    regulator: lp87565: Add 4-phase lp87561 regulator support (2019-06-17 08:00:24 +0100)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD and Regulator due for the v5.3 merge window
> 
> ----------------------------------------------------------------
> Keerthy (3):
>        dt-bindings: mfd: lp87565: Add LP87561 configuration
>        mfd: lp87565: Add support for 4-phase LP87561 combination
>        regulator: lp87565: Add 4-phase lp87561 regulator support

Thanks Lee Jones.

> 
>   Documentation/devicetree/bindings/mfd/lp87565.txt | 36 +++++++++++++++++++++++
>   drivers/mfd/lp87565.c                             |  4 +++
>   drivers/regulator/lp87565-regulator.c             | 17 ++++++++++-
>   include/linux/mfd/lp87565.h                       |  2 ++
>   4 files changed, 58 insertions(+), 1 deletion(-)
> 
