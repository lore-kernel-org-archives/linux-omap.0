From: Marc Zyngier <Marc.Zyngier@arm.com>
Subject: Re: [RFC PATCH 03/12] ARM: omap4: use remapped PPI interrupts for
 local timer
Date: Tue, 03 May 2011 17:18:49 +0100
Message-ID: <1304439529.27148.188.camel@e102391-lin.cambridge.arm.com>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
	 <1303326501-15664-4-git-send-email-marc.zyngier@arm.com>
	 <4DBA67A5.4060803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([94.185.240.25]:56577 "HELO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753552Ab1ECQSQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 12:18:16 -0400
In-Reply-To: <4DBA67A5.4060803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: LAK <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, l-o <linux-omap@vger.kernel.org>

On Fri, 2011-04-29 at 12:54 +0530, Santosh Shilimkar wrote:

Hi Santosh,

> On 4/21/2011 12:38 AM, Marc Zyngier wrote:
> > Use the normal interrupt scheme for the local timers by using
> > a remapped PPI interrupt.
> >
> > Tested on a Pandaboard.
> >
> > Cc: Tony Lindgren<tony@atomide.com>
> > Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
> > Signed-off-by: Marc Zyngier<marc.zyngier@arm.com>
> > ---
> 
> Have reviewed and tested your series along with
> OMAP changes. It boots fine on OMAP4430 SDP.
> 
> # cat /proc/interrupts
>             CPU0       CPU1
> .
> 410:       3678          0   GIC-PPI  local_timer
> 413:          0       1042   GIC-PPI  local_timer
> .
> LOC:          0          0  Local timer interrupts
> .
> 
> Though above output would be bit miss leading, this
> series removes the duplicate code from platforms and
> consolidate it at one place.

The LOC line is gone in the next iteration of the patch serie.

> FWIW, you can add my
> 
> Reviewedd-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks for testing.

	M.
-- 
Reality is an implementation detail.


