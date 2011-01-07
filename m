From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: 4430SDP boot failure
Date: Fri, 7 Jan 2011 19:56:34 +0530
Message-ID: <c71399f20609c539b8c335344963253f@mail.gmail.com>
References: <20110106195225.GX7771@atomide.com> <20110106203431.GZ7771@atomide.com>
 <20110106205107.GI1198@n2100.arm.linux.org.uk> <20110106235203.GA14425@n2100.arm.linux.org.uk>
 <d540408e2df154cf13932e79d3a11ceb@mail.gmail.com> <20110107092800.GJ1198@n2100.arm.linux.org.uk>
 <86f60bc5418ca1d3e87db960e5e2c48f@mail.gmail.com> <729152acd9ee0c3e3e3cd505e84f8865@mail.gmail.com>
 <20110107125132.GM1198@n2100.arm.linux.org.uk> <48cbfb338be4d33a8a19e070430d015b@mail.gmail.com>
 <20110107142432.GO1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:38752 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753599Ab1AGO0x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 09:26:53 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so17762240fxm.5
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 06:26:52 -0800 (PST)
In-Reply-To: <20110107142432.GO1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Friday, January 07, 2011 7:55 PM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; Tony Lindgren
> Subject: Re: 4430SDP boot failure
>
> On Fri, Jan 07, 2011 at 06:39:06PM +0530, Santosh Shilimkar wrote:
> > Have sent you latest bootloaders and full bootlog on my ES1.0
> > OMAP4430SDP. 2.6.37 just boots fine for me.
> >
> > Low level debug as you reported seems to be broken though.
>
> Many thanks, the new mlo and uboot gets dhcp/tftp working nicely on
> the board - which should ease the debugging problem as it no longer
> requires anything but the reset button pressed to test a new kernel.

Glad to hear that.

Regards,
Santosh
