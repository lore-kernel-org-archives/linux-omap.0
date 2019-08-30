From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 03/11] soc: ti: omap-prm: poll for reset complete during
 de-assert
Date: Fri, 30 Aug 2019 12:07:07 +0300
Message-ID: <ceed701f-481c-4905-727e-ba3af2cf8ff2@ti.com>
References: <20190828071941.32378-1-t-kristo@ti.com>
 <20190828071941.32378-4-t-kristo@ti.com>
 <1567084467.5345.9.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1567084467.5345.9.camel@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Philipp Zabel <p.zabel@pengutronix.de>, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, robh+dt@kernel.org
Cc: tony@atomide.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 29/08/2019 16:14, Philipp Zabel wrote:
> Hi Tero,
> 
> On Wed, 2019-08-28 at 10:19 +0300, Tero Kristo wrote:
>> Poll for reset completion status during de-assertion of reset, otherwise
>> the IP in question might be accessed before it has left reset properly.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/soc/ti/omap_prm.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
>> index fd5c431f8736..afeb70761b27 100644
>> --- a/drivers/soc/ti/omap_prm.c
>> +++ b/drivers/soc/ti/omap_prm.c
>> @@ -127,6 +127,7 @@ static int omap_reset_deassert(struct reset_controller_dev *rcdev,
>>   	u32 v;
>>   	int st_bit;
>>   	bool has_rstst;
>> +	int timeout = 0;
>>   
>>   	if (!_is_valid_reset(reset, id))
>>   		return -EINVAL;
>> @@ -153,6 +154,25 @@ static int omap_reset_deassert(struct reset_controller_dev *rcdev,
>>   	v &= ~(1 << id);
>>   	writel_relaxed(v, reset->prm->base + reset->prm->data->rstctrl);
>>   
>> +	if (!has_rstst)
>> +		return 0;
>> +
>> +	/* wait for the status to be set */
>> +	while (1) {
>> +		v = readl_relaxed(reset->prm->base + reset->prm->data->rstst);
>> +		v &= 1 << st_bit;
>> +		if (v)
>> +			break;
>> +		timeout++;
>> +		if (timeout > OMAP_RESET_MAX_WAIT) {
>> +			pr_err("%s: timedout waiting for %s:%lu\n", __func__,
>> +			       dev_name(rcdev->dev), id);
>> +			return -EBUSY;
>> +		}
>> +
>> +		udelay(1);
>> +	}
> 
> This looks like you could use
> 
> 	readl_relaxed_poll_timeout(_atomic)

Yeah true, let me change that.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
