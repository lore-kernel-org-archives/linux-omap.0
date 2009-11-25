From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCHv3 0/3] OMAP UART: Adding support for omap-serial driver.
Date: Wed, 25 Nov 2009 12:32:44 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402543D7ED2@dbde02.ent.ti.com>
References: <35552.192.168.10.88.1256713953.squirrel@dbdmail.itg.ti.com>
 <44977.192.168.10.88.1258095220.squirrel@dbdmail.itg.ti.com>
 <d6a0f7aa0911200151xb948a28kf4f22d79e61b993e@mail.gmail.com>
 <20091123170544.GA10313@lixom.net>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402543D7A46@dbde02.ent.ti.com>
 <20091124172139.GA22967@lixom.net>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BBDC7CAD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44914 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403AbZKYHCr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 02:02:47 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BBDC7CAD@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Olof Johansson <olof@lixom.net>
Cc: Govindraj <govindraj.ti@gmail.com>, "g@lixom.net" <g@lixom.net>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>



> -----Original Message-----
> From: Shilimkar, Santosh 
> Sent: Wednesday, November 25, 2009 12:06 PM
> To: Olof Johansson; G, Manjunath Kondaiah
> Cc: Govindraj; g@lixom.net; Tony Lindgren; 
> linux-omap@vger.kernel.org; Pandita, Vikram; Raja, Govindraj
> Subject: RE: [PATCHv3 0/3] OMAP UART: Adding support for 
> omap-serial driver.
> 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Olof Johansson
> > Sent: Tuesday, November 24, 2009 10:52 PM
> > To: G, Manjunath Kondaiah
> > Cc: Govindraj; g@lixom.net; Tony Lindgren; linux-
> > omap@vger.kernel.org; Pandita, Vikram; Raja, Govindraj
> > Subject: Re: [PATCHv3 0/3] OMAP UART: Adding support for omap-serial
> > driver.
> > 
> > On Tue, Nov 24, 2009 at 03:04:09PM +0530, G, Manjunath Kondaiah
> > wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Olof Johansson [mailto:olof@lixom.net]
> > > > Sent: Monday, November 23, 2009 10:36 PM
> > > > To: Govindraj; g@lixom.net
> > > > Cc: Tony Lindgren; linux-omap@vger.kernel.org; Pandita,
> > > > Vikram; Raja, Govindraj; G, Manjunath Kondaiah
> > > > Subject: Re: [PATCHv3 0/3] OMAP UART: Adding support for
> > > > omap-serial driver.
> > > >
> > > > On Fri, Nov 20, 2009 at 03:21:26PM +0530, Govindraj wrote:
> > > > > I have not seen any comments on this patch series yet.
> > > > >
> > > > > Tony,
> > > > > Is there something I need to modify?
> > > >
> > > > Govindaj,
> > > >
> > > > I'm having problems with these patches on Zoom2 with debug
> > > > board, since
> > > > they don't seem to coexist very well together with 8250.
> > Enabling both
> > > > options will result in build errors.
> > >
> > > Why do we need to enable both 8250 and omap-serial for console.
> > The console
> > > UART can be either external UART or any one of the omap UART
> > right?
> > 
> > You should allow both of them to be enabled at the same time, so the
> > same
> > kernel can for example be booted on a ZOOM2 with debug board
> > attached
> > (8250 on GPMC), or on a beagle/overo board.
> > 
> > Making them exclusive would be a step backwards.
> 
> More so, selecting both config option really shouldn't break 
> the build. If one expect a build break because only one of 
> the options can be enabled then clearly the dependency should 
> be used so that user can select only one option at a time.

Ack. There should be dependency in Kconfig so that user can select
either 8250 console(through Quad-uart for zoom2/zoom3) or OMAP-serial
Console(through OMAP UART's).

-Manjunath