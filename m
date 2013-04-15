From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 0/6] Generic PHY Framework
Date: Mon, 15 Apr 2013 18:03:04 +0530
Message-ID: <516BF380.9020004@ti.com>
References: <1363770725-13717-1-git-send-email-kishon@ti.com>
 <20130415102009.D358E3E0AA8@localhost> <516BD835.8060007@ti.com>
 <20130415122634.3A08A3E0AA8@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130415122634.3A08A3E0AA8@localhost>
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
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, KISHON-l0cyMroinI0@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Monday 15 April 2013 05:56 PM, Grant Likely wrote:
> On Mon, 15 Apr 2013 16:06:37 +0530, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
>> Hi,
>>
>> On Monday 15 April 2013 03:50 PM, Grant Likely wrote:
>>> On Wed, 20 Mar 2013 14:41:59 +0530, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
>>>> Added a generic PHY framework that provides a set of APIs for the PHY drivers
>>>> to create/destroy a PHY and APIs for the PHY users to obtain a reference to
>>>> the PHY with or without using phandle. To obtain a reference to the PHY
>>>> without using phandle, the platform specfic intialization code (say from board
>>>> file) should have already called phy_bind with the binding information. The
>>>> binding information consists of phy's device name, phy user device name and an
>>>> index. The index is used when the same phy user binds to mulitple phys.
>>>>
>>>> This framework will be of use only to devices that uses external PHY (PHY
>>>> functionality is not embedded within the controller).
>>>>
>>>> The intention of creating this framework is to bring the phy drivers spread
>>>> all over the Linux kernel to drivers/phy to increase code re-use and to
>>>> increase code maintainability.
>>>>
>>>> Comments to make PHY as bus wasn't done because PHY devices can be part of
>>>> other bus and making a same device attached to multiple bus leads to bad
>>>> design.
>>>>
>>>> Making omap-usb2 and twl4030 to use this framework is provided as a sample.
>>>>
>>>> This patch series is developed on 3.9-rc3. Once the patch series gets finalised
>>>> I'll resend omap-usb2 and twl4030 part based on Felipe's tree.
>>>>
>>>
>>> [...]
>>>
>>>>    drivers/Kconfig                                    |    2 +
>>>>    drivers/Makefile                                   |    2 +
>>>>    drivers/phy/Kconfig                                |   13 +
>>>>    drivers/phy/Makefile                               |    5 +
>>>>    drivers/phy/phy-core.c                             |  574 ++++++++++++++++++++
>>>
>>> This looks to be very specific for USB PHYs. Are you intending it to be
>>> used for other types of PHYs, like Ethernet PHYs? If not, then this
>>
>> Not really. This can be used by USB, SATA and Sylwester was planning to
>> use it for video PHY's.
>
> So what are the common bits that are shared between those phys? Merely
> matching phys to controllers? Besides that, each of those devices have

The same PIPE3 PHY IP is used for USB (usb3) and SATA in OMAP5. Even for 
just matching PHYs to controllers you need a simple framework (like 
this) or else we'll end up in creating such frameworks for lot of these 
subsystems.

Thanks
Kishon
