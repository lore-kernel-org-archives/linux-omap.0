From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: rcu self-detected stall messages on OMAP3, 4 boards
Date: Sun, 23 Sep 2012 05:11:12 -0700
Message-ID: <20120923121112.GK2934@linux.vnet.ibm.com>
References: <alpine.DEB.2.00.1209211803290.8839@utopia.booyaka.com>
 <20120921185827.GC2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209211900520.8839@utopia.booyaka.com>
 <20120921195717.GD2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209221836070.10663@utopia.booyaka.com>
 <20120922201043.GE2934@linux.vnet.ibm.com>
 <20120922215923.GA13161@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209222223080.22590@utopia.booyaka.com>
 <20120922231121.GH2934@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209230753120.7868@utopia.booyaka.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1209230753120.7868@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "<snijsure@grid-net.com>" <snijsure@grid-net.com>, fweisbec@gmail.com, "Bruce,
 Becky" <bbruce@ti.com>, "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paul.mckenney@linaro.org>, "Shilimkar,
 Santosh" <santosh.shilimkar@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<linux-arm-kernel@lists.infradead.org>" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Sep 23, 2012 at 07:55:50AM +0000, Paul Walmsley wrote:
> On Sat, 22 Sep 2012, Paul E. McKenney wrote:
> 
> > On Sat, Sep 22, 2012 at 10:25:59PM +0000, Paul Walmsley wrote:
> > 
> > > The recent tests here have been on Pandaboard, which is dual-CPU, but my 
> > > recollection is that I also observed the warnings on a single-core 
> > > Beagleboard.  Will re-test.
> > 
> > Anxiously awaiting the results.
> 
> The same problem exists on BeagleBoard XM (OMAP3730, single-core 
> Cortex-A8):
> 
>    http://www.pwsan.com/omap/transcripts/20120922-beaglexm-rcu-stall-debug-pre-fix.txt
> 
> and the same patch fixes it:
> 
>    http://www.pwsan.com/omap/transcripts/20120922-beaglexm-rcu-stall-debug-post-fix.txt
> 
> Please feel free to update my Tested-by:, if you wish.
> 
> Tested-by: Paul Walmsley <paul@pwsan.com>  # OMAP3730, OMAP4430

Very good, thank you very much!!!

							Thanx, Paul
