From: David Brownell <david-b@pacbell.net>
Subject: Re: Question on how to best access a chip on init that needs VAUX1 power?
Date: Fri, 16 Jan 2009 13:10:24 -0800
Message-ID: <200901161310.24692.david-b@pacbell.net>
References: <1232134287.347.44.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:48485 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759374AbZAPVK1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Jan 2009 16:10:27 -0500
In-Reply-To: <1232134287.347.44.camel@blackhole>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Friday 16 January 2009, Peter Barada wrote:
>  =A0I'm trying
> initcall_sysbys_sync() to have my code called after the twl4040
> initializes, but before the devices come up.
>=20
> Is the the right way to approach this?

Well, "subsys_initcall()" ... that should work.

Declare the VAUX1 regulator in the normal way,
and you can either hook up VAUX1 to the relevant
device node and have it turn on the regulator,
or just mark it as always_on.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
