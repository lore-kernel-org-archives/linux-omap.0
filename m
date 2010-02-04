From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5] OMAP UART: Add omap-serial driver support.
Date: Thu, 4 Feb 2010 14:37:45 -0600
Message-ID: <20100204203744.GC711@lixom.net>
References: <63111.192.168.10.88.1264586216.squirrel@dbdmail.itg.ti.com> <20100128032242.GA9070@lixom.net> <50326.192.168.10.89.1265296150.squirrel@dbdmail.itg.ti.com> <20100204152847.GA711@lixom.net> <40204.192.168.10.88.1265298323.squirrel@dbdmail.itg.ti.com> <87iqac51xb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:53003 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933345Ab0BDUe0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Feb 2010 15:34:26 -0500
Content-Disposition: inline
In-Reply-To: <87iqac51xb.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org

On Thu, Feb 04, 2010 at 09:46:40AM -0800, Kevin Hilman wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
> 
> [...]
> 
> >>> >> + * @baud: baudrate for which divisor needs to be calculated.
> >>> >> + *
> >>> >> + * We have written our own function to get the divisor so as to support
> >>> >> + * 13x mode.
> >>> >> + */
> >>> >
> >>> > Again, the why, not the how. Why do you need the 13x divisor? What's
> >>> > magic about 3Mbaud?
> >>> >
> >>>
> >>> Refering to TRM UART chapter 17:
> >>>
> >>> Table 17-1. UART Mode Baud Rates, Divisor Values, and Error Rates
> >>>
> >>> referring to oversampling - divisor value
> >>>
> >>> baudrate 460,800 to 3,686,400 all have divisor 13
> >>>
> >>> except 3,000,000 which has divisor value 16
> >>>
> >>> thus we are checking if baud != 3000000
> >>
> >> Ok. It's always useful to have just a bit of information in the driver
> >> so you don't have to search around the manual when trying to figure out
> >> why something was done.
> >>
> >> Maybe something simple: "3Mbaud is unique in that it requires a divisor
> >> of 13. See the TRM for full details".
> >
> > ok. will add that comments.
> 
> Referncing TRM Chapter and Section names (and/or numbers) is very
> helpful too.  Usually section names are more helpful since numbers
> change w/TRM versions.

Yep!  Rule of thumb: Put yourself in the seat of someone that has to debug this
driver without having memorized the TRM for the module, and try to make their
work as simple as possible (to certain limits).

Which in other words means reducing the number of "Huh? Why is that
there?" questions to a minimum. :)


-Olof
