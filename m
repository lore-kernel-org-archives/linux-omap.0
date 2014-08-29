From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 15/15] tty: serial: 8250: omap: add dma support
Date: Fri, 29 Aug 2014 18:31:51 +0200
Message-ID: <5400AAF7.5060401@linutronix.de>
References: <20140815210211.GD9239@atomide.com> <53F5AF0D.5060409@linutronix.de> <20140821184416.GF10066@atomide.com> <53FE3779.5090908@linutronix.de> <20140827202313.GF16006@atomide.com> <20140828082348.GA5413@linutronix.de> <20140828164645.GG16006@atomide.com> <53FF84DF.7080406@linutronix.de> <20140828225454.GM16006@atomide.com> <540048B4.7010807@linutronix.de> <20140829161221.GO16006@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48039 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbaH2QcA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2014 12:32:00 -0400
In-Reply-To: <20140829161221.GO16006@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: balbi@ti.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>

On 08/29/2014 06:12 PM, Tony Lindgren wrote:
> Looks like the paste bug is there for sure, doing off idle and pastin=
g
> 240 characters to the console can hang the UART RX after few attempts=
,
> and pasting 16 charactes won't show up at all if the system is idling=
=2E
> So you may want to play with that too a bit :)

Oh. perfect. Please note that we the threshold moved from 16 to 48.
However I see that usually we lose a lot of characters before the uart
wakes up and does its job. Usually I see a couple characters but
sometimes is see broken characters which suggests that the clock was
not (yet) perfect. And I managed not get get it woken once.
So let me look at this once I am through with the review responses=E2=80=
=A6

>=20
> Regards,
>=20
> Tony
>=20
Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
