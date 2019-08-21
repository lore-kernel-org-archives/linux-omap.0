From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 7/8] soc: ti: omap-prm: add dra7 PRM data
Date: Wed, 21 Aug 2019 10:36:11 +0300
Message-ID: <67a06e0c-f85d-bdc4-aedf-9a3c0e80fc6a@ti.com>
References: <1565164139-21886-1-git-send-email-t-kristo@ti.com>
 <1565164139-21886-8-git-send-email-t-kristo@ti.com>
 <0e8aa351-4c58-ab6c-890f-094118b812ac@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <0e8aa351-4c58-ab6c-890f-094118b812ac@ti.com>
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
To: Suman Anna <s-anna@ti.com>, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, robh+dt@kernel.org
Cc: tony@atomide.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 20.8.2019 22.03, Suman Anna wrote:
> Hi Tero,
> 
> On 8/7/19 2:48 AM, Tero Kristo wrote:
>> Add PRM data for dra7 family of SoCs.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/soc/ti/omap_prm.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
>> index fadfc7f..05b7749 100644
>> --- a/drivers/soc/ti/omap_prm.c
>> +++ b/drivers/soc/ti/omap_prm.c
>> @@ -73,6 +73,31 @@ struct omap_prm_data omap4_prm_data[] = {
>>   	{ },
>>   };
>>   
>> +static struct omap_prm_data dra7_prm_data[] = {
>> +	{ .name = "mpu", .base = 0x4ae06300, .pwstst = 0x4 },
>> +	{ .name = "dsp1", .base = 0x4ae06400, .pwstst = 0x4, .rstctl = 0x10, .rstst = 0x14 },
>> +	{ .name = "ipu", .base = 0x4ae06500, .pwstst = 0x4, .rstctl = 0x10, .rstst = 0x14, .clkdm_name = "ipu1" },
>> +	{ .name = "coreaon", .base = 0x4ae06628, .pwstst = 0x4 },
> 
> Public TRM marks this region Reserved. Do you need it for anything?
This is copied from existing PRM data from kernel. However, I'll ditch 
these for now and only retain the reset enabled domains.

> 
>> +	{ .name = "core", .base = 0x4ae06700, .pwstst = 0x4, .rstctl = 0x210, .rstst = 0x214, .clkdm_name = "ipu2" },
>> +	{ .name = "iva", .base = 0x4ae06f00, .pwstst = 0x4 },
> 
> Missing rstctrl and rstst offsets.

Will add.

> 
>> +	{ .name = "cam", .base = 0x4ae07000, .pwstst = 0x4 },
>> +	{ .name = "dss", .base = 0x4ae07100, .pwstst = 0x4 },
>> +	{ .name = "gpu", .base = 0x4ae07200, .pwstst = 0x4 },
>> +	{ .name = "l3init", .base = 0x4ae07300, .pwstst = 0x4, .rstctl = 0x10, .rstst = 0x14 },
>> +	{ .name = "l4per", .base = 0x4ae07400, .pwstst = 0x4 },
>> +	{ .name = "custefuse", .base = 0x4ae07600, .pwstst = 0x4 },
>> +	{ .name = "wkupaon", .base = 0x4ae07724, .pwstst = 0x4 },
> 
> No pwstctrl and pwstst bits documented in TRM or are marked reserved.

Same as coreaon.

> 
>> +	{ .name = "emu", .base = 0x4ae07900, .pwstst = 0x4 },
>> +	{ .name = "dsp2", .base = 0x4ae07b00, .pwstst = 0x4, .rstctl = 0x10, .rstst = 0x14 },
>> +	{ .name = "eve1", .base = 0x4ae07b40, .pwstst = 0x4 },
>> +	{ .name = "eve2", .base = 0x4ae07b80, .pwstst = 0x4 },
>> +	{ .name = "eve3", .base = 0x4ae07bc0, .pwstst = 0x4 },
>> +	{ .name = "eve4", .base = 0x4ae07c00, .pwstst = 0x4 },
> 
> All EVEs are missing rstctrl and rstst fields.

Will add.

> 
>> +	{ .name = "rtc", .base = 0x4ae07c60, .pwstst = 0x4 },
> 
> Undocumented pwstctrl and pwstst registers.
> 
>> +	{ .name = "vpe", .base = 0x4ae07c80, .pwstst = 0x4 },
> 
> Missing "device" and "instr" PRM. The latter doesn't have any pwrstctl
> and pwrstst though.

Will ditch those.

-Tero

> 
> regards
> Suman
> 
>> +	{ },
>> +};
>> +
>>   struct omap_rst_map am3_wkup_rst_map[] = {
>>   	{ .rst = 3, .st = 5 },
>>   	{ .rst = -1 },
>> @@ -91,6 +116,7 @@ struct omap_prm_data am3_prm_data[] = {
>>   
>>   static const struct of_device_id omap_prm_id_table[] = {
>>   	{ .compatible = "ti,omap4-prm-inst", .data = omap4_prm_data },
>> +	{ .compatible = "ti,dra7-prm-inst", .data = dra7_prm_data },
>>   	{ .compatible = "ti,am3-prm-inst", .data = am3_prm_data },
>>   	{ },
>>   };
>>
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
