From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/4] fbdev: add a MIPI DSI header
Date: Wed, 19 May 2010 11:21:48 +0300
Message-ID: <1274257308.2307.168.camel@tubuntu.research.nokia.com>
References: <Pine.LNX.4.64.1005071054510.4777@axis700.grange>
	 <Pine.LNX.4.64.1005071102440.4777@axis700.grange>
	 <1274255350.2307.159.camel@tubuntu.research.nokia.com>
	 <Pine.LNX.4.64.1005190955500.3099@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005190955500.3099@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: ext Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, 2010-05-19 at 10:08 +0200, ext Guennadi Liakhovetski wrote:
> Hi Tomi
> 
> On Wed, 19 May 2010, Tomi Valkeinen wrote:

> > The file name is mipi_dsi.h, the comment talks about MIPI, and the file
> > contains defines for MIPI DSI and MIPI DCS. If you want the file to
> > contain defines about all MIPI specs, I think the file name should be
> > just mipi.h.
> 
> No, the header is just intended for DSI, the comment could be made more 
> specific, yes, but DCS is a part of DSI, isn't it?

No, DCS is a spec of its own. DCS can be used on non-DSI displays also.
For example N800 and N900 use DCS commands, but they are not DSI
displays.

> > > + *
> > > + * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > + * Copyright (C) 2006 Nokia Corporation
> > > + * Author: Imre Deak <imre.deak@nokia.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > + */
> > > +#ifndef MIPI_DSI_H
> > > +#define MIPI_DSI_H
> > > +
> > > +#include <linux/types.h>
> > > +
> > > +enum mipi_dsi_cmd {
> > 
> > I think these are DSI datatypes, not commands.
> 
> hm, "write," "shut down," "mode off," "mode on" sound like commands to me, 
> and I think I saw them called commands in the spec, but yes, some of them 
> are just packet or data types... I'll double-check, thanks.

Well, true, this is not a clear thing. MIPI DSI spec talks about "turn
on peripheral command". But the numbers are DSI data types, according to
the spec, and not all of them are commands.

> > > +	MIPI_DSI_DCS_SHORT_WRITE			= 5,
> > 
> > Please use the same number format for all enums. So this should be 0x05.
> 
> Where does this requirement come from? Is it in CodingStyle?;)

I don't know, but mixing different formats looks ugly to me =).

> > > +	MIPI_DSI_DCS_SHORT_WRITE_PARAM			= 0x15,
> > > +	MIPI_DSI_COLOR_MODE_OFF				= 2,
> > > +	MIPI_DSI_COLOR_MODE_ON				= 0x12,
> > > +	MIPI_DSI_SHUTDOWN_PERIPHERAL			= 0x22,
> > > +	MIPI_DSI_TURN_ON_PERIPHERAL			= 0x32,
> > > +	MIPI_DSI_GENERIC_SHORT_WRITE_0_PARAM		= 3,
> > > +	MIPI_DSI_GENERIC_SHORT_WRITE_1_PARAM		= 0x13,
> > > +	MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM		= 0x23,
> > > +	MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM		= 4,
> > > +	MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM		= 0x14,
> > > +	MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM		= 0x24,
> > > +	MIPI_DSI_DCS_LONG_WRITE				= 0x39,
> > > +	MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE		= 0x37,
> > > +	MIPI_DSI_NULL_PACKET				= 9,
> > > +	MIPI_DSI_BLANKING_PACKET			= 0x19,
> > > +	MIPI_DSI_GENERIC_LONG_WRITE			= 0x29,
> > > +	MIPI_DSI_LOOSELY_PACKED_PIXEL_STREAM_YCBCR20	= 0xc,
> > > +	MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR24		= 0x1c,
> > > +	MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR16		= 0x2c,
> > > +	MIPI_DSI_PACKED_PIXEL_STREAM_30			= 0xd,
> > > +	MIPI_DSI_PACKED_PIXEL_STREAM_36			= 0x1d,
> > > +	MIPI_DSI_PACKED_PIXEL_STREAM_YCBCR12		= 0x3d,
> > > +	MIPI_DSI_PACKED_PIXEL_STREAM_16			= 0xe,
> > > +	MIPI_DSI_PACKED_PIXEL_STREAM_18			= 0x1e,
> > > +	MIPI_DSI_PIXEL_STREAM_3BYTE_18			= 0x2e,
> > > +	MIPI_DSI_PACKED_PIXEL_STREAM_24			= 0x3e,
> > > +};
> > > +
> > > +enum mipi_dcs_cmd {
> > 
> > While the MIPI specs define a certain set of commands, the real panels
> > usually implement also their own custom commands. That's why I don't
> > think enum is a good choice here.
> 
> Yes, that's a valid point, I'll have to think about it more.

I think a simple solution would be to just use defines, and have
functions that take the command as u8. That's what the OMAP DSI driver
does. If you have better ideas, please share =).

The same applies for the DSI commands/datatypes, although I haven't seen
a panel that has custom DSI datatypes.

 Tomi


