From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC v2 00/18] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Wed, 9 Jan 2013 05:38:26 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECDD096@DBDE01.ent.ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <50EC3BE7.8070704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48877 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767Ab3AIFib convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jan 2013 00:38:31 -0500
In-Reply-To: <50EC3BE7.8070704@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hi Santosh,

On Tue, Jan 08, 2013 at 21:01:51, Shilimkar, Santosh wrote:
> Vaibhav,
> 
> On Monday 31 December 2012 06:36 PM, Vaibhav Bedia wrote:
> > Hi,
> >
> > This is the second version of the patch series for adding suspend-resume
> > support for AM33XX. Based on the feedback received on the previous patch
> > series [1] almost all the patches have undergone a bit a rework.
> >
> > The 1st two patches depend on the changes for mailbox code migration
> > from arch/arm/*-omap*/ to drivers/mailbox/ [2].
> >
> > The patch series also depends on recent changes to the OMAP PM framework
> > by Paul Walmsley.
> >
> > I found it easiest to apply the AM33XX suspend-resume patches on top of
> > Paul's TEST_pwrdm_post_fpwrst_devel_a_3.9 branch + the patches @ [2].
> >
> > With these dependencies met, the PM code uses the firmware interface
> > and expects the userspace to load the WKUP_M3 binary before the
> > suspend-resume functionality is made available. The binary file (and
> > the source-code for WKUP_M3) can be obtained from the 'next' branch at
> > [3]. The WKUP_M3 binary can either be loaded post bootup via
> > the sysfs entry './sys/devices/ocp.2/wkup_m3.4/firmware' or
> > it can be included in the kernel image as part of the build process.
> >
> > DDR3 specific changes have been skipped for now since mainline U-Boot
> > exhibited stability issues on all the DDR3 based AM335x boards that i could
> > lay my hands on.
> >
> > I have done basic testing along with power measurments on the different
> > power rails on the AM335x EVM. PER domain transition on the BeagleBone fails
> > if the CPSW driver is included in the kernel and is yet to be root caused.
> > Along with this issue more extensive testing on other OMAP platforms is also
> > pending right now.
> >
> > For more details on the AM335x suspend-resume support please refer to the
> > changelog in the different patches.
> >
> I still haven't reviewed patch 15, 16 and 18 which adds suspend support.
> Will do that in coming days since they need a bit a closer look.
> 
> But as mentioned in some of the patches, you need to split this series
> since except 15, 16 and 18 which adds suspend support, rest of the
> patches are
> - data file fixes
> - timer suspend/resume update
> - mailbox support, control module update.
> 
> Would be good to split the series to help the reviews.
> 

Sure. I'll split it up like you mentioned. Since all these changes are needed for
a working suspend-resume I kept it in a single series to reduce dependencies and
also to help set an initial context for the AM33xx PM changes.

Regards,
Vaibhav

