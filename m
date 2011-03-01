From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: RE: [PATCH 04/10 v1] arm: omap: usb: create common enums and
 structures for ehci and ohci
Date: Tue, 1 Mar 2011 18:13:29 +0530
Message-ID: <47bb1092522c195a91f292c701d9aad3@mail.gmail.com>
References: <1298910712-2051-1-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-2-git-send-email-keshava_mgowda@ti.com> <1298910712-2051-3-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-4-git-send-email-keshava_mgowda@ti.com> <1298910712-2051-5-git-send-email-keshava_mgowda@ti.com>
 <20110301104940.GS2942@legolas.emea.dhcp.ti.com> <d228b38c51a625e4a8aa37aaa9253d70@mail.gmail.com>
 <20110301123543.GY2942@legolas.emea.dhcp.ti.com> <20110301123758.GZ2942@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:32988 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754585Ab1CAMnb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 07:43:31 -0500
In-Reply-To: <20110301123758.GZ2942@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Anand Gadiyar <gadiyar@ti.com>, Partha Basak <p-basak2@ti.com>

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Tuesday, March 01, 2011 6:08 PM
> To: Felipe Balbi
> Cc: Keshava Munegowda; linux-usb@vger.kernel.org;
linux-omap@vger.kernel.org; Anand Gadiyar; Partha
> Basak
> Subject: Re: [PATCH 04/10 v1] arm: omap: usb: create common enums and
structures for ehci and ohci
>
> On Tue, Mar 01, 2011 at 02:35:43PM +0200, Felipe Balbi wrote:
> > On Tue, Mar 01, 2011 at 05:07:34PM +0530, Keshava Munegowda wrote:
> > > > -----Original Message-----
> > > > From: Felipe Balbi [mailto:balbi@ti.com]
> > > > Sent: Tuesday, March 01, 2011 4:20 PM
> > > > To: Keshava Munegowda
> > > > Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org;
balbi@ti.com;
> > > gadiyar@ti.com; p-
> > > > basak2@ti.com
> > > > Subject: Re: [PATCH 04/10 v1] arm: omap: usb: create common enums
and
> > > structures for ehci and ohci
> > > >
> > > > On Mon, Feb 28, 2011 at 10:01:46PM +0530, Keshava Munegowda wrote:
> > > > > Create the ehci and ohci specific platform data structures.
> > > > > The port enum values are made common for both ehci and ohci.
> > > > >
> > > > > Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> > > >
> > > > Applying: arm: omap: usb: create common enums and structures for
ehci
> > > and ohci
> > > > error: patch failed: drivers/usb/host/ehci-omap.c:409
> > > > error: drivers/usb/host/ehci-omap.c: patch does not apply
> > > > Patch failed at 0005 arm: omap: usb: create common enums and
structures
> > > for ehci and ohci
> > > > When you have resolved this problem run "git am --resolved".
> > > > If you would prefer to skip this patch, instead run "git am
--skip".
> > > > To restore the original branch and stop patching run "git am
--abort".
> > > >
> > > > Which tree did you use as base for these patches ? I'm trying to
apply
> > > > on top of v.2.6.38-rc6
> > >
> > > Balbi
> > >
> > > I tried at my side on l2.6.38-rc6 , it dint see any failures its
working.
> > >
> > > These patches are apply correctly on l2.6.38-rc6
> > > Commit id: f5412be599602124d2bdd49947b231dd77c0bf99
> > >
> > > Please check; its working my side.
> >
> > You have to rebase on top of this patch which is going to mainline:
>
> BTW, bear in mind you should not cause a regression of that patch. A
> simple rebase is easy to do, but you cannot remove that feature
> introduced by Anand.

Yes, I will do the rebase, and I will send patches soon.





> --
> balbi
