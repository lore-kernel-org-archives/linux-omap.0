From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 15/15] tty: serial: 8250: omap: add dma support
Date: Thu, 4 Sep 2014 09:25:43 -0700
Message-ID: <20140904162542.GS11766@atomide.com>
References: <540048B4.7010807@linutronix.de>
 <20140829161221.GO16006@atomide.com>
 <5404B149.6010400@linutronix.de>
 <54060EDA.6060204@linutronix.de>
 <20140902201536.GC11766@atomide.com>
 <540745CC.2090901@linutronix.de>
 <20140903174845.GE11766@atomide.com>
 <54086CA7.8020507@linutronix.de>
 <20140904145203.GR11766@atomide.com>
 <54087D94.7000208@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55208 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683AbaIDQZy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2014 12:25:54 -0400
Content-Disposition: inline
In-Reply-To: <54087D94.7000208@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, balbi@ti.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Paul Walmsley <paul@pwsan.com>

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140904 07:56]:
> On 09/04/2014 04:52 PM, Tony Lindgren wrote:
> > Yeah makes sense to me. Thanks for ensuring the bug
> > compability :)
>=20
> Thanks. What about the ttyOx vs ttySx. Do you want me to add kernel
> line fixup somewhere arch/arm or we ignore this for now? Greg didn't
> say anything=E2=80=A6

I suggest we have both drivers just available first and then attempt
to deal with the removal of most of omap-serial later on.

If both drivers are present, we should try to ensure 8250 gets probed
first which I believe it already does based on the Makefile order.

Once the 8250 based driver is known to work, it might make sense to
remove most of the functions in omap-serial and have it use the 8250
functions too to remove duplicate code.

That might be already enough and no proxying is needed and we get
rid of the duplicate code :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
