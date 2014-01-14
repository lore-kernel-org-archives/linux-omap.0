From: "Anna, Suman" <s-anna@ti.com>
Subject: Re: [PATCHv4 7/7] hwspinlock/omap: enable build for AM33xx, AM43xx
 & DRA7xx
Date: Tue, 14 Jan 2014 10:51:31 -0600
Message-ID: <52D56B13.2050409@ti.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <1389658764-39199-8-git-send-email-s-anna@ti.com>
 <20140114131207.GB10818@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140114131207.GB10818@saruman.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Felipe,

On 01/14/2014 07:12 AM, Felipe Balbi wrote:
> On Mon, Jan 13, 2014 at 06:19:24PM -0600, Suman Anna wrote:
>> HwSpinlocks are supported on AM33xx, AM43xx and DRA7xx SoC
>> device families as well. The IPs are identical to that of
>> OMAP4/OMAP5, except for the number of locks.
>>
>> Add a depends on to the above family of SoCs to enable the
>> build support for OMAP hwspinlock driver for any of the above
>> SoC configs.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>   drivers/hwspinlock/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
>> index 70637d2..3612cb5 100644
>> --- a/drivers/hwspinlock/Kconfig
>> +++ b/drivers/hwspinlock/Kconfig
>> @@ -10,7 +10,7 @@ menu "Hardware Spinlock drivers"
>>
>>   config HWSPINLOCK_OMAP
>>   	tristate "OMAP Hardware Spinlock device"
>> -	depends on ARCH_OMAP4 || SOC_OMAP5
>> +	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX || SOC_AM33XX || SOC_AM43XX
>
> how about just using ARCH_OMAP2PLUS ?

We do not want the driver to build in OMAP2-only and/or OMAP3-only 
configurations, on which the hwspinlock IP is not even present.

regards
Suman
