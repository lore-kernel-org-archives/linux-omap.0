From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 03/27] OMAP: DSS2: Reset LANEx_ULPS_SIG2 bits after use
Date: Mon, 06 Jun 2011 10:21:34 +0300
Message-ID: <1307344894.1910.1.camel@deskari>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307095237-14805-4-git-send-email-tomi.valkeinen@ti.com>
	 <4DEC6889.6020607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:58708 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751506Ab1FFHVk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 03:21:40 -0400
In-Reply-To: <4DEC6889.6020607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>

On Mon, 2011-06-06 at 11:11 +0530, Archit Taneja wrote:
> Hi,
> 
> On Friday 03 June 2011 03:30 PM, Valkeinen, Tomi wrote:
> > LANEx_ULPS_SIG2 bits are left on after entering ULPS. This doesn't cause
> > any problems currently, as DSI HW is reset when it is enabled. However,
> > if the reset is not done, operation fails if the bits are still set.
> >
> > So reset the bits after entering ULPS to ensure operation even without
> > HW reset.
> >
> > Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> > ---
> >   drivers/video/omap2/dss/dsi.c |    4 ++++
> >   1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> > index 69c2d4f..4496d09 100644
> > --- a/drivers/video/omap2/dss/dsi.c
> > +++ b/drivers/video/omap2/dss/dsi.c
> > @@ -3395,6 +3395,10 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
> >   	dsi_unregister_isr_cio(dsidev, dsi_completion_handler,&completion,
> >   			DSI_CIO_IRQ_ULPSACTIVENOT_ALL0);
> >
> > +	/* Reset LANEx_ULPS_SIG2 */
> > +	REG_FLD_MOD(dsidev, DSI_COMPLEXIO_CFG2, (0<<  0) | (0<<  1) | (0<<  2),
> > +		7, 5);
> > +
> 
> We may need to reset more lanes based on the number of lanes the panel 
> is using. We could calculate a mask here instead.

Yes, I noticed that but I decided just to fix the bug here. The same
bits are set a few lines earlier.

We should go through all the lane configs in dsi.c, and come up with a
way to easily get the necessary masks.

 Tomi


