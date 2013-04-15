From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v3 0/6] Generic PHY Framework
Date: Mon, 15 Apr 2013 13:27:37 +0200
Message-ID: <516BE429.9040002@samsung.com>
References: <1363770725-13717-1-git-send-email-kishon@ti.com>
 <20130415102009.D358E3E0AA8@localhost> <516BD835.8060007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <516BD835.8060007@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-usb@vger.kernel.org, mchehab@redhat.com, linux-doc@vger.kernel.org, linux@arm.linux.org.uk, javier@dowhile0.org, cesarb@cesarb.net, eballetbo@gmail.com, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, swarren@nvidia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, balbi@ti.com, santosh.shilimkar@ti.com, akpm@linux-foundation.org, davem@davemloft.net
List-Id: linux-omap@vger.kernel.org

On 04/15/2013 12:36 PM, Kishon Vijay Abraham I wrote:
> On Monday 15 April 2013 03:50 PM, Grant Likely wrote:
>> On Wed, 20 Mar 2013 14:41:59 +0530, Kishon Vijay Abraham I <kishon@ti.com>
>> wrote:
>>> Added a generic PHY framework that provides a set of APIs for the PHY drivers
>>> to create/destroy a PHY and APIs for the PHY users to obtain a reference to
>>> the PHY with or without using phandle. To obtain a reference to the PHY
>>> without using phandle, the platform specfic intialization code (say from board
>>> file) should have already called phy_bind with the binding information. The
>>> binding information consists of phy's device name, phy user device name and an
>>> index. The index is used when the same phy user binds to mulitple phys.
>>>
>>> This framework will be of use only to devices that uses external PHY (PHY
>>> functionality is not embedded within the controller).
>>>
>>> The intention of creating this framework is to bring the phy drivers spread
>>> all over the Linux kernel to drivers/phy to increase code re-use and to
>>> increase code maintainability.
>>>
>>> Comments to make PHY as bus wasn't done because PHY devices can be part of
>>> other bus and making a same device attached to multiple bus leads to bad
>>> design.
>>>
>>> Making omap-usb2 and twl4030 to use this framework is provided as a sample.
>>>
>>> This patch series is developed on 3.9-rc3. Once the patch series gets finalised
>>> I'll resend omap-usb2 and twl4030 part based on Felipe's tree.
>>>
>>
>> [...]
>>
>>>   drivers/Kconfig                                    |    2 +
>>>   drivers/Makefile                                   |    2 +
>>>   drivers/phy/Kconfig                                |   13 +
>>>   drivers/phy/Makefile                               |    5 +
>>>   drivers/phy/phy-core.c                             |  574
>>> ++++++++++++++++++++
>>
>> This looks to be very specific for USB PHYs. Are you intending it to be
>> used for other types of PHYs, like Ethernet PHYs? If not, then this
> 
> Not really. This can be used by USB, SATA and Sylwester was planning to use it
> for video PHY's.

Yes, I have already some RFC patches to handle the display and the camera
interface DPHYs (MIPI DSI, MIPI CSI-2) with this API. I didn't post it, since
this framework is not settled yet. Those DPHYs need very few operations, like
disable/enable only and there was really not suitable API in the kernel until
now to handle them. We had plans in the past to write something like this 
generic PHY framework for the Samsung SoCs.

Some SoCs have plenty different PHYs: USB, SATA, MIPI CSI-2, MIPI DSI, HDMI... 
And some of them are simple enough to be covered by this generic PHY API.

Thanks,
Sylwester
