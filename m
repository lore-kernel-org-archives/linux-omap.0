From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC/PATCH 0/4] twl4030 threaded_irq support
Date: Mon, 25 Jan 2010 23:36:55 -0800
Message-ID: <201001252336.55577.david-b@pacbell.net>
References: <20091212183410.GF3092@sirena.org.uk> <1260786654-13294-1-git-send-email-felipe.balbi@nokia.com> <201001252306.55625.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:47347 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752189Ab0AZHng (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 02:43:36 -0500
In-Reply-To: <201001252306.55625.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-kernel@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@openedhand.com>

On Monday 25 January 2010, David Brownell wrote:
> Did the threaded IRQ stuff ever get set up so that the top
> level IRQ thread didn't have to hand off to another thread
> each time? =A0(That's how the current stuff works. =A0One thread
> calling out to each handler.)

Yes:  set_irq_nested_thread().  Looks like the toplevel IRQ
demux (in drivers/mfd/twl*irq*c) should use that, along with
the ONESHOT flag and (eventually) bus_lock stuff.

All the key parts that were missing a few years ago now seem
to be present.  But, not yet in use here.  :)

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
