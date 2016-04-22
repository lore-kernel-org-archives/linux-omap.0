From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 2/7] mfd: lp8788: Use devm_mfd_add_devices and devm_regmap_add_irq_chip
Date: Fri, 22 Apr 2016 14:20:36 +0530
Message-ID: <5719E5DC.8040305@nvidia.com>
References: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com> <1461241558-26983-3-git-send-email-ldewangan@nvidia.com> <57195F1A.7070506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <57195F1A.7070506@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Kim, Milo" <milo.kim@ti.com>, k.kozlowski@samsung.com
Cc: lee.jones@linaro.org, cw00.choi@samsung.com, sbkim73@samsung.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On Friday 22 April 2016 04:45 AM, Kim, Milo wrote:
> Hi Laxman,
>
> On 4/21/2016 9:25 PM, Laxman Dewangan wrote:
>> Use devm_mfd_add_devices() for adding MFD child devices and
>> devm_regmap_add_irq_chip() for IRQ chip registration.
>
> This patch doesn't include the code regarding devm_mfd_add_devices(). 
> Could you check it again? Or am I missing any previous patches?


Sigh.. yaah, it is missed. Dont know how I missed it in my grep result.
I will recycle the patch. But I like to get review other patches also 
for V2. External code review is more stronger then self code review.
