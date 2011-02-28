From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v10 05/18] OMAP2,3 DSS2 Change driver name to
 omap_display
Date: Mon, 28 Feb 2011 16:57:36 +0200
Message-ID: <1298905056.9809.128.camel@deskari>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com>
	 <1295850125-21405-6-git-send-email-sumit.semwal@ti.com>
	 <1298539643.16119.54.camel@deskari> <1298876015.2096.36.camel@deskari>
	 <4D6B4A1A.9000304@ti.com> <1298877549.2096.47.camel@deskari>
	 <4D6B88BB.5010200@ti.com> <1298895026.9809.27.camel@deskari>
	 <4D6BAA8C.2020203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42609 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754421Ab1B1O5o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 09:57:44 -0500
In-Reply-To: <4D6BAA8C.2020203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Taneja, Archit" <archit@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>

On Mon, 2011-02-28 at 08:00 -0600, Cousson, Benoit wrote:
> On 2/28/2011 1:10 PM, Valkeinen, Tomi wrote:
> > On Mon, 2011-02-28 at 05:36 -0600, Cousson, Benoit wrote:
> >> Hi Tomi,
> >>
> >> On 2/28/2011 8:19 AM, Valkeinen, Tomi wrote:
> >>> On Mon, 2011-02-28 at 01:09 -0600, Taneja, Archit wrote:
> >>>> Hi,
> >>>>
> >>>> On Monday 28 February 2011 12:23 PM, Valkeinen, Tomi wrote:
> >>>>> On Thu, 2011-02-24 at 03:27 -0600, Tomi Valkeinen wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> On Mon, 2011-01-24 at 11:51 +0530, ext Sumit Semwal wrote:
> >>>>>>> From: Senthilvadivu Guruswamy<svadivu@ti.com>
> >>>>>>>
> >>>>>>> Change the driver name from omapdss to omap_display as the driver takes care of
> >>>>>>> the display devices ie number of panels, type of panels available in the
> >>>>>>> platform.  Change the device name in the board files and 2420,2430,3xxx clock
> >>>>>>> files from omapdss to omap_display to match the driver name.
> >>>>>>
> >>>>>> I just realized that changing the driver name will break all scripts and
> >>>>>> applications using omapdss sysfs files.
> >>>>>>
> >>>>>> How does this sound:
> >>>>>>
> >>>>>> Let's leave the omapdss device name as it is. It represents a "super"
> >>>>>> device, containing the dss sysfs files and upper level dss management.
> >>
> >> This is the case for all the drivers migrated to omap_device anyway due
> >> to the change in the top level hierarchy. Everything is below
> >> platform/omap now.
> >
> > The HW module drivers are under platform/omap/, but omapdss is in
> > platform/. Do you mean that omapdss should also be under platform/omap/?
> 
> This is because you are probably not using omap_device yet. is should 
> happen when you will change your platform_device to be omap_device.

Hmm. The HW module devices use omap_device. But we have also a
"management" device, omapdss, which is doesn't match directly to any HW
component but manages the HW module drivers. It contains, so to say, the
HW module drivers.

Should this device also be a omap_device? What does omap_device actually
represent? My understanding is that omap_device is a linux device for a
HW block inside OMAP. omapdss doesn't quite match that definition.

> > The reason I'm unwilling to change omapdss name, or location, is that
> > omapdss directory contains lots of DSS configuration files, used by
> > scripts and programs.
> 
> Is that used for debug only?

Unfortunately no. DSS contains many features which cannot be exported to
userspace via the framebuffer device. While I'm not really happy with
the current omapdss sysfs interface, it's the best we've come up with.

 Tomi


