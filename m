From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] perf: add OMAP support for the new power events
Date: Mon, 10 Jan 2011 12:06:13 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101101205130.5731@utopia.booyaka.com>
References: <1294136263-24020-1-git-send-email-j-pihet@ti.com> <1294138484-24729-1-git-send-email-j-pihet@ti.com> <alpine.DEB.2.00.1101041146160.19319@utopia.booyaka.com> <AANLkTi=3pek3+Vv+c1TCxBH2RJcoSXq8TL8CyK9ABMeu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=3pek3+Vv+c1TCxBH2RJcoSXq8TL8CyK9ABMeu@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: mingo@elte.hu, trenn@suse.de, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-perf-users@vger.kernel.org, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello Jean,

On Wed, 5 Jan 2011, Jean Pihet wrote:

> On Tue, Jan 4, 2011 at 7:48 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> > If the latter, then it might make sense to put these
> > trace points into the functions that actually change the hardware
> > registers, e.g., omap2_dflt_clk_{enable,disable}(), etc., since a
> > clk_enable() on a leaf clock may result in many internal system clocks
> > being enabled up the clock tree.
> I agree with you it is better to track the actual clock changes instead.
> I propose to move the tracepoints to omap2_clk_{enable...} which
> enables all the clocks irrespectively of the installed handler.

Yes, that is a better place.

> Note about the clock handlers: omap2_dflt_clk_enable happens to be the
> handler for all controllable clocks but could that change in the
> future?

Yes, it certainly could.


- Paul
