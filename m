From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/3] asm-generic: io: Add exec versions of ioremap
Date: Wed, 18 May 2016 22:25:03 +0200
Message-ID: <3861017.ZJOlWYvEFT@wuerfel>
References: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
 <573C7844.5030107@ti.com> <20160518175102.GX5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160518175102.GX5783@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Russ Dill <russ.dill@ti.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 18 May 2016 18:51:02 Russell King - ARM Linux wrote:
> On Wed, May 18, 2016 at 09:12:20AM -0500, Dave Gerlach wrote:
> > Ok thank you for the pointer. I agree, the memremap API looks like a better
> > fit for this. I think it likely makes the most sense to still add these
> > ioremap_exec and ioremap_exec_nocache and then call them through the
> > memremap API based on new flags. This will fit into the current use model
> > for memremap as it currently uses all of the other ioremap calls internally,
> > and doing it how I just described will let this code evolve along with
> > memremap.
> 
> I would _really_ prefer not to do that.  Why?  Because IO memory does
> not have the required properties to be executable.  IO memory is normally
> memory which has side effects - and by side effects, I mean reading it
> can provoke hardware to perform some action.  You don't want to be
> executing from such memory.
> 
> So, in my mind, ioremap_exec makes absolutely no sense, and having it
> gives people a new interface to abuse - and abuse they will.

Agreed, calling it ioremap when it is really memremap makes no sense.

I also see another problem in the asm-generic portion:

+#ifndef ARCH_HAS_IOREMAP_EXEC
+#define ioremap_exec ioremap
+#define ioremap_exec_nocache ioremap_nocache
+#endif

The ARM version of ioremap_exec() that gets added in this patch is cached
(like memremap()), but then the asm-generic version is not? This is
even more confusing, it should at least do roughly the same thing across
architectures.

There should also be some documentation about what the expected behavior is, e.g.:

- is memremap_exec() by default cached or not? (I assume it would
  be like memremap())
- If we have an interface that does explicit uncached executable mapping,
  what about architectures on which this is not possible? Should they
  fall back to cached or non-executable, or cause a link error?  

	Arnd
