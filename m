From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 1/6 v3] omap: musb: Adding hwmod data for ti81xx
Date: Tue, 11 Oct 2011 15:32:01 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404ECCE5570@dbde02.ent.ti.com>
References: <1315576070-7618-1-git-send-email-ajay.gupta@ti.com>
 <1315576070-7618-2-git-send-email-ajay.gupta@ti.com>
 <19F8576C6E063C45BE387C64729E739404ECA545E3@dbde02.ent.ti.com>
 <20111007085614.GD10910@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404ECB6B70F@dbde02.ent.ti.com>
 <20111010054435.GA31653@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404ECCE551F@dbde02.ent.ti.com>
 <20111011091055.GE10155@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404ECCE5552@dbde02.ent.ti.com>
 <20111011094309.GF10155@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52262 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332Ab1JKKCP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Oct 2011 06:02:15 -0400
In-Reply-To: <20111011094309.GF10155@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "B, Ravi" <ravibabu@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hi,
> > > On Tue, Oct 11, 2011 at 02:13:07PM +0530, Gupta, Ajay Kumar wrote:
> > > > Hi,
> > > > > On Mon, Oct 10, 2011 at 10:40:55AM +0530, Gupta, Ajay Kumar
> wrote:
> > > > > > Hi,
> > > > > > > On Mon, Sep 26, 2011 at 03:21:07PM +0530, Gupta, Ajay Kumar
> > > wrote:
> > > > > > > > > To: linux-omap@vger.kernel.org
> > > > > > > > > Cc: linux-usb@vger.kernel.org; Balbi, Felipe;
> > > > > > > > > tony@atomide.com; B, Ravi; Cousson, Benoit; Gupta, Ajay
> > > > > > > > > Kumar
> > > > > > > > > Subject: [PATCH 1/6 v3] omap: musb: Adding hwmod data
> > > > > > > > > for ti81xx
> > > > > > > >
> > > > > > > > Felipe,
> > > > > > > > I am planning to send patch 1/6 along with next revision
> > > > > > > > of ti81xx hwmod baseport patch from Hemant so that all
> > > > > > > > hwmod data gets reviewed at one place.
> > > > > > > >
> > > > > > > > So now only rest 5 (2/6 to 6/6) patches needs to be queued
> > > > > > > > for
> > > > > usb.
> > > > > > > >
> > > > > > > > I hope this will be fine with you. Let me know if you want
> > > > > > > > me to post Same 5 patches separately.
> > > > > > >
> > > > > > > I guess it's better to queue them separately. I will only
> > > > > > > take whatever lies in drivers/usb/musb
> > > > > >
> > > > > > Ok fine so usb hwmod patch will come from Hemant in his hwmod
> > > > > > baseport Series. I will resubmit the one patch fixing your
> > > comment.
> > > > >
> > > > > ok cool, tks.
> > > > >
> > > > > For you platform_data stuff (if you have any), you can add a
> > > > > header to include/linux/platform_data/musb-dsps.h
> > > >
> > > > I need to access "struct omap_musb_board_data" and so would add
> > > > "#include <plat/usb.h>" in new file drivers/usb/musb/musb_dsps.h.
> > > >
> > > > Any comment ?
> > >
> > > It would be nice to move that platform_data from <plat> to
> > > <linux/platform_data>
> >
> > Yes, correct. But that would need change at below files.
> >
> > arch/arm/mach-omap2/board-4430sdp.c:static struct omap_musb_board_data
> > musb_board_data = { arch/arm/mach-omap2/board-am3517evm.c:static
> > struct omap_musb_board_data musb_board_data = {
> > arch/arm/mach-omap2/board-omap3evm.c:static struct
> > omap_musb_board_data musb_board_data = {
> > arch/arm/mach-omap2/board-rx51.c:static struct omap_musb_board_data
> > musb_board_data = { arch/arm/mach-omap2/board-omap4panda.c:static
> > struct omap_musb_board_data musb_board_data = {
> > arch/arm/mach-omap2/board-ti8168evm.c:static struct
> > omap_musb_board_data musb_board_data = {
> > arch/arm/mach-omap2/board-omap4pcm049.c:static struct
> > omap_musb_board_data musb_board_data = {
> > arch/arm/mach-omap2/usb-musb.c:static void usb_musb_mux_init(struct
> > omap_musb_board_data *board_data)
> > arch/arm/mach-omap2/board-ti8148evm.c:static struct
> > omap_musb_board_data musb_board_data = {
> > arch/arm/mach-omap2/board-am335xevm.c:static struct
> > omap_musb_board_data musb_board_data = {
> > arch/arm/mach-omap2/board-ti8148evm.c.orig:static struct
> > omap_musb_board_data musb_board_data = {
> > arch/arm/mach-omap2/board-omap3evm.c.orig:static struct
> > omap_musb_board_data musb_board_data = {
> > drivers/usb/musb/am35x.c:
> > drivers/usb/musb/musb_dsps.c
> > drivers/usb/musb/omap2430.c:
> >
> > I think this can be done in a separate patch and let the ti81xx 6/6
> > Patch to remain same.
> >
> > The separate patch will replace "#include <plat/usb.h>" to "#include
> > <platform_data/usb.h>"
> 
> cool, that can be done with a sed script ;-)

Ok fine then I will send the refreshed 5 patch set for ti81xx and 3 patch set
for am335x correcting your comments.

Thanks,
Ajay
> 
> --
> balbi
