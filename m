From: David Brownell <david-b@pacbell.net>
Subject: Re: git-pull request for omap-fixes for 2.6.29-rc1 (Re: [PATCH 00/10] Omap fixes for 2.6.29-rc1)
Date: Thu, 15 Jan 2009 03:13:48 -0800
Message-ID: <200901150313.48983.david-b@pacbell.net>
References: <20090112143405.24205.52151.stgit@localhost> <20090113143528.GP7344@atomide.com> <20090115103716.GL2162@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:22927 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759247AbZAOLNv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jan 2009 06:13:51 -0500
In-Reply-To: <20090115103716.GL2162@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>

On Thursday 15 January 2009, Russell King - ARM Linux wrote:
> Unfortunately, this breaks stuff. =A0Whereas before pulling this I ge=
t:
>=20
> =A0 CC =A0 =A0 =A0drivers/usb/core/hub.o
> drivers/usb/core/hub.c: In function `usb_configure_device_otg':
> drivers/usb/core/hub.c:1557: error: too few arguments to function `us=
b_port_suspend'
>=20
> while building my omap config, I now get this much earlier in the bui=
ld:

ISTR seeing that before.  I'm not sure what happened to
Alan's patch ... I guess it didn't get merged yet.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
