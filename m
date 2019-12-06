From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 0/2] net: ethernet: ti: cpsw_switchdev: fix unmet direct
 dependencies detected for NET_SWITCHDEV
Date: Fri, 6 Dec 2019 13:04:58 +0200
Message-ID: <393acd95-7556-3d68-4e44-b940a7e9bfc8@ti.com>
References: <20191204174533.32207-1-grygorii.strashko@ti.com>
 <20191205.143944.1644239054512253859.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191205.143944.1644239054512253859.davem@davemloft.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: rdunlap@infradead.org, netdev@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 06/12/2019 00:39, David Miller wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> Date: Wed, 4 Dec 2019 19:45:31 +0200
> 
>> This series fixes Kconfig warning with CONFIG_COMPILE_TEST=y reported by
>> Randy Dunlap <rdunlap@infradead.org> [1]
>>
>> [1] https://lkml.org/lkml/2019/12/3/1373
> 
> I applied patch #1 to the networking tree, the defconfig update has to be routed via
> the appropriate architecture tree.
  
Thank you.
  

-- 
Best regards,
grygorii
