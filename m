From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 net-next] drivers: net: davinci_mdio: prevent spurious
 timeout
Date: Wed, 9 May 2018 21:16:02 +0530
Message-ID: <a0dc652f-d115-9eff-00ad-1d6efffee8a3@ti.com>
References: <20180509110024.1772-1-nsekhar@ti.com>
 <20180509133014.GD14276@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180509133014.GD14276@lunn.ch>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 09 May 2018 07:00 PM, Andrew Lunn wrote:
> On Wed, May 09, 2018 at 04:30:24PM +0530, Sekhar Nori wrote:
>> A well timed kernel preemption in the time_after() loop
>> in wait_for_idle() can result in a spurious timeout
>> error to be returned.
>>
>> Fix it by using readl_poll_timeout() which takes care of
>> this issue.
>>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>> v2: use readl_poll_timeout() per suggestion from Andrew.
>>
>> The issue has not been personally observed by me, but has
>> been reported by users. Sending for next-next given the
>> non-critical nature. There is seems to be no easy way to
>> reproduce this.
>>
>>  drivers/net/ethernet/ti/davinci_mdio.c | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
>> index 3c33f4504d8e..d073432a5dbe 100644
>> --- a/drivers/net/ethernet/ti/davinci_mdio.c
>> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
>> @@ -34,6 +34,7 @@
>>  #include <linux/clk.h>
>>  #include <linux/err.h>
>>  #include <linux/io.h>
>> +#include <linux/iopoll.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/davinci_emac.h>
>>  #include <linux/of.h>
>> @@ -227,14 +228,16 @@ static inline int wait_for_user_access(struct davinci_mdio_data *data)
>>  static inline int wait_for_idle(struct davinci_mdio_data *data)
>>  {
>>  	struct davinci_mdio_regs __iomem *regs = data->regs;
>> -	unsigned long timeout = jiffies + msecs_to_jiffies(MDIO_TIMEOUT);
>> +	u32 val, ret;
>>  
>> -	while (time_after(timeout, jiffies)) {
>> -		if (__raw_readl(&regs->control) & CONTROL_IDLE)
>> -			return 0;
>> +	ret = readl_poll_timeout(&regs->control, val, val & CONTROL_IDLE,
>> +				 0, MDIO_TIMEOUT * 1000);
>> +	if (ret) {
>> +		dev_err(data->dev, "timed out waiting for idle\n");
>> +		return ret;
>>  	}
>> -	dev_err(data->dev, "timed out waiting for idle\n");
>> -	return -ETIMEDOUT;
>> +
>> +	return 0;
>>  }
> 
> Hi Sekhar
> 
> You could simplify this to:
> 
>> +	if (ret)
>> +		dev_err(data->dev, "timed out waiting for idle\n");
>> +	return ret;
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Indeed. v3 sent.

Thanks,
Sekhar
