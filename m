From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 4/8] usb: phy: omap-usb3: Don't use
 omap_get_control_dev()
Date: Mon, 19 Aug 2013 17:25:50 +0300
Message-ID: <52122AEE.5050401@ti.com>
References: <1376908667-14974-1-git-send-email-rogerq@ti.com>
 <1376908667-14974-5-git-send-email-rogerq@ti.com>
 <52122A69.6080000@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52122A69.6080000@cogentembedded.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: devicetree@vger.kernel.org, george.cherian@ti.com, tony@atomide.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, balbi@ti.com, kishon@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Sergei,

On 08/19/2013 05:23 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 08/19/2013 02:37 PM, Roger Quadros wrote:
> 
>> omap_get_control_dev() is being deprecated as it doesn't support
>> multiple instances. As control device is present only from OMAP4
>> onwards which supports DT only, we use phandles to get the
>> reference to the control device.
> 
>> As we don't support non-DT boot, we just bail out on probe
>> if device node is not present.
> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   drivers/usb/phy/phy-omap-usb3.c |   22 ++++++++++++++++++----
>>   1 files changed, 18 insertions(+), 4 deletions(-)
> 
>> diff --git a/drivers/usb/phy/phy-omap-usb3.c b/drivers/usb/phy/phy-omap-usb3.c
>> index 4a7f27c..981313e 100644
>> --- a/drivers/usb/phy/phy-omap-usb3.c
>> +++ b/drivers/usb/phy/phy-omap-usb3.c
> [...]
>> @@ -198,6 +199,12 @@ static int omap_usb3_probe(struct platform_device *pdev)
>>   {
>>       struct omap_usb            *phy;
>>       struct resource            *res;
>> +    struct device_node *node = pdev->dev.of_node;
>> +    struct device_node *control_node;
>> +    struct platform_device *control_pdev;
> 
>    Could you align the variable names with the above 2 variables?
> Either that, or remove the alignment of those two.

OK, I'll remove the alignment of the 1st two lines.

cheers,
-roger
