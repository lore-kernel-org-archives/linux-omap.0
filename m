From: kishon <kishon@ti.com>
Subject: Re: [RFC PATCH 1/7] drivers: usb: phy: add a new driver for usb part
 of control module
Date: Tue, 15 Jan 2013 19:54:23 +0530
Message-ID: <50F56697.9060803@ti.com>
References: <1358239378-10030-1-git-send-email-kishon@ti.com> <1358239378-10030-2-git-send-email-kishon@ti.com> <201301151336.47546.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201301151336.47546.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: grant.likely@secretlab.ca, b-cousson@ti.com, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, balbi@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

On Tuesday 15 January 2013 07:06 PM, Arnd Bergmann wrote:
> On Tuesday 15 January 2013, Kishon Vijay Abraham I wrote:
>> +OMAP CONTROL USB
>> +
>> +Required properties:
>> + - compatible: Should be "ti,omap-control-usb"
>> + - reg : Address and length of the register set for the device. It contains
>> +   the address of "control_dev_conf" and "otghs_control".
>> + - reg-names: The names of the register addresses corresponding to the registers
>> +   filled in "reg".
>> + - ti,has_mailbox: This is used to specify if the platform uses mailbox in
>> +   control module.
>
> I wonder whether we need to have a phandle here to connect the control device
> to the actual usb device. What happens if you have multiple instances of
> each?

Good point :-). Currently, none of the OMAP platforms have multiple 
control modules and it doesn't seem to be in the future (AFAIK). While 
it might be simpler to support multiple control devices with phandle, it 
might face the same complications as faced by the USB PHY framework for 
non-dt boot.

Thanks
Kishon
