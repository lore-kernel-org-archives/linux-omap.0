From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/2] OMAP3EVM: Made backlight GPIO default state to off
Date: Thu, 1 Apr 2010 17:41:36 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DF7EF68@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1269263470-13814-1-git-send-email-hvaibhav@ti.com>
 <1270122886.2704.100.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57156 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755855Ab0DAML7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 08:11:59 -0400
In-Reply-To: <1270122886.2704.100.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Thursday, April 01, 2010 5:25 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: Re: [PATCH 1/2] OMAP3EVM: Made backlight GPIO default state to off
> 
> Hi,
> 
> On Mon, 2010-03-22 at 14:11 +0100, ext hvaibhav@ti.com wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > If you choose default output to DVI, the LCD backlight still
> > gets powered, since panel->disable function never gets called for LCD.
> >
> > So, during init put backlight GPIO to off state and the driverr
> > code will decide which output to enable explicitly.
> 
> I'm not sure I understand this patch. You talk about choosing default
> output (via kernel boot args, I presume),
[Hiremath, Vaibhav] yes you are correct. I am talking about default output selection using bootargs.

> but the code checks for EVM
> revision. What is the connection between EVM revision and selecting
> display output?
[Hiremath, Vaibhav] Ohh ok, I think you are not aware that we do have 2 version of EVM's. EVM-1 with positive (backlight gpio) polarity and EVM-2 with negative (backlight gpio) polarity. 

The code is doing exactly same.

Thanks,
Vaibhav
> 
>  Tomi
> 

