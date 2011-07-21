From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: conflicts between omap/cleanup branch and omap_dss2 tree
Date: Thu, 21 Jul 2011 10:19:44 +0300
Message-ID: <1311232784.1874.3.camel@deskari>
References: <201107172339.32516.arnd@arndb.de>
	<20110718080856.GW5783@atomide.com> <4E25784D.8070300@ti.com>
	<201107191459.44992.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201107191459.44992.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 2011-07-19 at 14:59 +0200, Arnd Bergmann wrote:
> On Tuesday 19 July 2011, Archit Taneja wrote:
> > Tomi is on vacation right now, but he checks his mail once in a while, 
> > so we may get a response soon.
> > 
> > Tomi's for-next branch is not up to date yet. So it shouldn't be 
> > considered for now. The HWMOD patches in Tomi's for-next branch will be 
> > pushed by Paul as 3.1-rc fixes.
> > 
> > We will make a temporary branch which will contain all the DSS2 patches 
> > which Tomi intended to push for this merge window, once he gets a 
> > chance, he can quickly update his for-next branch with it.
> 
> Ok, just let me know when you upload that branch so I can remove the
> dependency from the arm-soc tree. Right now, I'm pulling the
> omap_dss2/for_next branch into arm-soc/for_next as a dependency
> to resolve the conflict.

I've pushed a new for-next branch to
git://gitorious.org/linux-omap-dss2/linux.git for-next. However, I
decided to just reset it to -rc4 for now.

The latest DSS code does not work without bunch of HWMOD/omap_device
patches so I'm not sure if there's any point to push the code to
linux-next which, afaik, does not currently have those HWMOD/omap_device
patches (Paul, correct me if I'm wrong).

 Tomi
