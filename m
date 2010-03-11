From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: compile break on dss2 branch for zoom3
Date: Thu, 11 Mar 2010 08:52:48 -0600
Message-ID: <A24693684029E5489D1D202277BE894453EFF8F0@dlee02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026EFB4FB9@dbde02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94026EFB5041@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41994 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757886Ab0CKOwx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 09:52:53 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026EFB5041@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Y, Kishore" <kishore.y@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Y, Kishore
> Sent: Thursday, March 11, 2010 7:29 AM
> To: Y, Kishore; Gadiyar, Anand; Tomi Valkeinen
> Cc: linux-omap@vger.kernel.org
> Subject: RE: compile break on dss2 branch for zoom3
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Y, Kishore
> > Sent: Thursday, March 11, 2010 5:23 PM
> > To: Gadiyar, Anand; Tomi Valkeinen
> > Cc: linux-omap@vger.kernel.org
> > Subject: RE: compile break on dss2 branch for zoom3
> >
> > > -----Original Message-----
> > > From: Gadiyar, Anand
> > > Sent: Thursday, March 11, 2010 5:18 PM
> > > To: Tomi Valkeinen; Y, Kishore
> > > Cc: linux-omap@vger.kernel.org
> > > Subject: RE: compile break on dss2 branch for zoom3
> > >
> > > Tomi Valkeinen wrote:
> > > >
> > > > On Thu, 2010-03-11 at 12:40 +0100, ext Y, Kishore wrote:
> > > > > Hi Tomi,
> > > > >       I am unable to compile dss2 tree for zoom3. Commit I am
> using
> > > following commit id
> > > > >
> > > > > 893d461b538e889da350061edaadeb8a9289913c
> > > > > OMAP: DSS2: quick hack for set mode
> > > > >
> > > > >
> > > > > Error I see is related to usb:-
> > > > > drivers/usb/core/hcd.c: In function 'usb_hcd_resume_root_hub':
> > > > > drivers/usb/core/hcd.c:1892: error: 'pm_wq' undeclared (first use
> in
> > > this function)
> > > > > drivers/usb/core/hcd.c:1892: error: (Each undeclared identifier is
> > > reported only once
> > > > > drivers/usb/core/hcd.c:1892: error: for each function it appears
> > in.)
> > > > > make[3]: *** [drivers/usb/core/hcd.o] Error 1
> > > > > make[2]: *** [drivers/usb/core] Error 2
> > > > > make[1]: *** [drivers/usb] Error 2
> > > > > make: *** [drivers] Error 2
> > > > >
> > > > > When I disable usb, build goes through but the board does not
> bootup
> > > with this image. It is stuck at uncompressing linux.
> > > >
> > > > Yes, mainstream linux tree seems to be broken. Not much I can do to
> > help
> > > > you there. You can try rebasing on top of later mainstrean version,
> > > > perhaps it's been fixed there.
> > > >
> > >
> > > I sent this patch [1] to linux-usb to fix this. It's yet to be queued
> > up.
> > > The alternative is to enable CONFIG_PM_RUNTIME in the build.
> > >
> > > Regards,
> > > Anand
> > >
> > > [1] http://marc.info/?l=linux-usb&m=126675883221098&w=2
> >
> > I will try this out.
> I have tried to use the main line which already has this patch. I am able
> to compile the code without any issues. But board still does not boot. Am
> I missing something?
> 
> My bootargs:
> setenv bootargs console=ttyS3,115200n8 noinitrd root=/dev/nfs rw
> nfsroot=192.168.223.72:/home/x0114913/fs1_inc2_rc0,nolock,rsize=1024,wsize
> =1024 rootdelay=0 ip=192.168.223.251 debug

Can you take this series:

http://marc.info/?l=linux-omap&m=126826639903105&w=2

And test with ttyS0?

Regards,
Sergio

> 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
