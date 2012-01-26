From: Paul Walmsley <paul@pwsan.com>
Subject: Re: 3.3-rc1 console lag (was: Re: [PATCH v8 00/20] OMAP2+: UART:
 Runtime adaptation + cleanup)
Date: Wed, 25 Jan 2012 20:00:51 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201252000410.11174@utopia.booyaka.com>
References: <CAB-zwWg4RS4J1YCcbfMWjLSCcV=oHqk9vaUKKKr0WjnTEuOmxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35120 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab2AZDAw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 22:00:52 -0500
In-Reply-To: <CAB-zwWg4RS4J1YCcbfMWjLSCcV=oHqk9vaUKKKr0WjnTEuOmxQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Govindraj Raja <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Wed, 25 Jan 2012, Ramirez Luna, Omar wrote:

> Hi,
> 
> On Fri, Nov 11, 2011 at 3:57 AM, Govindraj.R <govindraj.raja@ti.com> wrote:
> > Converting uart driver to adapt to pm runtime API's.
> > Code re-org + cleanup.
> > Moving some functionality from serial.c to omap-serial.c
> ...
> >
> > Ensure CONFIG_OMAP_PRM is set while testing irq_chaining with uart.
> > And for pm_qos usage ensure CONFIG_CPU_IDLE is selected other wise
> > console might be sluggish.
> 
> There is console lag for omap2plus_defconfig given that
> CONFIG_CPU_IDLE is not enabled. Is the intention to force CPU_IDLE
> into the defconfig or find an alternative for the new pm_qos when cpu
> idle is disabled.
> 
> Seen on beagle-xm and 3.3-rc1.

Try this

http://marc.info/?l=linux-arm-kernel&m=132754676814391&w=2


- Paul
