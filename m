From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC][RFT][PATCH] OMAPFB: LCDC: change update_mode to DISABLED when going suspend
Date: Tue, 25 May 2010 19:31:56 +0200
Message-ID: <201005251931.58157.jkrzyszt@tis.icnet.pl>
References: <201005170320.29580.jkrzyszt@tis.icnet.pl> <201005231409.44541.jkrzyszt@tis.icnet.pl> <1274685963.2265.3.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:38374 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756407Ab0EYRc2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 13:32:28 -0400
In-Reply-To: <1274685963.2265.3.camel@tubuntu.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Monday 24 May 2010 09:26:03 Tomi Valkeinen napisa=C5=82(a):
> Hi,
>
> On Sun, 2010-05-23 at 14:09 +0200, ext Janusz Krzysztofik wrote:
> > Monday 17 May 2010 03:20:13 Janusz Krzysztofik wrote:
> > > I was observing the following error messages on my OMAP1 based Am=
strad
> > > Delta board when first changing from text to graphics mode or vic=
e
> > > versa after the LCD display had been blanked:
> > > 	omapfb omapfb: timeout waiting for FRAME DONE
> > > with a followup error message while unblanking it back:
> > > 	omapfb omapfb: resetting (status 0xffffffb2,reset count 1)
> > > As a visible result, image pixels happened to be shifted by a few=
 bits,
> > > giving wrong colors.
> > >
> > > Examining the code, I found that this problem occures when an OMA=
P1
> > > internal LCD controller is disabled from omap_lcdc_suspend() and =
then a
> > > subsequent omap_lcdc_setup_plane() calls disable_controller() aga=
in.
> > > This potentially error provoking behaviour is triggered by the
> > > lcdc.update_mode flag being kept at OMAP_AUTO_UPDATE, regardless =
of the
> > > controller and panel being suspended.
> > >
> > > This patch tries to correct the problem by replacing both
> > > omap_lcdc_suspend() and omap_lcdc_resume() function bodies with s=
ingle
> > > calls to
> > > omap_lcdc_set_update_mode() with a respective OMAP_UPDATE_DISABLE=
 or
> > > OMAP_AUTO_UPDATE argument. As a result, exactly the same lower le=
vel
> > > operations are performed, with addition of changing the
> > > lcdc.update_mode flag to a value better suited for the controller
> > > state. This prevents any further calls to disable_controller() fr=
om
> > > omap_lcdc_setup_plane() while the display is suspended.
> >
> > Hi,
> >
> > One more week of successfull, trouble-free testing on my side. Alth=
ough
> > there were no other test reports, no objections nor change requests=
 were
> > raised as well on this relatively simple and straightforward patch.=
 Could
> > we then agree on it being accepted for inclusion? Tomi?
>
> Yep, looks ok to me. Applied to DSS tree.

Tomi,
Thanks, you were so fast that I missed asking you if it could still be =
pushed=20
as a fix in the upcoming 2.6.35-rc cycle.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
