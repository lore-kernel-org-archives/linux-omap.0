From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/3] ARM: DRA7: hwmod: Add OCP2SCP3 module
Date: Sun, 6 Jul 2014 00:23:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407052355050.23762@utopia.booyaka.com>
References: <1404385274-5093-1-git-send-email-rogerq@ti.com> <1404385274-5093-2-git-send-email-rogerq@ti.com> <alpine.DEB.2.02.1407031948110.1515@utopia.booyaka.com> <53B678C1.4000807@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53B678C1.4000807@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, rnayak@ti.com, kishon@ti.com, george.cherian@ti.com, balbi@ti.com, balajitk@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi

On Fri, 4 Jul 2014, Roger Quadros wrote:

> On 07/03/2014 10:48 PM, Paul Walmsley wrote:
> > On Thu, 3 Jul 2014, Roger Quadros wrote:
> > 
> >> This module is needed for the SATA and PCIe PHYs.
> >>
> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >> Reviewed-by: Rajendra Nayak <rnayak@ti.com>
> >> Tested-by: Sekhar Nori <nsekhar@ti.com>>
> > 
> > This looks like adding support for a new device, so, after 
> > discussing with Tony, queuing for v3.17.
> 
> We should treat it as missing device (bug) rather than new device 
> (feature) as the corresponding device tree node is already present.
> Without this patch we get the following message in kernel boot log
> 
> [    0.261680] platform 4a090000.ocp2scp: Cannot lookup hwmod 'ocp2scp3'
> 
> I would consider this patch as a fix rather than a new feature.

Just to make sure I'm correctly applying the rules for sequencing -rc 
patches vs. merge window patches, could you please confirm my 
understanding of the situation:

1. The OCP2SCP3 device (and the devices that rely on it) never worked on 
DRA7xx in earlier kernels

2. Even with this support added, neither SATA nor PCIe will work in 3.16 
on DRA7xx (SATA for unknown reasons, PCIe because the patches are targeted 
for 3.17).

3. The warning doesn't prevent the machine from booting and does not 
impair any previously working functionality

4. There are other DRA7xx warning messages on boot in 3.16-rc: for 
example, http://paste.ubuntu.com/7701601/ lists:

[    0.009931] omap_hwmod: l3_main_2 using broken dt data from ocp

...

[    0.291802] platform 4e000000.dmm: Cannot lookup hwmod 'dmm'


Are these four statements correct?

If so, is there some other reason why we should rush this in for 3.16-rc?  
Put differently: how can we justify adding this device in 3.16-rc rather 
than 3.17 to Linus Torvalds?


- Paul
