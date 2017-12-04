From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v4.14] Add support for bq27521 battery monitor
Date: Mon, 4 Dec 2017 09:20:33 -0600
Message-ID: <cfa89227-e08a-849f-c886-723268ae657c@ti.com>
References: <20171109210615.GA27638@amd> <20171110103937.GA29900@amd>
 <20171201230649.GA27533@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171201230649.GA27533@amd>
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
To: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, kernel@networkimprov.net, devicetree@vger.kernel.org, robh+dt@kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/01/2017 05:06 PM, Pavel Machek wrote:
> Hi!
> 
>> This adds basic support for BQ27521 battery monitor, used in Nokia N9
>> and N950. In particular, battery voltage is important to be able to
>> tell when the battery is almost empty. Emptying battery on N950 is
>> pretty painful, as flasher needs to be used to recover phone in such
>> case.
> 
> Sebastian, ping? This one should not be too controversial.
> 
> If you could also apply the "shut down when battery is low", that
> would be nice.
> 
> Thanks,
> 								Pavel
> 
>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>
>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>> index 51f0961..f684288 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -323,6 +323,30 @@ static u8
>>  		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
>>  		BQ27XXX_DM_REG_ROWS,
>>  	},
>> +	bq27521_regs[BQ27XXX_REG_MAX] = {
>> +		[BQ27XXX_REG_CTRL] = 0x02,
>> +		[BQ27XXX_REG_TEMP] = 0x0a,
>> +		[BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
>> +		[BQ27XXX_REG_VOLT] = 0x0c,
>> +		[BQ27XXX_REG_AI] = 0x0e,
>> +		[BQ27XXX_REG_FLAGS] = 0x08,
>> +		[BQ27XXX_REG_TTE] = INVALID_REG_ADDR,
>> +		[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
>> +		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
>> +		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
>> +		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
>> +		[BQ27XXX_REG_FCC] = INVALID_REG_ADDR,
>> +		[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
>> +		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
>> +		[BQ27XXX_REG_SOC] = INVALID_REG_ADDR,
>> +		[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
>> +		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
>> +		[BQ27XXX_DM_CTRL] = INVALID_REG_ADDR,
>> +		[BQ27XXX_DM_CLASS] = INVALID_REG_ADDR,
>> +		[BQ27XXX_DM_BLOCK] = INVALID_REG_ADDR,
>> +		[BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
>> +		[BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
>> +	},
>>  	bq27530_regs[BQ27XXX_REG_MAX] = {
>>  		[BQ27XXX_REG_CTRL] = 0x00,
>>  		[BQ27XXX_REG_TEMP] = 0x06,
>> @@ -557,6 +581,15 @@ static enum power_supply_property bq27520g4_props[] = {
>>  	POWER_SUPPLY_PROP_MANUFACTURER,
>>  };
>>  
>> +static enum power_supply_property bq27521_props[] = {
>> +	POWER_SUPPLY_PROP_STATUS,
>> +	POWER_SUPPLY_PROP_PRESENT,
>> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>> +	POWER_SUPPLY_PROP_CURRENT_NOW,
>> +	POWER_SUPPLY_PROP_TEMP,
>> +	POWER_SUPPLY_PROP_TECHNOLOGY,
>> +};
>> +
>>  static enum power_supply_property bq27530_props[] = {
>>  	POWER_SUPPLY_PROP_STATUS,
>>  	POWER_SUPPLY_PROP_PRESENT,
>> @@ -671,6 +704,7 @@ static struct bq27xxx_dm_reg bq27500_dm_regs[] = {
>>  #define bq27520g2_dm_regs 0
>>  #define bq27520g3_dm_regs 0
>>  #define bq27520g4_dm_regs 0
>> +#define bq27521_dm_regs 0
>>  #define bq27530_dm_regs 0
>>  #define bq27531_dm_regs 0
>>  #define bq27541_dm_regs 0
>> @@ -717,8 +751,8 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
>>  #endif
>>  
>>  #define BQ27XXX_O_ZERO	0x00000001
>> -#define BQ27XXX_O_OTDC	0x00000002
>> -#define BQ27XXX_O_UTOT  0x00000004
>> +#define BQ27XXX_O_OTDC	0x00000002 /* has OTC/OTD overtemperature flags */
>> +#define BQ27XXX_O_UTOT  0x00000004 /* has OT overtemperature flag */

These should get turned into BIT() macros, but that's not your problem
for this patch,


Acked-by: Andrew F. Davis <afd@ti.com>


>>  #define BQ27XXX_O_CFGUP	0x00000008
>>  #define BQ27XXX_O_RAM	0x00000010
>>  
>> @@ -751,6 +785,7 @@ static struct {
>>  	[BQ27520G2] = BQ27XXX_DATA(bq27520g2, 0         , BQ27XXX_O_OTDC),
>>  	[BQ27520G3] = BQ27XXX_DATA(bq27520g3, 0         , BQ27XXX_O_OTDC),
>>  	[BQ27520G4] = BQ27XXX_DATA(bq27520g4, 0         , BQ27XXX_O_OTDC),
>> +	[BQ27521]   = BQ27XXX_DATA(bq27521,   0         , 0),
>>  	[BQ27530]   = BQ27XXX_DATA(bq27530,   0         , BQ27XXX_O_UTOT),
>>  	[BQ27531]   = BQ27XXX_DATA(bq27531,   0         , BQ27XXX_O_UTOT),
>>  	[BQ27541]   = BQ27XXX_DATA(bq27541,   0         , BQ27XXX_O_OTDC),
>> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
>> index 0b11ed4..6b25e5f 100644
>> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
>> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
>> @@ -239,6 +239,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>>  	{ "bq27520g2", BQ27520G2 },
>>  	{ "bq27520g3", BQ27520G3 },
>>  	{ "bq27520g4", BQ27520G4 },
>> +	{ "bq27521", BQ27521 },
>>  	{ "bq27530", BQ27530 },
>>  	{ "bq27531", BQ27531 },
>>  	{ "bq27541", BQ27541 },
>> @@ -269,6 +270,7 @@ static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] = {
>>  	{ .compatible = "ti,bq27520g2" },
>>  	{ .compatible = "ti,bq27520g3" },
>>  	{ .compatible = "ti,bq27520g4" },
>> +	{ .compatible = "ti,bq27521" },
>>  	{ .compatible = "ti,bq27530" },
>>  	{ .compatible = "ti,bq27531" },
>>  	{ .compatible = "ti,bq27541" },
>> diff --git a/include/linux/mfd/twl.h b/include/linux/mfd/twl.h
>> index 9ad7828..6547d30 100644
>> --- a/include/linux/mfd/twl.h
>> +++ b/include/linux/mfd/twl.h
>> @@ -70,6 +70,7 @@ enum twl4030_module_ids {
>>  	TWL4030_MODULE_INT,
>>  
>>  	TWL5031_MODULE_ACCESSORY,
>> +	TWL5031_MODULE_BCC,
>>  	TWL5031_MODULE_INTERRUPTS,
>>  
>>  	TWL4030_MODULE_LAST,
>> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
>> index 43194e0..d8d127a 100644
>> --- a/include/linux/power/bq27xxx_battery.h
>> +++ b/include/linux/power/bq27xxx_battery.h
>> @@ -15,6 +15,7 @@ enum bq27xxx_chip {
>>  	BQ27520G2, /* bq27520G2 */
>>  	BQ27520G3, /* bq27520G3 */
>>  	BQ27520G4, /* bq27520G4 */
>> +	BQ27521, /* bq27521 */	
>>  	BQ27530, /* bq27530, bq27531 */
>>  	BQ27531,
>>  	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
>>
> 
> 
> 
