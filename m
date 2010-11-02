From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 0/2] OMAP: DSS2: Add new display panel
Date: Tue, 02 Nov 2010 11:19:06 +0200
Message-ID: <1288689546.5614.60.camel@tubuntu>
References: <1288276982-17225-1-git-send-email-eballetbo@gmail.com>
	 <1288620930.5614.16.camel@tubuntu>
	 <AANLkTi=fV58ApDqUE21YMK0_vhLdPbPr7F7YpYh0-2Vc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48642 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632Ab0KBJSw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 05:18:52 -0400
In-Reply-To: <AANLkTi=fV58ApDqUE21YMK0_vhLdPbPr7F7YpYh0-2Vc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Bryan Wu <bryan.wu@canonical.com>
Cc: ext Enric Balletbo i Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "hvaibhav@ti.com" <hvaibhav@ti.com>, "notasas@gmail.com" <notasas@gmail.com>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros@nokia.com>, "mike@compulab.co.il" <mike@compulab.co.il>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, 2010-11-01 at 17:45 +0100, ext Bryan Wu wrote:
> On Mon, Nov 1, 2010 at 10:15 AM, Tomi Valkeinen
> <tomi.valkeinen@nokia.com> wrote:

> > What we need is a common driver for all these dummy panels, and the
> > driver would contain configurations for all the supported panels. The
> > board file would pass the name of the panel used in that board to the
> > driver, and the driver would use the configurations for that panel.
> >
> 
> It looks like that we just need one file name displays.c to do those
> generic things and pass the configuration from board files to this
> driver, such as timing or other things.

Not quite. If you pass timing information from the board files then
every board file has to define all the timings, even if they are using
the same panel.

That's why the configs should be in the panel driver, and the board file
only has to define which panel is actually connected.

> > This has been discussed a few times in l-o list, but I haven't found
> > time to implement it and nobody else has done it either.
> >
> 
> I'm quite happy to do this, thanks,

Thanks, I appreciate that.

 Tomi


