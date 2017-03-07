From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 0/7] thermal: ti-soc-thermal: Migrate slope/offset data to
 device tree
Date: Tue, 7 Mar 2017 12:43:36 +0530
Message-ID: <1c47d169-7962-2fe7-0635-570881e85e06@ti.com>
References: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
 <20170306184215.GO20572@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170306184215.GO20572@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: t-kristo@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, edubezval@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 07 March 2017 12:12 AM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [170301 02:31]:
>> Currently the slope and offset values for calculating the
>> hot spot temperature of a particular thermal zone is part
>> of driver data. Pass them here instead and obtain the values
>> while of node parsing.
>>
>> Tested for the slope and constant values on DRA7-EVM.
>>
>> Keerthy (7):
>>   ARM: DRA7: Thermal: Add slope and offset values
>>   ARM: OMAP5: Thermal: Add slope and offset values
>>   ARM: OMAP443x: Thermal: Add slope and offset values
>>   ARM: OMAP4460: Thermal: Add slope and offset values
>>   thermal: ti-soc-thermal: Fetch slope and offset from DT
>>   thermal: ti-soc-thermal: Remove redundant constants
>>   thermal: ti-soc-thermal: Remove redundant code
>
> Are the dts changes safe for me to pick separately into
> omap-for-v4.12/dt?

Tony,

Seems like omap3 has no thermal_zone node defined in Device Tree.
It seems like it still uses driver data. I would need to add that as 
well. Can you confirm that? If yes i will send a new series with the 
omap3 device tree changes as well.

Thanks,
Keerthy

>
> Regards,
>
> Tony
>
