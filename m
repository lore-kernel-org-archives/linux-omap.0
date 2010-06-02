From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: beagleboard expansion boards, was Trying to understand how to
 use new OMAP mux code
Date: Wed, 2 Jun 2010 17:54:56 +0300
Message-ID: <20100602145456.GC11744@nokia.com>
References: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com>
 <20100311224812.GU2900@atomide.com>
 <4C062DD4.2050701@cioinfoindus.fr>
 <20100602112130.GG5980@atomide.com>
 <20100602144606.4287c438.jhnikula@gmail.com>
 <3BC7A992-11AB-4EBF-B7A5-4C4B1498CC58@student.utwente.nl>
 <20100602161418.c6af218b.jhnikula@gmail.com>
 <20100602135709.GK5980@atomide.com>
 <20100602171427.5024be97.jhnikula@gmail.com>
 <20100602144547.GM5980@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32742 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758355Ab0FBO4C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 10:56:02 -0400
Content-Disposition: inline
In-Reply-To: <20100602144547.GM5980@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Koen Kooi <koen@dominion.thruhere.net>, Laurent Epinat <laurent.epinat@cioinfoindus.fr>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Jun 02, 2010 at 04:45:48PM +0200, ext Tony Lindgren wrote:
>Yeah having the modules do the platform device init and registration will
>lead into nasty conflicts. The platform device registration really needs
>to happen in the board-*.c files, not in the drivers.

yeah, unless you had a way to register a particular platform_device 
conditionaly based on the attached daughter card, but then again, if you 
can detect the daughter card, you might as well use that information to 
do the muxing correctly on the board-*.c file.

I have to agree modules are not supposed to change platform stuff. On 
the other hand, that could be used by EHCI/OHCI to implement port 
handoff on runtime:

  mux all usb ports to ehci, if enumeration fails, remux ports to ohci 
  and try again.

-- 
balbi

DefectiveByDesign.org
