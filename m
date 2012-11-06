From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v2] usb: musb: dsps: dt binding - add resources, example
Date: Tue, 6 Nov 2012 17:58:57 +0100
Message-ID: <509941D1.6020405@ti.com>
References: <1352210166-7253-1-git-send-email-afzal@ti.com> <20121106164445.GE3993@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20121106164445.GE3993@arwen.pp.htv.fi>
Sender: linux-doc-owner@vger.kernel.org
To: balbi@ti.com
Cc: Afzal Mohammed <afzal@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Santhapuri Damodar <damodar.santhapuri@ti.com>, Ravi Babu <ravibabu@ti.com>, Daniel Mack <zonque@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/06/2012 05:44 PM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Nov 06, 2012 at 07:26:06PM +0530, Afzal Mohammed wrote:
>> OMAP2+ family of devices are now obtaining resources via DT, earlier
>> it was obtained from hwmod. Update binding document accrodingly, while
>> at it add example.
>>
>> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> 
> this looks fine to me:
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> 
> Benoit, do you take Documentation patches too ?

Well, ideally it should go with the driver change. But if this is a
simple change related to generic attribute I can take it.

Regards,
Benoit

> 
>> ---
>>
>> v2: node name changed to "usb"
>>
>>  .../devicetree/bindings/usb/am33xx-usb.txt          | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
>> index a922505..ea840f7 100644
>> --- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
>> +++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
>> @@ -1,5 +1,7 @@
>>  AM33XX MUSB GLUE
>>   - compatible : Should be "ti,musb-am33xx"
>> + - reg : offset and length of register sets, first usbss, then for musb instances
>> + - interrupts : usbss, musb instance interrupts in order
>>   - ti,hwmods : must be "usb_otg_hs"
>>   - multipoint : Should be "1" indicating the musb controller supports
>>     multipoint. This is a MUSB configuration-specific setting.
>> @@ -12,3 +14,22 @@ AM33XX MUSB GLUE
>>     represents PERIPHERAL.
>>   - power : Should be "250". This signifies the controller can supply upto
>>     500mA when operating in host mode.
>> +
>> +Example:
>> +
>> +usb@47400000  {
>> +	compatible = "ti,musb-am33xx";
>> +	reg = <0x47400000 0x1000	/* usbss */
>> +	       0x47401000 0x800		/* musb instance 0 */
>> +	       0x47401800 0x800>;	/* musb instance 1 */
>> +	interrupts = <17		/* usbss */
>> +		      18		/* musb instance 0 */
>> +		      19>;		/* musb instance 1 */
>> +	multipoint = <1>;
>> +	num-eps = <16>;
>> +	ram-bits = <12>;
>> +	port0-mode = <3>;
>> +	port1-mode = <3>;
>> +	power = <250>;
>> +	ti,hwmods = "usb_otg_hs";
>> +};
>> -- 
>> 1.7.12
>>
> 

