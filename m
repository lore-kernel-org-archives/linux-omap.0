From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3] OMAP2/3: clock: fix fint calculation for
 DPLL_FREQSEL
Date: Mon, 7 Feb 2011 20:09:34 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102072008480.21991@utopia.booyaka.com>
References: <87ei8726wf.fsf@vostro.fn.ogness.net> <20110120111645.GB2223@legolas.emea.dhcp.ti.com> <8739on1wdd.fsf_-_@vostro.fn.ogness.net> <20110121031553.GA2448@legolas.emea.dhcp.ti.com> <87y66e3bc2.fsf_-_@vostro.fn.ogness.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87y66e3bc2.fsf_-_@vostro.fn.ogness.net>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, 21 Jan 2011, John Ogness wrote:

> From: John Ogness <john.ogness@linutronix.de>
> 
> In OMAP35X TRM Rev 2010-05 Figure 7-18 "DPLL With EMI Reduction
> Feature", it is shown that the internal frequency is calculated by
> CLK_IN/(N+1). However, the value passed to _dpll_test_fint() is
> already "N+1" since Linux is using the values to divide by. In the
> technical reference manual, "N" is referring to the divider's register
> value (0-127).
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Thanks for the patch, John.  Probably this should go into the -rc series 
since it could affect system stability, so will queue it there.


- Paul
