From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty: omap-serial: Keep the wakeup mechanism enabled by
 default
Date: Fri, 20 Apr 2012 10:13:49 +0100
Message-ID: <20120420101349.357dac72@pyramind.ukuu.org.uk>
References: <1334579407-16970-1-git-send-email-govindraj.raja@ti.com>
	<87vckyq6ti.fsf@ti.com>
	<CAMrsUdL1S5GiyG0egS=CHg2fdNkyZVF-wuCNGDg547kfTUODng@mail.gmail.com>
	<87mx69nms2.fsf@ti.com>
	<20120418200833.24ef25ff@pyramind.ukuu.org.uk>
	<CAMrsUdJ_ewe1td9nOO+0ociP4O_tyPgjH=w11r_mFW_yc7PDAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:51657 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab2DTJLn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Apr 2012 05:11:43 -0400
In-Reply-To: <CAMrsUdJ_ewe1td9nOO+0ociP4O_tyPgjH=w11r_mFW_yc7PDAQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Thu, 19 Apr 2012 20:00:12 +0530
"Raja, Govindraj" <govindraj.raja@ti.com> wrote:

> On Thu, Apr 19, 2012 at 12:38 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >> The point is that wakeups should be enabled whenever driver is in use,
> >> and disabled when the driver is not in use.
> >
> >
> > Which is the tty_port methods for initialisation and shutdown, which are
> > mutex protected against each other and hang up.
> >
> > Not sure how the uart layer glue exposes that.
> 
> Is it okay to read the port flags to identify the port state in
> driver whether the serial port shutdown ops is called from
> port_suspend or due to port closure.
> 
> Since port_shutdown gets called even from uart_suspend_port

That sounds like someone needs to fix the uart code to avoid muddling up
suspend/resume/open/close then, or at least pass the needed information
down.

Don't rely on port->flags ideally, they may well go away in part as they
cease to be needed by the lock changes.

Alan
