From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next 05/19] net: ethernet: ti: cpsw: use local var dev
 in probe
Date: Wed, 24 Apr 2019 12:20:12 +0300
Message-ID: <609549ef-a283-4b3e-db8f-eb64660f7340@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-6-git-send-email-grygorii.strashko@ti.com>
 <20190423184015.GD28405@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423184015.GD28405@lunn.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-omap@vger.kernel.org



On 23.04.19 21:40, Andrew Lunn wrote:
>> On Tue, Apr 23, 2019 at 04:08:56PM +0300, Grygorii Strashko wrote:
>> Use local variable struct device *dev in probe to simplify code.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>  drivers/net/ethernet/ti/cpsw.c | 65 +++++++++++++++++-----------------
>>  1 file changed, 33 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>> index 13a339c64892..0b8cc4e6d9cd 100644
>> --- a/drivers/net/ethernet/ti/cpsw.c
>> +++ b/drivers/net/ethernet/ti/cpsw.c
>> @@ -3458,6 +3458,7 @@ static const struct soc_device_attribute cpsw_soc_devices[] = {
>>  
>>  static int cpsw_probe(struct platform_device *pdev)
>>  {
>> +	struct device *dev = &pdev->dev;
>>  	struct clk			*clk;
>>  	struct cpsw_platform_data	*data;
>>  	struct net_device		*ndev;
> 
> It seems odd not to keep with the column layout?
> Plus it would make it reverse Christmas tree.

It's has never been optimized for Christmas tree and
I'll keep cur layout for now.

-- 
Best regards,
grygorii
