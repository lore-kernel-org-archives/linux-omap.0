From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 04/13] mfd: omap-usb-tll: Add device tree support
Date: Tue, 5 Feb 2013 10:46:51 +0200
Message-ID: <5110C6FB.90101@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-5-git-send-email-rogerq@ti.com> <5110A0DF.7050609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5110A0DF.7050609-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: kishon <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 02/05/2013 08:04 AM, kishon wrote:
> On Monday 04 February 2013 09:28 PM, Roger Quadros wrote:
>> Enable this driver to probe in device tree boot.
>>
>> CC: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>   .../devicetree/bindings/mfd/omap-usb-tll.txt       |   17 +++++++++++++++++
>>   drivers/mfd/omap-usb-tll.c                         |    9 +++++++++
>>   2 files changed, 26 insertions(+), 0 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt b/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
>> new file mode 100644
>> index 0000000..835cf4f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
>> @@ -0,0 +1,17 @@
>> +OMAP HS USB Host TLL (Transceiver-Less Interface)
>> +
>> +Required properties:
>> +
>> +- compatible : should be "ti,usbhs-tll"
>> +- reg : should contain one register range i.e. start and length
>> +- interrupts : should contain the TLL module's interrupt
>> +- ti,hwmod : must contain "usb_tll_hs"
>> +
>> +Example:
>> +
>> +    usbhstll: usbhstll@0x4a062000 {
> The node name shouldn't have 0x. This comment applies to all your patches adding device tree support.

OK, will fix.

cheers,
-roger
