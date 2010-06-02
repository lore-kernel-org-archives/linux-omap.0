From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: beagleboard expansion boards, was Trying to understand how to
 use new OMAP mux code
Date: Wed, 2 Jun 2010 21:42:48 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323207A01@dbde02.ent.ti.com>
References: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com>
 <20100311224812.GU2900@atomide.com> <4C062DD4.2050701@cioinfoindus.fr>
 <20100602112130.GG5980@atomide.com>
 <20100602144606.4287c438.jhnikula@gmail.com>
 <3BC7A992-11AB-4EBF-B7A5-4C4B1498CC58@student.utwente.nl>
 <20100602161418.c6af218b.jhnikula@gmail.com>
 <20100602135709.GK5980@atomide.com>
 <20100602171427.5024be97.jhnikula@gmail.com>
 <20100602144547.GM5980@atomide.com> <20100602145456.GC11744@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57359 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758030Ab0FBQM6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 12:12:58 -0400
In-Reply-To: <20100602145456.GC11744@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, ext Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Koen Kooi <koen@dominion.thruhere.net>, Laurent Epinat <laurent.epinat@cioinfoindus.fr>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Felipe Balbi wrote:
> On Wed, Jun 02, 2010 at 04:45:48PM +0200, ext Tony Lindgren wrote:
> >Yeah having the modules do the platform device init and registration will
> >lead into nasty conflicts. The platform device registration really needs
> >to happen in the board-*.c files, not in the drivers.
> 
> yeah, unless you had a way to register a particular platform_device 
> conditionaly based on the attached daughter card, but then again, if you 
> can detect the daughter card, you might as well use that information to 
> do the muxing correctly on the board-*.c file.
> 
> I have to agree modules are not supposed to change platform stuff. On 
> the other hand, that could be used by EHCI/OHCI to implement port 
> handoff on runtime:
> 
>   mux all usb ports to ehci, if enumeration fails, remux ports to ohci 
>   and try again.
> 

FWIW, this specific configuration is not supported on OMAP3s today.
You cannot dynamically hand off from EHCI to OHCI - the issue being that
we don't have a single PHY that can talk both interface languages on the
exact same pads as the OMAP.

One other case I can think of where you might want to change mux modes
dynamically is as a workaround for an errata. For instance, you might
want to mux a particular pad to safe-mode when entering off-mode and
mux it back to a functional mode after exiting off-mode.

- Anand
