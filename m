From: Tony Lindgren <tony@atomide.com>
Subject: Re: [CFT] Always enable SMP mode on MP capable CPUs
Date: Thu, 25 May 2017 10:10:00 -0700
Message-ID: <20170525171000.GD10472@atomide.com>
References: <20170518105209.GN22219@n2100.armlinux.org.uk>
 <828a8817-b18d-6945-f35e-115abf30fe17@gmail.com>
 <20170525165651.GK22219@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170525165651.GK22219@n2100.armlinux.org.uk>
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
Cc: linux-omap@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, afzal mohammed <afzal.mohd.ma@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [170525 10:00]:
> On Thu, May 25, 2017 at 09:15:19AM -0700, Florian Fainelli wrote:
> > On 05/18/2017 03:52 AM, Russell King - ARM Linux wrote:
> > > As a result of a recent bug report, it has been found that certain CPUs
> > > must always have SMP mode enabled in order for the caches to work.
> > > 
> > > Remove the conditional on setting the SMP bit(s).
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > > ---
> > > This needs to be tested on:
> > > 
> > > - Cortex A5MP
> > > - Cortex A9MP
> > > - Cortex R7MP
> > > - Cortex A7MP
> > > - Cortex A12MP
> > > - Cortex A15MP
> > > - Cortex A17MP
> > > - Brahma B15
> > 
> > Sorry just saw this, what kind of test do you want me to run on B15?
> > Should I build a !SMP kernel, or force a SMP kernel with maxcpus=1?
> 
> What I'm after is testing on any single-core systems with these SMP
> capable cores.  If the core never appears in a single-core configuration,
> then please let me know so it can be crossed off the list.
> 
> With the bug that crept in fixed (as pointed out by Tony) there is no
> difference for kernels built with SMP enabled and detected as a SMP
> capable CPU.

At least am437x needs to be tested as it's UP with some quirks.

Regards,

Tony
