From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/16 v9] omap 8250 based uart + DMA
Date: Fri, 26 Sep 2014 18:02:39 +0200
Message-ID: <20140926160239.GA12801@kroah.com>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <20140917090506.GA6812@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43774 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635AbaIZQDg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2014 12:03:36 -0400
Content-Disposition: inline
In-Reply-To: <20140917090506.GA6812@breakpoint.cc>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On Wed, Sep 17, 2014 at 11:05:06AM +0200, Sebastian Andrzej Siewior wro=
te:
> On 2014-09-10 21:29:55 [+0200], Sebastian Andrzej Siewior wrote:
> > the diff of v8=E2=80=A6v9 is small:
>=20
> Greg, do you mind taking patches from this series up to "[PATCH 05/16=
]"?
> Nobody complained about those so far and it would keep v10 a little s=
maller.
> I have changes to #6 (the omap driver) and need to do some DMA relate=
d
> changes in the following

Now applied, thanks.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
