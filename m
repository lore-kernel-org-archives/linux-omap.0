From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] dmtimer posting
Date: Thu, 20 Mar 2008 19:13:54 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742903D3B09A@dlee13.ent.ti.com>
References: <87abkv9917.fsf@paris.hilman.org> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA382@dlee13.ent.ti.com> <20080319141504.GB14860@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA4F9@dlee13.ent.ti.com> <20080319155835.GE14860@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA8F8@dlee13.ent.ti.com> <20080320115749.GF14978@atomide.com> <20080320121900.GG14978@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:55380 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbYCUAOy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 20:14:54 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080320121900.GG14978@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

Hi,
 
> * Tony Lindgren <tony@atomide.com> [080320 13:58]:
> > * Woodruff, Richard <r-woodruff2@ti.com> [080320 00:14]:
> > >
> > > One note is some more optimization could happen later on with
> > > reordering.  The current usage in gptimer has dmtimer_set_load()
> > > followed by a dm_timer_start().  This causes a
read/write/read/write
> of
> > > the CTRL register.  Those writes could be collapsed into each
other.
> > > With a load_start().  Others maybe elsewhere.
> >
> > OK. We might also want to optimize the timer reload function. I'll
post
> > a separate patch on that to experiment with.
> 
> Here's an experimental patch that attempts to optimize the timer
> reloading for gp_timer0. I don't know if this improves the latency
> or performance, but might be worth testing.
> 
> I guess there's no way to update the timer without having to write
> TCLR to (re)start it?

If its been stopped you need to write.

> If the patch helps, then we can clean it up a bit more.

This seems good. It does boot and suppress ticks and keep time on my
3430-ES2.1 SDP.

With ETB trace I can't even see it show up in profiling.  As I said in
the last thread I don't have ETM right now to get the real external
time.  But as it is written you get full posting and little need to
synchronize after the write.  If this works reliably it should remove
the overhead completely.

Question: don't you think you need to also update the TLDR in
GP_TIMER0_RELOAD?  Your patch directly writes to the count register, and
forces auto-reload mode in the TLCR.  If the wrong value is in the TLDR
when it overflows you could be here for a while.  Skipping the trigger
write to WTGR for the kick off is ok as is done.

If its in autoreload mode, I'm not sure if it will always call back to
this call.  Perhaps only when changing modes?  I've not so familiar with
the flow above this.  When I look in the debugger, it does have expected
values in all registers (including TLDR) but I'm not sure of the
ordering of the set.

+#define GP_TIMER0_RELOAD(cycles, base)
\
+{
\
+	while ((__raw_readl(IO_ADDRESS((base) + GP_TIMER_TWPS)) &
TWPS_MASK))	\
+		cpu_relax();
\
+	__raw_writel(0xffffffff - (cycles),
\
+			IO_ADDRESS((base) + GP_TIMER_TCRR));
\
+	__raw_writel(0x3, IO_ADDRESS((base) + GP_TIMER_TCLR));
\
+}
+

I'll try a quick back port to CDP kernel and see the effect.  The
previous patch reduced load and saved a few mA at run time which was
good.  This might get another couple mA and MHz back.

Regards,
Richard W.
