From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Fwd: dss2 with dsi
Date: Fri, 17 Apr 2009 09:44:16 +0300
Message-ID: <1239950656.6696.181.camel@tubuntu>
References: <aed62de90904151916h5a218e9bgf3419ea96c3ed262@mail.gmail.com>
	 <aed62de90904151917l21419edo12df2dc3ad5c707c@mail.gmail.com>
	 <1239875936.6696.125.camel@tubuntu>
	 <aed62de90904161121q5167594xb2dbbf29a7577121@mail.gmail.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19494 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341AbZDQGo0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 02:44:26 -0400
In-Reply-To: <aed62de90904161121q5167594xb2dbbf29a7577121@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rebecca Schultz Zavin <rebecca@android.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2009-04-16 at 20:21 +0200, ext Rebecca Schultz Zavin wrote:

> That clarifies things a lot.  I don't have the MIPI dsi spec so I'm
> working from reference code from TI and the limited documentation in
> the omap TRM.  I'll see if I can't get things working without that
> change.

My advice is: get the spec ;). Seriously, you'll save a lot of time if
you don't have to guess and reverse engineer things.

> >>
> >> 3- The code hard codes the complexio timing values used for setting
> >> DSIPHY_CFG0, 1 and 2.  I think these values should be specified in the
> >> omap_ctrl the way rfbi_timings are.
> >
> > I don't remember what settings there is but aren't they specified in
> > MIPI DSI spec? If so, they should be the same for all peripherals. At
> > least in theory =).
> 
> I don't know about this, again I don't have the spec.  I'll see if I
> can use your values.  Were they specified as a range possibly?

Yes, they have minimum and maximum values. I have some comments in
dsi_complexio_timings() about mins and maxes, but they are quite old. I
guess I should verify that they are what the spec says.

> 
> Speaking of which, one of the other things I ran into was the
> controller expecting some packets with different data_type fields.
> The reference code I'm working from called these "generic" but I have
> no idea if they are part of the spec or just vendor specific.  I added
> a couple of functions that let you pass the data_type, but if they are
> common to the spec it'd be easier to just treat them the same way you
> did with the dcs types.  Do you remember whether the spec specified
> any additional types?  I have these:
> 
> #define GENERIC_WRITE_LONG_CMD             0x29
> #define GENERIC_WRITE_SHORT_1                 0x23
> #define GENERIC_WRITE_SHORT_0                 0x13
> #define GENERIC_READ_CMD                          0x14
> #define GENERIC_SHORT_READ1                    0x11
> #define GENERIC_SHORT_READ2                    0x12
> #define GENERIC_LONG_READ                        0x1a

Yes, these are defined in the DSI spec. I have not implemented them as
my display doesn't support those. If I remember right, generic commands
are used to convey vendor spesific data. So there could be an API for
generic datatypes in dsi.c, but the actual code using them needs to be
in the display driver.

 Tomi


