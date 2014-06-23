From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] ARM: DRA7: hwmod: fixes for 3.16
Date: Mon, 23 Jun 2014 16:34:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406231634210.29849@utopia.booyaka.com>
References: <1403093816-10960-1-git-send-email-rogerq@ti.com> <alpine.DEB.2.02.1406230450460.27636@utopia.booyaka.com> <53A83DAC.6050504@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53A83DAC.6050504@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, tony@atomide.com, rnayak@ti.com, nm@ti.com, kishon@ti.com, george.cherian@ti.com, balbi@ti.com, balajitk@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 23 Jun 2014, Sekhar Nori wrote:

> On Monday 23 June 2014 10:27 AM, Paul Walmsley wrote:
> > Hi Roger
> > 
> > On Wed, 18 Jun 2014, Roger Quadros wrote:
> > 
> >> These patches add the missing OCP2SCP3 module and fixup the SATA hwmod
> >> for DRA7 SoC. Both patches are tested on 3.16-rc1.
> > 
> > Could you please post a quick serial capture of a boot log for these 
> > patches, as Felipe has done for other patches?
> 
> Roger is OOO so posting the logs on his behalf.
> 
> $ git log -3
> 3e0ca738 4 minutes ago  (HEAD) ARM: DRA7: hwmod: Add OCP2SCP3 module
> 9961b81 4 minutes ago  ARM: DRA7: hwmod: Fixup SATA hwmod
> 7171511 7 days ago  (v3.16-rc1, linus-git/master) Linux 3.16-rc1
> 
> Attached is the minicom capture.

Thanks, so can I add your Tested-by: ?

- Paul
