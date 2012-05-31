From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [RFC PATCH 0/5] omap: add ocp2scp as a misc driver
Date: Thu, 31 May 2012 13:44:04 +0530
Message-ID: <CAAe_U6LFFstds=iQ7cy7gM9vWbfRgf5z0gaRp_-bu0Qjx6eA1Q@mail.gmail.com>
References: <1338375394-16268-1-git-send-email-kishon@ti.com>
	<201205301843.51568.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201205301843.51568.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

On Thu, May 31, 2012 at 12:13 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 30 May 2012, Kishon Vijay Abraham I wrote:
>>
>> This patch series is done as a preparatory step for adding phy drivers
>> for dwc3 and musb.
>>
>> This series adds a new driver for ocp2scp to which phy drivers are connected.
>>
>> I'm planning to send phy drivers asap. Meanwhile I'd like to get some
>> review comments for this series. I have also plans to send device tree
>> adaptation of the ocp2scp driver.
>>
>> Developed on
>> http://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-next
>>
>> If it has to be based on some other tree, please let me know.
>
> This must be the most pointless driver I've seen in a long time. It doesn't
> actually do anything at all, it just creates child devices from a static
> lookup table.
>
> Just put the devices you actually want into the device tree instead and
> have them automatically created.

But shouldn't device tree support and non-device tree support co-exist
till the non-device tree is completely knocked out of the kernel? Even
then shouldn't there be a separate driver to extract the child nodes
of ocp2scp and create a device (using of_platform_populate)?
As far as I've seen, the devices are automatically created (by virtue
of of_platform_populate() in  mach-omap2/board-generic.c in omap case)
only for the devices that is connected to the system bus. For other
cases, the parent should be responsible for creating the child
devices.

Thanks
Kishon
