From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: Bunch of CRC errors in next with arm: move exports to definitions
Date: Fri, 26 Aug 2016 19:51:27 +0100
Message-ID: <20160826185127.GX5783@n2100.arm.linux.org.uk>
References: <20160822162512.mptzbiaozx2fz42l@atomide.com>
 <20160826181910.ujtk325yqsmvfpbg@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160826181910.ujtk325yqsmvfpbg@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 26, 2016 at 11:19:10AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [160822 09:28]:
> > Hi Al,
> > 
> > Looks like starting with next-20160818 I'm now getting close to
> > 800 lines of WARNINGs on ARM with omap2plus_defconfig while doing
> > make modules:
> ...
> > Reverting commit 4dd1837d7589 ("arm: move exports to definitions")
> > fixes it.
> 
> And not happening with multi_v7_defconfig for example. Adding Russell
> to Cc, maybe he already has a fix for this one?

I don't, and I'm not aware of the commit either... so this is all a
surprise to me.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
