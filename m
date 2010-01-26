From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: RE: [alsa-devel] [PATCHv2 5/6] ASoC: OMAP4: Add support for McPDM
Date: Tue, 26 Jan 2010 10:25:01 +0000
Message-ID: <1264501501.3067.43.camel@odin>
References: <2256F256009DAA4CBE661E9F41EAC84B8C43A8B4@dlee01.ent.ti.com>
	 <1264211090.3480.141.camel@odin>
	 <2256F256009DAA4CBE661E9F41EAC84B8C4CEF35@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:60569 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab0AZKZG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 05:25:06 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1163895eyd.19
        for <linux-omap@vger.kernel.org>; Tue, 26 Jan 2010 02:25:04 -0800 (PST)
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B8C4CEF35@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

On Mon, 2010-01-25 at 15:06 -0600, Candelaria Villareal, Jorge wrote:
> Liam Girdwood wrote:
> >
> > On Fri, 2010-01-22 at 17:15 -0600, Candelaria Villareal, Jorge wrote:
> > > McPDM is the interface between Phoenix audio codec
> > > and the OMAP4430 processor. It enables data to be transfered
> > > to/from Phoenix at sample rates of 88.4 or 96 KHz.
> > >
> > > Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>
> > > Signed-off-by: Margarita Olaya <x0080101@ti.com>
> >
> > It initially looks like a some of this can be called directly
> > as DAI ops
> > rather than by the machine driver.
> 
> Could you explain a little further?

I was meaning here that some of the functions below are only called by
higher level Digital Audio Interface (DAI) operations. e.g. the
following is called by capture stream close :-


> > > + * Cleans McPDM uplink configuration.
> > > + * This function should be called when the stream is closed.
> > > + */
> > > +int omap_mcpdm_clr_uplink(struct omap_mcpdm_link *uplink)

Would probably be more meaningful wrt ALSA as
omap_mcpdm_capture_close() 


> > > +/*
> > > + * Takes the McPDM module in and out of reset state.
> > > + * Uplink and downlink can be reset individually.
> > > + */
> > > +static void omap_mcpdm_reset(int links, int reset)
> > > +{
> > > +       int ctrl = omap_mcpdm_read(MCPDM_CTRL);
> > > +
> > > +       if (links & MCPDM_UPLINK) {
> > > +               if (reset)
> > > +                       ctrl |= SW_UP_RST;
> > > +               else
> > > +                       ctrl &= ~SW_UP_RST;
> > > +       }
> > > +
> > > +       if (links & MCPDM_DOWNLINK) {
> > > +               if (reset)
> > > +                       ctrl |= SW_DN_RST;
> > > +               else
> > > +                       ctrl &= ~SW_DN_RST;
> > > +       }
> > > +
> > > +       omap_mcpdm_write(MCPDM_CTRL, ctrl);
> > > +}
> > > +
> >
> > Would it not be better to rename uplink/downlink as playback
> > and capture
> > for ALSA ? If so, you could have an inline playback and
> > capture version
> > of this function.
> 
> Data paths in McPDM module are named uplink/downlink, so these
> names were chosen to be consistent. Is renaming it according
> to ALSA the best approach?

Generally yes, as long as we can see the audio direction easily (a
comment would do here).

Fwiw, I would have written the above as :-

static inline void omap_mcpdm_reset_playback(int reset)
{
	int ctrl = omap_mcpdm_read(MCPDM_CTRL);

	if (reset)
		ctrl |= SW_UP_RST;
	else
		ctrl &= ~SW_UP_RST;
	
	omap_mcpdm_write(MCPDM_CTRL, ctrl);
}

and one for capture reset too.


> > > +int omap_mcpdm_set_offset(int offset1, int offset2)
> > > +{
> > > +       int offset;
> > > +
> > > +       if ((offset1 > DN_OFST_MAX) || (offset2 > DN_OFST_MAX))
> > > +               return -EINVAL;
> > > +
> > > +       offset = (offset1 << DN_OFST_RX1) | (offset2 <<
> > DN_OFST_RX2);
> > > +
> > > +       /* Enable/disable offset cancellation for downlink
> > channel 1 */
> > > +       if (offset1)
> > > +               offset |= DN_OFST_RX1_EN;
> > > +       else
> > > +               offset &= ~DN_OFST_RX1_EN;
> > > +
> > > +       /* Enable/disable offset cancellation for downlink
> > channel 2 */
> > > +       if (offset2)
> > > +               offset |= DN_OFST_RX2_EN;
> > > +       else
> > > +               offset &= ~DN_OFST_RX2_EN;
> > > +
> > > +       omap_mcpdm_write(MCPDM_DN_OFFSET, offset);
> > > +
> > > +       return 0;
> > > +}
> >
> > What does this do and why is it not static ?
> 
> It enables and configures offset cancelation for the analog headset path. It is supposed to be called by the codec driver, so it should'nt be static. But, offset cancelation is probably not going to be used at first.
> 

Ok, can we a comment to here to describe this.

Thanks

Liam

