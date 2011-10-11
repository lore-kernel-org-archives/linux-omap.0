From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/6 v3] omap: musb: Adding hwmod data for ti81xx
Date: Tue, 11 Oct 2011 15:07:46 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404ECCE5552@dbde02.ent.ti.com>
References: <1315576070-7618-1-git-send-email-ajay.gupta@ti.com>
 <1315576070-7618-2-git-send-email-ajay.gupta@ti.com>
 <19F8576C6E063C45BE387C64729E739404ECA545E3@dbde02.ent.ti.com>
 <20111007085614.GD10910@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404ECB6B70F@dbde02.ent.ti.com>
 <20111010054435.GA31653@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404ECCE551F@dbde02.ent.ti.com>
 <20111011091055.GE10155@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111011091055.GE10155-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> On Tue, Oct 11, 2011 at 02:13:07PM +0530, Gupta, Ajay Kumar wrote:
> > Hi,
> > > On Mon, Oct 10, 2011 at 10:40:55AM +0530, Gupta, Ajay Kumar wrote:
> > > > Hi,
> > > > > On Mon, Sep 26, 2011 at 03:21:07PM +0530, Gupta, Ajay Kumar
> wrote:
> > > > > > > To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > > > > Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Balbi, Felipe;
> > > > > > > tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; B, Ravi; Cousson, Benoit; Gupta, Ajay
> > > > > > > Kumar
> > > > > > > Subject: [PATCH 1/6 v3] omap: musb: Adding hwmod data for
> > > > > > > ti81xx
> > > > > >
> > > > > > Felipe,
> > > > > > I am planning to send patch 1/6 along with next revision of
> > > > > > ti81xx hwmod baseport patch from Hemant so that all hwmod data
> > > > > > gets reviewed at one place.
> > > > > >
> > > > > > So now only rest 5 (2/6 to 6/6) patches needs to be queued for
> > > usb.
> > > > > >
> > > > > > I hope this will be fine with you. Let me know if you want me
> > > > > > to post Same 5 patches separately.
> > > > >
> > > > > I guess it's better to queue them separately. I will only take
> > > > > whatever lies in drivers/usb/musb
> > > >
> > > > Ok fine so usb hwmod patch will come from Hemant in his hwmod
> > > > baseport Series. I will resubmit the one patch fixing your
> comment.
> > >
> > > ok cool, tks.
> > >
> > > For you platform_data stuff (if you have any), you can add a header
> > > to include/linux/platform_data/musb-dsps.h
> >
> > I need to access "struct omap_musb_board_data" and so would add
> > "#include <plat/usb.h>" in new file drivers/usb/musb/musb_dsps.h.
> >
> > Any comment ?
> 
> It would be nice to move that platform_data from <plat> to
> <linux/platform_data>

Yes, correct. But that would need change at below files.

arch/arm/mach-omap2/board-4430sdp.c:static struct omap_musb_board_data musb_board_data = {
arch/arm/mach-omap2/board-am3517evm.c:static struct omap_musb_board_data musb_board_data = {
arch/arm/mach-omap2/board-omap3evm.c:static struct omap_musb_board_data musb_board_data = {
arch/arm/mach-omap2/board-rx51.c:static struct omap_musb_board_data musb_board_data = {
arch/arm/mach-omap2/board-omap4panda.c:static struct omap_musb_board_data musb_board_data = {
arch/arm/mach-omap2/board-ti8168evm.c:static struct omap_musb_board_data musb_board_data = {
arch/arm/mach-omap2/board-omap4pcm049.c:static struct omap_musb_board_data musb_board_data = {
arch/arm/mach-omap2/usb-musb.c:static void usb_musb_mux_init(struct omap_musb_board_data *board_data)
arch/arm/mach-omap2/board-ti8148evm.c:static struct omap_musb_board_data musb_board_data = {
arch/arm/mach-omap2/board-am335xevm.c:static struct omap_musb_board_data musb_board_data = {
arch/arm/mach-omap2/board-ti8148evm.c.orig:static struct omap_musb_board_data musb_board_data = {
arch/arm/mach-omap2/board-omap3evm.c.orig:static struct omap_musb_board_data musb_board_data = {
drivers/usb/musb/am35x.c:
drivers/usb/musb/musb_dsps.c
drivers/usb/musb/omap2430.c:

I think this can be done in a separate patch and let the ti81xx 6/6
Patch to remain same. 

The separate patch will replace "#include <plat/usb.h>" to
"#include <platform_data/usb.h>"

Ajay

> 
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
