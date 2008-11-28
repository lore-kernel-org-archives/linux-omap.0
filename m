From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] TVP514x Driver with Review comments fixed
Date: Fri, 28 Nov 2008 11:54:05 -0800
Message-ID: <200811281154.06274.david-b@pacbell.net>
References: <19F8576C6E063C45BE387C64729E739403E904ECE6@dbde02.ent.ti.com> <200811281150.28801.david-b@pacbell.net>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:33508 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752792AbYK1TyI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Nov 2008 14:54:08 -0500
In-Reply-To: <200811281150.28801.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "davinci-linux-open-source-bounces@linux.davincidsp.com" <davinci-linux-open-source-bounces@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Jadav, Brijesh R" <brijesh.j@ti.com>, "Shah, Hardik" <hardik.shah@ti.com>, "Hadli, Manjunath" <mrh@ti.com>, "R, Sivaraj" <sivaraj@ti.com>, "Karicheri, Muralidharan" <m-karicheri2@ti.com>

On Friday 28 November 2008, David Brownell wrote:
> On Friday 28 November 2008, Hiremath, Vaibhav wrote:
> > Will have to now think how to differentiate between these
> > two chips and handle this sequence. 
> 
> That's really easy, the "id" parameter to probe() tells you:
> 
> 	if (strcmp(id->name, "tvp5146") == 0)
> 		/* original '46 part ... */;
> 	else if (strmcp(id->name, "tvp5146m2") == 0)
> 		/* new '46m2 version ... */
> 	... etc

... although it's even easier to use id->driver_data to
hold, for example, a bitmask telling various attributes
of that particular device.  Examples here:

	- does it have the extra '46 registers?
	- does it use the original '46 init sequence?
	- or the new m2 one?
	- or the original '47 init sequence?
	- or the new m1 version?
	- ...

Another common use of driver_data is to hold a pointer
to a struct holding chip-specific data that doesn't fit
into a simple bitmask.

- Dave
