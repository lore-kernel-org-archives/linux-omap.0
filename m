From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Gta04-owner] [PATCH 5/6] phy: twl4030-usb: add support for
 reading resistor on ID pin.
Date: Tue, 2 Jun 2015 22:11:43 +0200
Message-ID: <20150602201143.GA26412@amd>
References: <20150416075945.23307.24424.stgit@notabene.brown>
 <20150416080304.23307.41913.stgit@notabene.brown>
 <556C5FF4.3050603@ti.com>
 <20150602073731.26edbd3b@notabene.brown>
 <556DB481.3080906@ti.com>
 <C1222390-F14D-4E47-9F53-CD4646BF4450@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <C1222390-F14D-4E47-9F53-CD4646BF4450@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, NeilBrown <neilb@suse.de>, Tony Lindgren <tony@atomide.com>, LKML <linux-kernel@vger.kernel.org>, NeilBrown <neil@brown.name>, linux-omap <linux-omap@vger.kernel.org>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

On Tue 2015-06-02 16:06:47, Dr. H. Nikolaus Schaller wrote:
> Hi,
> 
> Am 02.06.2015 um 15:49 schrieb Kishon Vijay Abraham I <kishon@ti.com>:
> 
> > Hi,
> > 
> > On Tuesday 02 June 2015 03:07 AM, NeilBrown wrote:
> >> On Mon, 1 Jun 2015 19:06:52 +0530 Kishon Vijay Abraham I <kishon@ti.com>
> >> wrote:
> >> 
> >>> Hi,
> >>> 
> >>> On Thursday 16 April 2015 01:33 PM, NeilBrown wrote:
> >>>> From: NeilBrown <neilb@suse.de>
> >>>> 
> >>>> The twl4030 phy can measure, with low precision, the
> >>>> resistance-to-ground of the ID pin.
> >>>> 
> >>>> Add a function to read the value, and export the result
> >>>> via sysfs.
> >>> 
> >>> Little sceptical about adding new sysfs entries. Do you have a good reason to
> >>> add this?
> >> 
> >> The hardware can report the value, so why not present it to user-space?
> >> 
> >> I originally used this with a udev rule which would configure the maximum
> >> current based on the resistance measure - to work with the particular charger
> >> hardware I have.
> >> 
> >> More recent patches try to do all of the max-current configuration in the
> >> kernel, so I could live without exporting the value via sysfs if that is a
> >> show-stopper.
> >> 
> >> I can't see where the scepticism comes from though.  It is a well defined
> >> and cleary documented feature of the hardware.  Why not expose it?

Is it well defined enough that it will work on other chargers, too?

> > ABI can never be removed or modified later. So should be really careful before adding it.
> 
> Is /sys considered ABI?

Yes.

> User space developers are always reminded not to rely on /sys nodes.

No.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
