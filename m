From: Hannes Schmelzer <Hannes.Schmelzer@br-automation.com>
Subject: Re: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Fri, 28 Aug 2015 06:44:02 +0200
Message-ID: <OF3C55E837.F60C3642-ONC1257EAF.0019FAE8-C1257EAF.001A0165@br-automation.com>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <1432156863-19695-3-git-send-email-tony@atomide.com>
 <OFCA2F1DCE.C787A961-ONC1257EAE.001D79BC-C1257EAE.00203AFF@br-automation.com>
 <20150827165940.GY4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150827165940.GY4215@atomide.com>
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
Cc: Paul Walmsley <paul@pwsan.com>, Hannes Schmelzer <Hannes.Schmelzer@br-automation.com>, linux-omap-owner@vger.kernel.org, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

> 
> Hi,
Hi,

> 
> * Hannes Schmelzer <Hannes.Schmelzer@br-automation.com> [150826 22:55]:
> > Hi Tony,
> > 
> > Did anyone test this changeset on some AM335x board?
> 
> Apparently not if it does not work or else you somehow have a different
> configuration for GPMC.
> 
> > Today I ran into trouble with that because:
> > 
> > The GPMC controller gets reseted on kernel boot due to the 
missing/removed 
> > HWMOD_INIT_NO_RESET flag.
> 
> Oh so you mean it only works on am335x if CONFIG_OMAP_GPMC_DEBUG is set?
Exactly.

> 
> > I also tried to issue some SYSRESET through GPMC registers without 
> > success, same strange behavior.
> 
> Interesting, never heard of that one before.

Unfortunately i only have my B&R hardware to test,
maybe somebody else has an am335x board with NAND flash on it and can 
test.


> > What?s your thinking around that?
> 
> We could add a custom hwmod reset function that sets GPMC_CONFIG to 0.
> Similar to omap_i2c_reset() is set up. 
This would be possible, but we've to take care that such functions isn't 
called during the new introduced debug-case.


> Or we could set up a property for
> the wait pin polarity. Roger, got any better ideas?

In general, it would be a good idea to introduce a dt-property to control 
the polarity of the wait pins, since there is allready a property to 
select the wait pin - this would make the thing complete.

> 
> Regards,
> Tony

best regards,
Hannes
