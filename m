From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 04/19] ARM: OMAP4: PM: save/restore all DPLL settings
 in OFF mode
Date: Mon, 21 May 2012 11:58:31 +0300
Message-ID: <1337590711.2149.387.camel@sokoban>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	 <1336990730-26892-5-git-send-email-t-kristo@ti.com> <87d363928g.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43597 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932084Ab2EUJB0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:01:26 -0400
In-Reply-To: <87d363928g.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Wed, 2012-05-16 at 15:42 -0700, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > From: Rajendra Nayak <rnayak@ti.com>
> >
> > SAR/ROM code restores only CORE DPLL to its original state
> > post wakeup from OFF mode.
> > The rest of the DPLL's in OMAP4 platform (MPU/IVA/ABE/USB/PER)
> > are saved and restored here during an OFF transition.
> >
> > [nm@ti.com: minor cleanups]
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> Some general comments:
> 
> - the register dump/print doesn't belong here.  If needed, should be a
>   debug feature if needed.

Okay, I'll just drop it out.

> 
> - Rather than hooking into omap4_enter_lowpower(), should use
>   the cluster PM enter/exit notifier chain.

Yes can do that.

-Tero

