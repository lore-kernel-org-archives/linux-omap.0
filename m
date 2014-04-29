From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 5/7] phy: omap-usb2: Add clock names to Documentation
 binding
Date: Tue, 29 Apr 2014 10:57:34 +0300
Message-ID: <535F5B6E.4050401@ti.com>
References: <1398693687-13967-1-git-send-email-rogerq@ti.com> <1398693687-13967-6-git-send-email-rogerq@ti.com> <535E8E97.7040809@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35905 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491AbaD2H5m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2014 03:57:42 -0400
In-Reply-To: <535E8E97.7040809@cogentembedded.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, balbi@ti.com, kishon@ti.com, tony@atomide.com
Cc: george.cherian@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org

Hi Sergei,

On 04/28/2014 08:23 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 04/28/2014 06:01 PM, Roger Quadros wrote:
> 
>> Add "wkupclk" and "refclk" information to DT binding information.
> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   Documentation/devicetree/bindings/phy/ti-phy.txt | 7 +++++++
>>   1 file changed, 7 insertions(+)
> 
>> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
>> index 788fb0f..9ce458f 100644
>> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
>> @@ -32,6 +32,11 @@ Required properties:
>>    - reg : Address and length of the register set for the device.
>>    - #phy-cells: determine the number of cells that should be given in the
>>      phandle while referencing this phy.
>> + - clocks: a list of phandles and clock-specifier pairs, one for each entry in
>> +   clock-names.
> 
>    I thought clock specifier includes phandle. Anyway, this description doesn't seem to match your example...

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/clock-bindings.txt#n64

The example was taken from real world where the clock doesn't need specifier.
Examples can always be a subset of supported bindings.

cheers,
-roger

> 
>> + - clock-names: should include:
>> +   * "wkupclk" - wakeup clock.
>> +   * "refclk" - reference clock (optional).
>>
>>   Optional properties:
>>    - ctrl-module : phandle of the control module used by PHY driver to power on
>> @@ -44,6 +49,8 @@ usb2phy@4a0ad080 {
>>       reg = <0x4a0ad080 0x58>;
>>       ctrl-module = <&omap_control_usb>;
>>       #phy-cells = <0>;
>> +    clocks = <&usb_phy_cm_clk32k>, <&usb_otg_ss_refclk960m>;
>> +    clock-names = "wkupclk", "refclk";
>>   };
> 
> WBR, Sergei
> 

