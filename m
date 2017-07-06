From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v2 5/5] ARM: OMAP2+: Create dummy platform_device for
 pm33xx
Date: Thu, 6 Jul 2017 14:08:42 -0500
Message-ID: <931417b7-d080-3877-252a-a5d39706dfb3@ti.com>
References: <20170519200438.9502-1-d-gerlach@ti.com>
 <20170519200438.9502-6-d-gerlach@ti.com> <20170703165844.GD27842@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170703165844.GD27842@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Johan Hovold <johan@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Keerthy J <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/03/2017 11:58 AM, Johan Hovold wrote:
> On Fri, May 19, 2017 at 03:04:38PM -0500, Dave Gerlach wrote:
>> Add amx3_common_pm_init to create a dummy platform_device for
>> pm33xx so that our pm33xx module can probe and am335x and am437x
>> platforms to enable basic suspend to mem and standby support.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
> 
>> +void __init amx3_common_pm_init(void)
>> +{
>> +	struct platform_device_info devinfo = { };
> 
> You should make sure devinfo is zeroed, and also set .id to -1. 

Thanks for the comment, will look into updating this for next version.

Regards,
Dave

> 
>> +	struct am33xx_pm_platform_data *pdata;
>> +
>> +	pdata = am33xx_pm_get_pdata();
>> +	devinfo.name = "pm33xx";
>> +	devinfo.data = pdata;
>> +	devinfo.size_data = sizeof(*pdata);
>> +	platform_device_register_full(&devinfo);
>> +}
> 
> Johan
> 
