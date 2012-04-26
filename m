From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree data
Date: Thu, 26 Apr 2012 02:44:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204260242390.10308@utopia.booyaka.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204260017540.30642@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9FEBA6@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <79CD15C6BA57404B839C016229A409A83E9FEBA6@DBDE01.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 26 Apr 2012, Hiremath, Vaibhav wrote:

> On Thu, Apr 26, 2012 at 11:54:51, Paul Walmsley wrote:
> > 
> > while working on clock33xx_data.c, it became clear that we would not be 
> > able to remove the MODULEMODE leaf clocks for several IP blocks that share 
> > driver code with other DaVinci chips.  This is because:
> > 
> > 1. the drivers for these IP blocks only use the clock framework, rather 
> > than runtime PM;
> > 
> > and 
> > 
> > 2. the clk_get() calls in those drivers do not specify a con_id 
> > parameter, which could cause problems with the clkdev clk_find()'s fuzzy 
> > matching algorithm.
> > 
> > So perhaps your group can work on converting the drivers to use runtime 
> > PM?  Discussing this with Kevin, it sounds like DaVinci doesn't have 
> > runtime PM hooks implemented, but you can probably use OMAP1 as an example 
> > of how to do it.
> > 
> > And then if clk_get() is still needed in the drivers, a specific con_id 
> > should be supplied, such as "fck", which can also be supplied by the OMAP 
> > codebase.
> 
> Honestly, I don't want to block AM33xx stuff getting into mainline due to 
> missing feature in Davinci.
> 
> Also, since AM33xx is not fully supported in the mainline (from peripheral 
> perspective), it really should not break anything as of now.
> 
> I am expecting, AM33xx core patches will get in by v3.5 and then while 
> adding peripheral support we will take Davinci migration activity, and can
> make sure that nothing breaks (for all Davinci, OMAP and AM33xx).

To be clear, I am not suggesting that the AM33xx stuff should be blocked 
by these changes.  I am however suggesting that it be added to the to-do 
list, so we can remove most or all of the remaining MODULEMODE clocks from 
the AM33xx clock tree.  Sounds like you are planning to work on that at 
some point, which is good.


- Paul
