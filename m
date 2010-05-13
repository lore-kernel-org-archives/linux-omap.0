From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Thu, 13 May 2010 15:01:39 -0700
Message-ID: <20100513220139.GO3428@atomide.com>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
	<20100505150209.GC2606@n2100.arm.linux.org.uk>
	<20100513174023.GB13001@n2100.arm.linux.org.uk>
	<20100513211951.GH3428@atomide.com>
	<20100513215825.GC13001@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20100513215825.GC13001@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100513 14:53]:
> On Thu, May 13, 2010 at 02:19:51PM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100513 10:35]:
> > > And here's a patch which converts the OMAP FB code to use lmb_reserve
> > > instead of poking about with bootmem stuff.  Untested, so I'd like to
> > > hear back whether it works.
> > 
> > Did a quick test with the following patches picked from your lmb
> > branch on top of omap for-next branch:
> > 
> > ARM: Remove useless linux/bootmem.h includes
> > ARM: Ensure meminfo is sorted prior to sanity_check_meminfo
> > ARM: initial LMB trial
> > ARM: Move platform LMB memory reservations out of generic code
> > 
> > and then this patch.
> > 
> > It does not boot.. It seems to be related to the patch
> > "ARM: initial LMB trial". If I only apply the first two patches
> > above the system boots.
> 
> Hmm, I'm sure it worked for me when I tested it out.  Could you try
> booting with lmb=debug please?

No other output with that it seems.

Tony
