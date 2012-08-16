From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v2 04/14] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Thu, 16 Aug 2012 09:36:44 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA91188@DBDE01.ent.ti.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-5-git-send-email-santosh.shilimkar@ti.com>
 <4FFA9B61.8030808@ti.com> <20120709131156.GH1122@atomide.com>
 <alpine.DEB.2.00.1208151618590.1731@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1208151618590.1731@utopia.booyaka.com>
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
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: "R, Sricharan" <r.sricharan@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar,
 Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 16, 2012 at 03:56:42, Paul Walmsley wrote:
> Hi
> 
> On Mon, 9 Jul 2012, Tony Lindgren wrote:
> 
> > Below (untested) is what could be done in the short term.
> 
> That's fine with me.  Do you want to queue it or do you want me to queue 
> it?
> 
> > Heh these CK_XXXX defines are now running out of the u16 cpu_mask.
> > 
> > They really should be replaced with SoC specific lists of clocks
> > rather than bloating the cpu_mask and repeating it for every clock
> > that's compiled in for 800+ times.
> 
> Frankly, an extra 1.6KB -- uncompressed -- is pretty low on my list of 
> bloat concerns for multi-OMAP kernels.  If it were up to me, I'd just 
> change it to a u32 and be done with the problem for the foreseeable 
> future.
> 
> > I wonder if we could #define CK_OMAP_DUMMY 0 that's always set
> > for non-shared clocks if they only get set in some *_data.c
> > file in a unique way?
> > 
> > Paul got any better ideas?
> 
> Aside from using u32?  Not really.  As we've discussed in the past, at 
> some point we should convert the clock initialization to using some kind 
> of per-SoC list.  But it doesn't seem worth spending too much time on that 
> while the common clock framework conversion is higher priority.
> 
> 

This reminds me for AM33xx clock-tree migration to common-clock framework,
so just wanted to update on this, I have already converted the clock-tree to 
common-clock fw, on top of Rajendra's repository.

Now waiting on Rajendra for his next series...

Thanks,
Vaibhav
