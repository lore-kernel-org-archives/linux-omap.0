From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: DSS2 and power supplies
Date: Thu, 10 Dec 2009 20:23:40 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940437210B9F@dbde02.ent.ti.com>
References: <6ed0b2680912040253m3b25950fuf49e6ec75ad13067@mail.gmail.com>
	 <1260175482.2342.49.camel@tubuntu.research.nokia.com>
	 <6ed0b2680912070227x3bcb9613x88ebdb0b0a7f3f18@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E73940437210B71@dbde02.ent.ti.com>
 <6ed0b2680912100600p7584c0a0v60ded6e83c6df85d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43175 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403AbZLJOxm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 09:53:42 -0500
In-Reply-To: <6ed0b2680912100600p7584c0a0v60ded6e83c6df85d@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Grazvydas Ignotas [mailto:notasas@gmail.com]
> Sent: Thursday, December 10, 2009 7:31 PM
> To: Hiremath, Vaibhav
> Cc: Tomi Valkeinen; linux-omap@vger.kernel.org
> Subject: Re: DSS2 and power supplies
> 
> On Thu, Dec 10, 2009 at 3:23 PM, Hiremath, Vaibhav <hvaibhav@ti.com>
> wrote:
> <snip>
> 
> >> >
> >> > To me the fig 15-1 does not tell that the powers are needed.
> The
> >> > DSS_DATA[] pins do not come from SDI/DSI blocks, but from the
> main
> >> DSS
> >> > block. And the pin muxing component is outside also. This of
> >> course
> >> > doesn't really prove anything. =)
> >>
> >> True, but apparently vdds_dsi and/or vdds_sdi are also used to
> drive
> >> some data lines then (not supplying them produces blue-ish
> display
> >> with some parts missing). I'm working with pandora board, and I'm
> >> sure
> >> VPLL2 is not connected to anything else.
> >>
> > [Hiremath, Vaibhav] No, I think the "vdds_dsi" doesn't drive any
> data in parallel mode of operation.
> > I have also observed similar issue with OMAP3EVM, when you switch
> the output to DVI interface, you will get bluish image.
> >
> > The issue came out as VPLL2_DEV_GRP (Bits 7-5) register
> configuration. When you are working with LCD panel (in my case
> sharp-ls037v7dw01.c), this file calls regulator_get and
> regulator_enable functions which configures VPLL2_DEV_GRP to 0x2
> [Owns to P1 device group].
> > But when you switch the output to DVI, it doesn't do any
> regulator_get/enable call so the VPLL2_DEV_GRP register becomes 0
> [Owns to no device group] leading to color loss.
> >
> > I am not regulator framework expert, so could not comment on what
> is the relation of VPLL2_DEV_GRP with this issue.
> >
> > So what is required here is, panel_generic.c also should enable
> regulator for "vdvi"
> >
> > I have a patch (tested on OMAP3EVM) which I submit once DSS2 goes
> in.
> 
> I think this regulator is misnamed, does VPLL2 really power DVI on
> OMAP3EVM? Can you check the schematics? At least on pandora it's
> connected to vdds_dsi/vdds_sdi and has nothing to do with the panel.
[Hiremath, Vaibhav] yes you are right, I am really not sure how and from where the "vdvi" name came into picture. 
When had a Private discussion with Tomi on this, and If I understand correctly he borrowed it from old Fbdev driver.

As far as OMAP3EVM is concerned, we do have VPLL2 going to sdi and dsi power supply lines.

I need to understand more on how these power lines affecting parallel data lines. Is it only because that they are multiplexed with sdi/dsi?


Thanks,
Vaibhav

