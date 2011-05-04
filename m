From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] About ARM expansion boards and others things
Date: Wed, 4 May 2011 02:27:08 -0700
Message-ID: <20110504092708.GX2092@atomide.com>
References: <BANLkTimjWtqLsWA1Gthix6RZYMzNRdC7rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42450 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751689Ab1EDJ1L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 05:27:11 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimjWtqLsWA1Gthix6RZYMzNRdC7rg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric =?utf-8?B?QmFsbGV0YsOy?= i Serra <eballetbo@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

* Enric Balletb=C3=B2 i Serra <eballetbo@gmail.com> [110503 10:21]:
>=20
> Basically I wonder if it's possible add another omap_dss_device from
> kernel module to the omap DSS driver (something like
> omap_dss_register_new_device). Is a good or bad idea ? Why ? Is any
> reason to not export the MUX functionality to be used for other
> drivers ?

Sounds all doable. For DSS, I think the memblock needs to be reserved
early.

With the mux framework, we have a Linux generic mux framework coming
up, that should allow you to access the pins from the driver module
too.

Regards,

Tony=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
