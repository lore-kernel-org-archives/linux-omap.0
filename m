From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 0/5] extcon: usb: Introduce USB GPIO extcon driver. Fix
 DRA7 USB.
Date: Thu, 22 Jan 2015 15:32:12 +0200
Message-ID: <54C0FBDC.6040803@ti.com>
References: <1421689942-10201-1-git-send-email-rogerq@ti.com> <20150120190237.GG15169@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150120190237.GG15169@saruman>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, george.cherian@ti.com, nsekhar@ti.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Felipe,

On 20/01/15 21:02, Felipe Balbi wrote:
> On Mon, Jan 19, 2015 at 07:52:17PM +0200, Roger Quadros wrote:
>> Hi,
>>
>> On DRA7 EVMs the USB ID pin is connected to a GPIO line. The USB drivers
>> (dwc3 + dwc3-omap) depend on extcon framework to get the USB cable state
>> (USB or USB-Host) to put the controller in the right mode.
>>
>> There were earlier attempts [1] to get this working by trying to patch up
>> the existing GPIO extcon driver.
>>
>> This series attemts to take a different approach by introducing a new
>> USB specific extcon driver to handle the USB ID GPIO pin and
>> interpret a right USB cable state.
>>
>> The reasoning to introduce this new driver is:
>> 1) The existing GPIO extcon driver doesn't understand USB cable states
>> and it can't handle more than one cable per instance.
>>    
>> For the USB case we need to handle at least 2 cable states.
>>     a) USB (attach/detach)
>>     b) USB-Host (attach/detach)
>> and could possible include more states like
>>     c) Fast-charger (attach/detach)
>>     d) Slow-charger (attach/detach)
>>     
>> 2) This USB specific driver can be easily updated in the future to
>> handle VBUS events, or charger detect events, in case it happens
>> to be available on GPIO for any platform.
>>
>> 3) The DT implementation is very easy. You just need one extcon node per USB
>> instead of one extcon node per cable state as in case of [1].
>>
>> 4) The cable state string doesn't need to be encoded in the device tree
>> as in case of [1].
>>
>> 5) With only ID event available, you can simulate a USB-peripheral attach
>> when USB-Host is detacted instead of hacking the USB driver to do the same.
>>
>> Tested on DRA7-evm and DRA72-evm.
> 
> while at that, you might want to patch X15 too.
> 
USB2 port is meant for peripheral use only. ID pin from USB port is not connected to GPIO.

cheers,
-roger
