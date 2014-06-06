From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
Date: Fri, 06 Jun 2014 23:15:06 +0200
Message-ID: <3122018.iBNBjMKNbN@vostro.rjw.lan>
References: <1402051016-28853-1-git-send-email-broonie@kernel.org>
 <20140606125003.GA13332@verge.net.au> <20140606130850.GO2520@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140606130850.GO2520@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, linux-samsung-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Shawn Guo <shawn.guo@freescale.com>
List-Id: linux-omap@vger.kernel.org

On Friday, June 06, 2014 02:08:50 PM Mark Brown wrote:
> 
> --cU9XODsizZBnwgll
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Fri, Jun 06, 2014 at 09:50:06PM +0900, Simon Horman wrote:
> > On Fri, Jun 06, 2014 at 09:14:01PM +0900, Magnus Damm wrote:
> 
> > > I'm not sure about the expected merge order for this kind of change vs
> > > queued up stuff in the renesas git tree, but I believe the following
> > > patch selects ARCH_HAS_OPP:
> 
> > > [PATCH v3] ARM: shmobile: Mark all SoCs in shmobile as CPUFreq, capable
> 
> > I propose that we fix that up by adding an incremental patch to
> > mach-shmobile via my renesas tree once the dependency (assuming there is
> > one) is in Linus's tree.
> 
> Yes, the conversion to make ARCH_HAS_OPP unused is in Raphael's tree for
> the merge window.

Perhaps already merged?

Rafael
