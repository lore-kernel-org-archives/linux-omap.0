From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V5 2/3] arm:omap:am33xx: Add AM335XEVM machine support
Date: Fri, 4 May 2012 06:14:00 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA1411F@DBDE01.ent.ti.com>
References: <hvaibhav@ti.com>
 <1322808204-12878-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1205020317151.19695@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA10A64@DBDE01.ent.ti.com>
 <20120503155717.GE5140@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA1348F@DBDE01.ent.ti.com>
 <20120503193732.GG5140@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120503193732.GG5140@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mohammed,
 Afzal" <afzal@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, May 04, 2012 at 01:07:32, Tony Lindgren wrote:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [120503 09:45]:
> > 
> > What about cpu_is_omap34xx() true for am33xx? Should we follow it?
> 
> Well are there components that could be used as is with that?
> If not, then it probably does not make sense.
> 

I am also in favor of not following cpu_is_omap34xx() for am33xx, but what about ARCH_OMAP?
I don't see that you are in agreement in creating ARCH_OMAPAM33XX. 
Does it make sense to say that, for am33xx, cpu_is_omap34xx() is false, but still it is under ARCH_OMAP3?


> BTW, you should post your patches on top of the clean-up patches
> Santosh posted as that already leaves out some cpu_is_omapxxxx
> checks. That's the "ARM: OMAP2+: Misc cleanup" thread.
> 

Ok. I will do that.

Thanks,
Vaibhav
