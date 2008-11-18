From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [Linux-fbdev-devel] [REVIEW  PATCH 0/9] DSS: Series description
Date: Tue, 18 Nov 2008 14:06:04 +0200
Message-ID: <1227009964.6860.103.camel@tubuntu>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02E228767B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:38762 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbYKRMGT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2008 07:06:19 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02E228767B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Shah, Hardik" <hardik.shah@ti.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, 2008-11-18 at 12:10 +0530, ext Shah, Hardik wrote:
> 
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > Sent: Tuesday, November 04, 2008 9:40 PM
> > To: linux-fbdev-devel@lists.sourceforge.net
> > Cc: linux-omap@vger.kernel.org
> > Subject: [Linux-fbdev-devel] [REVIEW PATCH 0/9] DSS: Series description
> > 
> > New Display Subsystem for OMAP2/3
> > ---------------------------------
> > 

[snip]

> >
> [Shah, Hardik] Hi Tomi,
> We are successful to bring up the basic functionality of the V4L2 driver onto your patches.  We will be posting those patches in a day or two. Based on our V4L2 driver development we have few questions/suggestions on DSS patches you submitted. 
> 1.	Display enable function is returning false if the display is already 	enabled.  Instead it should just return without error if display is 	already enabled as V4L2 and fbdev both may be enabling it without each 	other's knowledge.
> 
> 2.	Second display enable/disable should maintain the reference count as 	disabling of the display by one driver will leave other driver without 	display.
> 
> 3.	I think the row increment value should not be calculate inside the dispc.c 	file instead high level driver will pass the value it requires based on 	his buffer requirement and dispc.c should program it dumbly.  This is 	mainly due to the odd row_inc_value requirement for the VRFB space.
> 
> 4.    There is API in dispc.c file to change pixel increment value.
> 
> 5.	We need separate API to enable the plane and enable the clocks. 	Once 	the clock is enabled driver can directly go and program registers 	through low level dispc APIs instead of dispc APIs enabling the clock for 	each register programming and then disabling it. 
> 	
> 	This will avoid the enabling and disabling of the clocks for each 	frame displayed.  As for V4L2 interface driver will enable 	planes and 	clocks during VIDIOC_STREAMON ioctls and during the streaming it will 	just change the buffer address for displaying frames. This way delay 	between the enabling/disabling of the clocks can also be saved.  It 	would be driver's responsibility to enable the clocks before programming 	any registers.  Same may be true for setting the GO bit of the respective 	overlay managers.
> 
> 6.	We also need a public API to program the color conversion values.  Some 	application may need to program it differently than standard values.
> 

These all sound valid changes to me, I will see to them. For the time
being, just make whatever hacks you need to get the V4L2 running. And
preferably mark these hacks with a comment, so it's easy to find them.

As for the 5. issue, I've been thinking the same thing. However, usually
the clocks are always on when the LCD is on. So even if there are
clk_enable() calls, all they do is increment the ref count. 

> 
> 
> Thanks and Regards,
> Hardik Shah
> Vaibhav Hiremath

 Tomi


