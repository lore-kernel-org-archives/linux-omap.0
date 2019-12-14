From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: BUG - was: [GIT PULL 2/3] bcm2835-soc-next-2019-10-15
Date: Sat, 14 Dec 2019 17:54:30 +0100
Message-ID: <f6f38340-2555-7907-6b89-748c34cd2978@gmx.net>
References: <1571159725-5090-1-git-send-email-wahrenst@gmx.net>
 <1571159725-5090-2-git-send-email-wahrenst@gmx.net>
 <12244E4E-A1A0-4EE9-ACD3-EA165D9A2C79@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <12244E4E-A1A0-4EE9-ACD3-EA165D9A2C79@goldelico.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, arm-soc <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Tony Lindgren <tony@atomide.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
List-Id: linux-omap@vger.kernel.org

Hi Nikolaus,

[add Nicolas as the new BCM2835 maintainer]

Am 14.12.19 um 11:54 schrieb H. Nikolaus Schaller:
> Hi Stefan,
>
>> Am 15.10.2019 um 19:15 schrieb Stefan Wahren <wahrenst@gmx.net>:
>>
>> Hi Florian,
>>
>> The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:
>>
>>  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
>>
>> are available in the git repository at:
>>
>>  git://github.com/anholt/linux tags/bcm2835-soc-next-2019-10-15
>>
>> for you to fetch changes up to 781fa0a954240c8487683ddf837fb2c4ede8e7ca:
>>
>>  ARM: bcm: Add support for BCM2711 SoC (2019-10-10 19:21:03 +0200)
> this patch has finally arrived in v5.5-rc1 but it seems to break
> multiplatform build.
>
> We run a distribution kernel that supports OMAP3/4/5, i.MX6 and RasPi 3B+
> but since rebasing to v5.5-rc1 the kernel hangs after "Starting Kernel ...".
> On all ARM devices (incl. RasPi 3B+).

i wasn't able to reproduce this issue with the RPi 3B+ so far and i
don't have any OMAP hardware:

Linux 5.3 (bcm2835_defconfig) + FW 2019-02-12 => okay
Linux 5.3 (bcm2835_defconfig + ZONE_DMA) + FW 2019-02-12 => okay
Linux 5.5-rc1 (bcm2835_defconfig) + FW 2019-02-12 => okay
Linux 5.5-rc1 (multi_v7_defconfig) + FW 2019-02-12 => okay

So please provide more information about your RPi 3B+ setup:

- VC firmware version
- additional bootloader (U-Boot)
- boot source (SD card, USB, network)
- kernel config

Did you tested the mainline kernel or the letux kernel?

Best regards
Stefan
