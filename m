From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: 3.17-rc6 on ODROID: ERROR: Bad of_node_put() on /ehci@12580000/port@1
Date: Thu, 02 Oct 2014 02:20:40 +0100
Message-ID: <542CA868.7060500@blueyonder.co.uk>
References: <CAD8Lp45qyHpHqRnUy4T9Sm8zV4XJBDp=cLYXjtcxmVrS8GSjbg@mail.gmail.com> <CAFp+6iGwB3XuzSuYPzO=5MacPO2LGFDnh9oS5rAL3Ne26wb9Dg@mail.gmail.com> <CAD8Lp46UxTd04fczjm9c1597SBnvR--PUasjBqZwvWU8MKtj8Q@mail.gmail.com> <CACxGe6v84netFeUdc3MwGeJzV-2r6rUAOpG5s9Lu9x=9TM9E_A@mail.gmail.com>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from know-smtprelay-omc-3.server.virginmedia.net ([80.0.253.67]:35452
	"EHLO know-smtprelay-omc-3.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbaJBB27 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Oct 2014 21:28:59 -0400
In-Reply-To: <CACxGe6v84netFeUdc3MwGeJzV-2r6rUAOpG5s9Lu9x=9TM9E_A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

3.17-rc7 boots on ODROID-U3 Ubuntu 14.04.
I deleted references to of_node_put in drivers/usb/host/ehci-exynos.c as 
recommended.

# make exynos_defconfig
# make menuconfig
root@odroidu3:/b2/linux-3.17.0-rc7# grep DTB .config
CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
# CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is not set


# make-kpkg -j 4 --initrd linux_headers linux_image

root@odroidu3:/b2/linux-3.17.0-rc7# ls -l ../linux*-3.17.0-rc7*.deb
-rw-r--r-- 1 root root 6410252 Oct 1 20:47 
../linux-headers-3.17.0-rc7-00006-gaad7fb9-dirty_3.17.0-rc7-00006-gaad7fb9-dirty-10.00.Custom_armhf.deb
-rw-r--r-- 1 root root 5124364 Oct 1 20:48 
../linux-image-3.17.0-rc7-00006-gaad7fb9-dirty_3.17.0-rc7-00006-gaad7fb9-dirty-10.00.Custom_armhf.deb

Installed the packages and generated a uInitrd

# make exynos4412-odroidu3.dtb
# root@odroidu3:/b2/linux-3.17.0-rc7# ls -l 
arch/arm/boot/dts/exynos4412-odroidu3.dtb
-rw-r--r-- 1 root root 35543 Oct 1 23:01 
arch/arm/boot/dts/exynos4412-odroidu3.dtb

# cat zImage exynos4412-odroidu3.dtb > /media/boot/zImage+dtb

Made the necessary changes to /media/boot - "cp zImage+dtb zImage" and 
"cp uInitrd-3.17.0-rc7 uInitrrd"

The kernel boots - no screens found in X. All my USB devices show and 
USB hard drives mounted.
recompiled and installed xf86-video-armsoc-r4p0
root@odroidu3:~# uname -r
3.17.0-rc7-00006-gaad7fb9-dirty
root@odroidu3:~# lsusb
Bus 001 Device 006: ID 13fd:1840 Initio Corporation INIC-1608 SATA bridge
Bus 001 Device 008: ID 0b95:7720 ASIX Electronics Corp. AX88772
Bus 001 Device 015: ID 0ccd:0028 TerraTec Electronic GmbH Aureon 5.1 MkII
Bus 001 Device 021: ID 093a:2510 Pixart Imaging, Inc. Optical Mouse
Bus 001 Device 009: ID 0e8f:0022 GreenAsia Inc.
Bus 001 Device 007: ID 050d:0307 Belkin Components USB 2.0 - 7 ports Hub 
[FSU307]
Bus 001 Device 005: ID 1a40:0101 Terminus Technology Inc. 4-Port HUB
Bus 001 Device 004: ID 13fd:1840 Initio Corporation INIC-1608 SATA bridge
Bus 001 Device 003: ID 0424:3503 Standard Microsystems Corp.
Bus 001 Device 002: ID 0424:9730 Standard Microsystems Corp.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Regards
Sid.

On 01/10/14 16:38, Grant Likely wrote:
> On Wed, Oct 1, 2014 at 4:12 PM, Daniel Drake <drake@endlessm.com> wrote:
>> On Wed, Oct 1, 2014 at 12:36 AM, Vivek Gautam <gautam.vivek@samsung.com> wrote:
>>> One reason i doubt why it could be coming is because we are
>>> specifically putting the
>>> child after doing everything with it.
>>>
>>> When we are getting the child node using for_each_available_child_of_node(),
>>> which calls for of_get_next_available_child(). So of_get_next_available_child()
>>> does a of_node_put() on the "prev" node, in case we have siblings to the child.
>>>
>>> Can you see if the below change helps ?
>>>
>>> ------------------------------------------------------------------------------------------------------------
>>> diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
>>> index 7189f2e..1b726bf 100644
>>> --- a/drivers/usb/host/ehci-exynos.c
>>> +++ b/drivers/usb/host/ehci-exynos.c
>>> @@ -74,7 +74,6 @@ static int exynos_ehci_get_phy(struct device *dev,
>>>
>>>                  phy = devm_of_phy_get(dev, child, NULL);
>>>                  exynos_ehci->phy[phy_number] = phy;
>>> -               of_node_put(child);
>>>                  if (IS_ERR(phy)) {
>>>                          ret = PTR_ERR(phy);
>>>                          if (ret == -EPROBE_DEFER) {
>>> ------------------------------------------------------------------------------------------------------------
>>>
>>>
>>> This is on top of usb-next.
>>> If you are testing on rc6 only, then probably you will have to cherrypick two
>>> patches each for ehci-exynos and ohci-exynos:
>>> usb: host: ehci-exynos: Remove unnecessary usb-phy support
>>> usb: host: ohci-exynos: Remove unnecessary usb-phy support
>> I made the equivalent change to 3.17-rc7 (right now 3.17 is my main
>> interest), i.e. removed all of_node_put calls from
>> exynos_ehci_get_phy(). Same change is needed in exynos_ohci_get_phy().
>> Now the warnings are gone.
>> BTW, I think the warning only appeared when CONFIG_OF_SELFTEST=y
>>
>> I didn't check the implementation details like you did, but I looked
>> at a few other users of for_each_available_child_of_node and it looks
>> like indeed you do not need to call of_node_put() on the children in
>> the normal case, or at least, nobody else does.
> CONFIG_OF_SELFTEST enables CONFIG_OF_DYNAMIC, and reference counting
> is only implemented when OF_DYNAMIC is enabled. That's probably why
> selftest exposes the problem.
>
> g.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Senior Staff Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

