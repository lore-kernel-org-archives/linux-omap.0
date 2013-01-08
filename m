From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC v2 00/18] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Tue, 8 Jan 2013 21:01:51 +0530
Message-ID: <50EC3BE7.8070704@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50834 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756632Ab3AHPa4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jan 2013 10:30:56 -0500
In-Reply-To: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@deeprootsystems.com

Vaibhav,

On Monday 31 December 2012 06:36 PM, Vaibhav Bedia wrote:
> Hi,
>
> This is the second version of the patch series for adding suspend-resume
> support for AM33XX. Based on the feedback received on the previous patch
> series [1] almost all the patches have undergone a bit a rework.
>
> The 1st two patches depend on the changes for mailbox code migration
> from arch/arm/*-omap*/ to drivers/mailbox/ [2].
>
> The patch series also depends on recent changes to the OMAP PM framework
> by Paul Walmsley.
>
> I found it easiest to apply the AM33XX suspend-resume patches on top of
> Paul's TEST_pwrdm_post_fpwrst_devel_a_3.9 branch + the patches @ [2].
>
> With these dependencies met, the PM code uses the firmware interface
> and expects the userspace to load the WKUP_M3 binary before the
> suspend-resume functionality is made available. The binary file (and
> the source-code for WKUP_M3) can be obtained from the 'next' branch at
> [3]. The WKUP_M3 binary can either be loaded post bootup via
> the sysfs entry './sys/devices/ocp.2/wkup_m3.4/firmware' or
> it can be included in the kernel image as part of the build process.
>
> DDR3 specific changes have been skipped for now since mainline U-Boot
> exhibited stability issues on all the DDR3 based AM335x boards that i could
> lay my hands on.
>
> I have done basic testing along with power measurments on the different
> power rails on the AM335x EVM. PER domain transition on the BeagleBone fails
> if the CPSW driver is included in the kernel and is yet to be root caused.
> Along with this issue more extensive testing on other OMAP platforms is also
> pending right now.
>
> For more details on the AM335x suspend-resume support please refer to the
> changelog in the different patches.
>
I still haven't reviewed patch 15, 16 and 18 which adds suspend support.
Will do that in coming days since they need a bit a closer look.

But as mentioned in some of the patches, you need to split this series
since except 15, 16 and 18 which adds suspend support, rest of the
patches are
- data file fixes
- timer suspend/resume update
- mailbox support, control module update.

Would be good to split the series to help the reviews.

Regards
Santosh


