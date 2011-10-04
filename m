From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 26/30] ARM: omap: add board autoselection
Date: Tue, 04 Oct 2011 21:29:36 +0200
Message-ID: <2340307.S2RzXdHlIz@wuerfel>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<201110040944.13205.arnd@arndb.de>
	<20111004155752.GT6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111004155752.GT6324@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson,
	Benoit" <b-cousson@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 04 October 2011 08:57:52 Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [111004 00:10]:
> > On Monday 03 October 2011, Tony Lindgren wrote:
> >
> > > Yes please leave out the list so we don't need to constantly update it.
> > > Let's just always build in MACH_OMAP_GENERIC.
> > 
> > That's what I had initially, but now that board file has become
> > omap2-specific and no longer works on omap3-only or omap4-only
> > configurations.
> 
> Will send a pull request for basic DT bootstrap support from Benoit
> that fixes that. So maybe let's sort that out first, then always
> select it?

Yes, sounds good. That is certainly the better solution in the long run.

	Arnd
