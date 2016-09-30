From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH 1/4] mfd: ti_am335x_tscadc: store physical address
Date: Fri, 30 Sep 2016 14:13:16 +0530
Message-ID: <f271b805-82c2-a45e-0de9-39edafd34d2e@ti.com>
References: <20160921161134.6951-1-mugunthanvnm@ti.com>
 <20160921161134.6951-2-mugunthanvnm@ti.com> <20160927194045.GK21388@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160927194045.GK21388@dell>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Vignesh R <vigneshr@ti.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, "Andrew F
 . Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, linux-omap@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 28 September 2016 01:10 AM, Lee Jones wrote:
> On Wed, 21 Sep 2016, Mugunthan V N wrote:
> 
>> store the physical address of the device in its priv to use it
>> for DMA addressing in the client drivers.
>>
>> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
>> ---
>>  drivers/mfd/ti_am335x_tscadc.c       | 1 +
>>  include/linux/mfd/ti_am335x_tscadc.h | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
>> index c8f027b..0f3fab4 100644
>> --- a/drivers/mfd/ti_am335x_tscadc.c
>> +++ b/drivers/mfd/ti_am335x_tscadc.c
>> @@ -183,6 +183,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>>  		tscadc->irq = err;
>>  
>>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	tscadc->tscadc_phys_base = res->start;
> 
> This is unusual.  Can't you use a virt_to_phys() variant instead?
> 

I tried using virt_to_phys(), but its not working for me.
Also saw many drivers uses like this to get physical address
("git grep -n " res->start;" drivers/*").

Regards
Mugunthan V N
