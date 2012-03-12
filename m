From: Kevin Hilman <khilman@ti.com>
Subject: Re: DSS pwrdm usecount, disabling autodeps for DSS
Date: Mon, 12 Mar 2012 09:24:16 -0700
Message-ID: <87aa3l23f3.fsf@ti.com>
References: <87r4x27gh0.fsf@ti.com> <1331291641.1927.38.camel@deskari>
	<alpine.DEB.2.00.1203091055150.7039@utopia.booyaka.com>
	<1331542847.2097.4.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:53798 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753081Ab2CLQYJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 12:24:09 -0400
Received: by mail-ey0-f175.google.com with SMTP id e1so1147289eaa.20
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 09:24:08 -0700 (PDT)
In-Reply-To: <1331542847.2097.4.camel@deskari> (Tomi Valkeinen's message of
	"Mon, 12 Mar 2012 11:00:47 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> On Fri, 2012-03-09 at 10:57 -0700, Paul Walmsley wrote:
>> On Fri, 9 Mar 2012, Tomi Valkeinen wrote:
>> 
>> > I didn't get very far with the patch =(. Tested on omap3 overo, with
>> > -rc6 based dss tree.
>> 
>> Thanks for testing and the .config.  Probably the best thing to do in the 
>> medium term is to fix the hwmod iclk handling; I think that will also fix 
>> the DSS autodeps problem.
>
> Btw, I don't know if it affects omap2/3, but I'm making a change with
> the dss hwmod devices so that the dss_core will be a parent device to
> all the other dss hwmod devices. This solves the mess on omap4, the
> modulemode bit, and the sequence in which the dss clocks need to be
> enabled, as dss_core will always be enabled first.
>
> This requires two patches for omap_device, "ARM: OMAP: remove
> omap_device_parent", "ARM: OMAP: omap_device: Expose omap_device_{alloc,
> delete, register}" which I hope are going in in the next merge window.

Yes, both are queued for 3.4.

Kevin

>
> So, it may not affect omap2/3 in any way, but just thought to mention.
>
>  Tomi
