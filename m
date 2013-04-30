From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest build results - errors/warnings - lots of them
Date: Tue, 30 Apr 2013 09:11:04 -0700
Message-ID: <20130430161104.GB26257@atomide.com>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk>
 <201304301304.20650.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201304301304.20650.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [130430 04:10]:
> On Tuesday 30 April 2013, Russell King - ARM Linux wrote:
> > Latest nightly build of 3.9+my for-next+arm-soc's for-next results in a
> > great load of new warnings and errors.  arch/arm/common/mcpm_head.S,
> > arch/arm/common/mcpm_platsmp.c, arch/arm/common/vlock.S are the biggest
> > source of errors.
> 
> Yes, I noticed this but haven't gotten around to prepare a patch. I'll comment
> below.
> 
> > OMAP stuff needs a serious look at too - much Kconfig madness there
> > caused by over-use of select, which then goes on to cause build errors
> > because it assumes some stuff is always enabled.

I have posted a few randconfig fixes in "[PATCH 0/3] few omap randconfig
fixes for v3.10" that also remove the select of SERIAL_OMAP that I missed
while fixing the 8250 issue. I was planning to send a pull request after
the merge window, but can do it now too if people prefer that.
 
> Ack. I have not looked much at randconfig output, but this has certianly
> grown worse after CONFIG_ARCH_OMAP has gotten included in ARCH_MULTIPLATFORM

I have a patch coming for the "no SoC selected" randconfig issue as
discussed in the "linux-next ARM multi-platform randconfig errors"
thread. I suggest we do the minimal fix I already posted for now,
then reorganize more of the Makefile as Arnd suggested for v3.11.

Regards,

Tony
