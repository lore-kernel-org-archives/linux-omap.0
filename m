From: Paul Zimmerman <Paul.Zimmerman@synopsys.com>
Subject: RE: Booting recent mainline on omap5-uevm
Date: Thu, 26 Sep 2013 19:36:10 +0000
Message-ID: <A2CA0424C0A6F04399FB9E1CD98E030458E06505@US01WEMBX2.internal.synopsys.com>
References: <A2CA0424C0A6F04399FB9E1CD98E030458E05AC1@US01WEMBX2.internal.synopsys.com>
 <52421139.1090005@ti.com> <524224CC.5010707@ti.com>
 <A2CA0424C0A6F04399FB9E1CD98E030458E05BDB@US01WEMBX2.internal.synopsys.com>
 <5242FB0F.7090704@ti.com> <52432D53.8090801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from us02smtp1.synopsys.com ([198.182.60.75]:59143 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab3IZTgM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Sep 2013 15:36:12 -0400
In-Reply-To: <52432D53.8090801@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "lokeshvutla@ti.com" <lokeshvutla@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> From: Suman Anna [mailto:s-anna@ti.com]
> Sent: Wednesday, September 25, 2013 11:37 AM
> 
> On 09/25/2013 10:02 AM, Santosh Shilimkar wrote:
> > On Tuesday 24 September 2013 07:59 PM, Paul Zimmerman wrote:
> >>> From: Suman Anna [mailto:s-anna@ti.com]
> >>> Sent: Tuesday, September 24, 2013 4:48 PM
> >>>
> >>> On 09/24/2013 05:24 PM, Santosh Shilimkar wrote:
> >>>> On Tuesday 24 September 2013 04:30 PM, Paul Zimmerman wrote:
> >>>>>> From: Paul Zimmerman
> >>>>>> Sent: Tuesday, September 24, 2013 1:21 PM
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> I have an OMAP5432 uEVM which I cannot get to boot with recent mainline
> >>>>>> (tried 3.11 and 3.12-rc1). I have the TI GLSDK for this board (v6.0.0.7),
> >>>>>> which comes with 3.8.4 which works fine.
> >>>>>>
> >>>>>> I found this thread: http://marc.info/?l=fedora-arm&m=137717811815777 and
> >>>>>
> >>>>> Wrong link, should have been http://marc.info/?l=linux-omap&m=137515583214350.
> >>>>>
> >>>> Its because of commit 03ab349ec{ARM: OMAP5: hwmod data: Add mailbox data} which
> >>>> added hwmod data but DT data for mailbox is missing. Reverting that makes
> >>>> things work. Looks like mailbox dt patches missed the last merge window.
> >>>
> >>> I will be respinning the mailbox DT series very soon targeting 3.13, so
> >>> should not be an issue when OMAP5 boot is supported directly on mainline.
> >>
> >> That's good info, but unfortunately it didn't work for me. I must have a
> >> different problem, maybe I need a newer version of u-boot.
> >>
> >> So there is no README or wiki that explains how to get Linux to boot on
> >> this board? Is there perhaps a prebuilt SD card image somewhere with a
> >> recent kernel that I can grab?
> >>
> > You don't need anything special as such. Just pull the latest mainline
> > denx u-boot build it for 'omap5_uevm' and update your boot-loaders.
> 
> FYI, I was able to boot using the branch posted by Santosh just fine. I
> used v2013.07 u-boot. The boot traces show up about 30~45 seconds after
> you see the trace "Starting kernel...".
> 
> For using a rootfs from MMC, enable the following in menuconfig:
>   Device Drivers -> Multifunction device drivers -> TI Palmas series chips
>   Device Drivers -> Voltage and Current Regulator Support -> TI Palmas
> PMIC regulators.
> 
> Depending on your u-boot settings, make sure the mmcroot is also set to
> /dev/mmcblk1p2.

Hi Suman,

Thanks for trying to help. Unfortunately, updating to v2013.07 u-boot, and
enabling the kernel config items you mentioned, didn't make a difference.

Could you share your boot.scr? I'm still using the one from the TI GLSDK,
but maybe something has changed since the 3.8 kernel? Also, how do you
build your kernel? I'm doing "make LOADADDR=0x80008000 uImage" because
newer kernels won't build without the LOADADDR= bit.

I guess you TI guys know how all this works, but for an outsider like me
it's not so clear ;)

-- 
Paul

