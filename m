From: keerthy <j-keerthy@ti.com>
Subject: Re: [RESEND PATCH v2 3/3] regulator: lp87565: Add 4-phase lp87561
 regulator support
Date: Thu, 13 Jun 2019 22:32:45 +0530
Message-ID: <bfb19336-fbe9-06d8-25d3-f2e0b8ea6c9b@ti.com>
References: <20190612144620.28331-1-j-keerthy@ti.com>
 <20190613154552.GL5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190613154552.GL5316@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On 6/13/2019 9:15 PM, Mark Brown wrote:
> On Wed, Jun 12, 2019 at 08:16:20PM +0530, Keerthy wrote:
> 
>> patches 1/3 2/3 are already applied to linux-next.
> 
> This doesn't build without those patches:

They are already on next. Do you want me to resend them as well?

> 
>    CC      drivers/regulator/lp87565-regulator.o
> drivers/regulator/lp87565-regulator.c:156:32: error: ‘LP87565_BUCK_3210’ undeclared here (not in a function); did you mean ‘LP87565_BUCK_10’?
>    LP87565_REGULATOR("BUCK3210", LP87565_BUCK_3210, "buck3210",
>                                  ^~~~~~~~~~~~~~~~~
> 
