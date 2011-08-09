From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/13] Clean up mach/gpio.h headers
Date: Tue, 9 Aug 2011 22:32:30 +0100
Message-ID: <20110809213230.GC14281@n2100.arm.linux.org.uk>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
	<20110809210055.GF11568@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110809210055.GF11568@ponder.secretlab.ca>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-samsung-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-msm@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 09, 2011 at 03:00:55PM -0600, Grant Likely wrote:
> On Tue, Aug 09, 2011 at 09:04:12AM +0100, Russell King - ARM Linux wrote:
> > This is a preliminary posting of my gpio patch set.
> > 
> > This patch series moves the trivial gpiolib implementations out of
> > mach/gpio.h and into asm/gpio.h.
> > 
> > As a side effect of that, most of this patch series is about fixing up
> > direct includes of mach/gpio.h - this is something I've been on at
> > people over the last year or more about ensuring that they use
> > linux/gpio.h in preference.  While I've blindly converted all arch/arm
> > to use linux/gpio.h (with the exception of mach/ includes which are
> > converted to asm/gpio.h), drivers were only converted to asm/gpio.h.
> > These should be reviewed and changed to linux/gpio.h.
> > 
> > As a result of this patch series, several mach/gpio.h end up being
> > empty.
> > 
> > Many others just contain platform private GPIO APIs and definitions.
> > 
> > The last thing which mach/gpio.h is used for is to provide a definition
> > for ARCH_GPIO_NR to asm-generic/gpio.h.  I've not attempted to solve
> > that issue yet.
> > 
> > A small number of platforms optimize the gpio accessors for on-SoC
> > GPIOs.  In the interests of consolidation, these will have to be killed
> > but this patch set does not do that yet.
> > 
> > Lastly, several {mach,plat}/gpio.h needs to be looked at with a view to
> > deleting the direct include of asm-generic/gpio.h.
> 
> Looks good to me, though I haven't looked closely.  I imagine this
> should get merged via a branch in the arm-soc tree?

And this is where the existence of the arm-soc tree makes things more
difficult for me.  I'd normally just keep it as a separate branch in
my own tree.  What I do now, I've no idea.
