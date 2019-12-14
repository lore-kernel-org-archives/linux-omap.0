From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: BUG - was: [GIT PULL 2/3] bcm2835-soc-next-2019-10-15
Date: Sat, 14 Dec 2019 21:02:56 +0100
Message-ID: <A0CE3E97-00E3-401F-AB89-153700B4D93F@goldelico.com>
References: <1571159725-5090-1-git-send-email-wahrenst@gmx.net>
 <1571159725-5090-2-git-send-email-wahrenst@gmx.net>
 <12244E4E-A1A0-4EE9-ACD3-EA165D9A2C79@goldelico.com>
 <f6f38340-2555-7907-6b89-748c34cd2978@gmx.net>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f6f38340-2555-7907-6b89-748c34cd2978@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux-OMAP <linux-omap@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi all,
I think I have found the issue, it is not ZONE_DMA, see below.

> Am 14.12.2019 um 17:54 schrieb Stefan Wahren <wahrenst@gmx.net>:
> 
> Hi Nikolaus,
> 
> [add Nicolas as the new BCM2835 maintainer]
> 
> Am 14.12.19 um 11:54 schrieb H. Nikolaus Schaller:
>> Hi Stefan,
>> 
>>> Am 15.10.2019 um 19:15 schrieb Stefan Wahren <wahrenst@gmx.net>:
>>> 
>>> Hi Florian,
>>> 
>>> The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:
>>> 
>>> Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
>>> 
>>> are available in the git repository at:
>>> 
>>> git://github.com/anholt/linux tags/bcm2835-soc-next-2019-10-15
>>> 
>>> for you to fetch changes up to 781fa0a954240c8487683ddf837fb2c4ede8e7ca:
>>> 
>>> ARM: bcm: Add support for BCM2711 SoC (2019-10-10 19:21:03 +0200)
>> this patch has finally arrived in v5.5-rc1 but it seems to break
>> multiplatform build.
>> 
>> We run a distribution kernel that supports OMAP3/4/5, i.MX6 and RasPi 3B+
>> but since rebasing to v5.5-rc1 the kernel hangs after "Starting Kernel ...".
>> On all ARM devices (incl. RasPi 3B+).
> 
> i wasn't able to reproduce this issue with the RPi 3B+ so far and i
> don't have any OMAP hardware:
> 
> Linux 5.3 (bcm2835_defconfig) + FW 2019-02-12 => okay
> Linux 5.3 (bcm2835_defconfig + ZONE_DMA) + FW 2019-02-12 => okay
> Linux 5.5-rc1 (bcm2835_defconfig) + FW 2019-02-12 => okay
> Linux 5.5-rc1 (multi_v7_defconfig) + FW 2019-02-12 => okay
> 
> So please provide more information about your RPi 3B+ setup:
> 
> - VC firmware version
> - additional bootloader (U-Boot)
> - boot source (SD card, USB, network)
> - kernel config
> 
> Did you tested the mainline kernel or the letux kernel?

On the OMAP I did test the mainline kernel with omap2plus_defconfig.
RasPi 3B+ experiment was with Letux kernel and config.


But I was lucky to find the issue by code inspection:

bcm2711_compat[] is missing a NULL sentinel.

Therefore, enabling CONFIG_ARCH_BCM2835 is sufficient to trigger the
problem unless you may have been lucky getting something starting with
a NULL packed after it on your bcm2835_defconfig or multi_v7_defconfig
build.

Patch submitted.

BR,
Nikolaus
