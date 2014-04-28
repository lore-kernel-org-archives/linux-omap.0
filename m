From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH 07/10] ARM: dts: DRA7: Add DT node for DES IP
Date: Mon, 28 Apr 2014 11:38:33 -0500
Message-ID: <535E8409.10905@ti.com>
References: <1398466968-29506-1-git-send-email-joelf@ti.com>
 <1398466968-29506-8-git-send-email-joelf@ti.com>
 <535BE096.2060407@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <535BE096.2060407@cogentembedded.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 04/26/2014 11:36 AM, Sergei Shtylyov wrote:
> Hello.
> 
> On 26-04-2014 3:02, Joel Fernandes wrote:
> 
>> DRA7xx SoCs have a DES3DES IP. Add DT data for the same.
> 
>> Signed-off-by: Joel Fernandes <joelf@ti.com>
>> ---
>>   arch/arm/boot/dts/dra7.dtsi |   11 +++++++++++
>>   1 file changed, 11 insertions(+)
> 
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index 1c0f8e1..0533b89 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -789,6 +789,17 @@
>>               dma-names = "tx0", "rx0";
>>               status = "disabled";
>>           };
>> +
>> +        des: des@480a5000 {
> 
>    Shouldn't the node name be "crypto@480a5000", according to the ePAPR
> standard?
> 
Actually I'm not a big fan of the standard here in this regard.
"crypto@480a5000" doesn't mean anything and serves no purpose for
anyone. There are quite a few crypto modules and such a name doesn't
help and is confusing at best.

There's no property either in the device tree node itself to describe it
as des, except for the phandle label which is used only at dt
compile-time if I'm right. So makes sense to have the name be more specific.

This is how we have added dts nodes for other crypto modules in the past...

thanks,
 -Joel
