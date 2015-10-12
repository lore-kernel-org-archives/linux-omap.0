From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: clock: remove un-used core dpll re-program
 code
Date: Mon, 12 Oct 2015 10:01:42 -0700
Message-ID: <20151012170141.GE23801@atomide.com>
References: <1437034091-18306-1-git-send-email-t-kristo@ti.com>
 <20150812072535.GQ4215@atomide.com>
 <20150812105642.GW4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150812105642.GW4215@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150812 03:59]:
> * Tony Lindgren <tony@atomide.com> [150812 00:29]:
> > * Tero Kristo <t-kristo@ti.com> [150716 01:10]:
> > > Remove the OMAP3 core DPLL re-program code, and the associated SRAM
> > > code that does the low-level programming of the DPLL divider, idling
> > > of the SDRAM etc.
> > > 
> > > This code was never fully implemented in the kernel; things missing
> > > were driver side handling of core clock changes (they need to account
> > > for their functional clock rate being changed on-the-fly), and the whole
> > > framework required for handling this. Thus, there is not much point
> > > to keep carrying the low-level support code either.
> > 
> > OK I'm applying this into omap-for-v4.3/soc. If we ever need the code
> > it will be in the git history.
> 
> Actually I'll wait on this one and apply it later on as it currently
> adds merge conflicts into Linux next.

Looks like this needs to be updated to apply on v4.3-rc4, can you
please repost?

Using v4.3-rc4 as the base for v4.4 because it contains most of the
mmc fixes.

Regards,

Tony
