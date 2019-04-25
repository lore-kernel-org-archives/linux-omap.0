From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next 16/19] net: ethernet: ti: cpsw: move common hw
 init code in separate func
Date: Thu, 25 Apr 2019 17:14:32 +0300
Message-ID: <0bec250e-7c16-4c5b-d56e-581e8d8ca46b@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-17-git-send-email-grygorii.strashko@ti.com>
 <71d13a87-a078-a49d-43b2-33beb19f0e46@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <71d13a87-a078-a49d-43b2-33beb19f0e46@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Murali Karicheri <m-karicheri2@ti.com>, netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 25.04.19 16:38, Murali Karicheri wrote:
> On 04/23/2019 09:09 AM, Grygorii Strashko wrote:
>> move common hw init code in separate function as preparation for adding new
>> switchdev driver.
> All of the changes indicates a better name for the file is cpsw_common.c; commit log,
 new function cpsw_init_common() etc. Any specific reason to use cpsw_priv.[ch]?

I've been thinking about this, but cpsw_coomon.c is used by davinici_emac also.
More over, I have a hope that it'd be possible to get rid of cpsw_common.c at all
by switching to nvmem.

Also, I'd be very appreciated if you'd be able to cut your replies.
It's a little bit hard to find your comments

> 
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   drivers/net/ethernet/ti/Makefile    |   2 +-
>>   drivers/net/ethernet/ti/cpsw.c      | 106 ++---------------------
>>   drivers/net/ethernet/ti/cpsw_priv.c | 128 ++++++++++++++++++++++++++++
>>   drivers/net/ethernet/ti/cpsw_priv.h |   3 +
>>   4 files changed, 137 insertions(+), 102 deletions(-)
>>   create mode 100644 drivers/net/ethernet/ti/cpsw_priv.c
>>
>> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
>> index 2f159a71f88e..de1561596646 100644
...

-- 
Best regards,
grygorii
