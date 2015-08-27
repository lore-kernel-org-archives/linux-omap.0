From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Thu, 27 Aug 2015 09:59:41 -0700
Message-ID: <20150827165940.GY4215@atomide.com>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <1432156863-19695-3-git-send-email-tony@atomide.com>
 <OFCA2F1DCE.C787A961-ONC1257EAE.001D79BC-C1257EAE.00203AFF@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <OFCA2F1DCE.C787A961-ONC1257EAE.001D79BC-C1257EAE.00203AFF@br-automation.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hannes Schmelzer <Hannes.Schmelzer@br-automation.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap-owner@vger.kernel.org, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Hannes Schmelzer <Hannes.Schmelzer@br-automation.com> [150826 22:55]:
> Hi Tony,
> 
> Did anyone test this changeset on some AM335x board?

Apparently not if it does not work or else you somehow have a different
configuration for GPMC.
 
> Today I ran into trouble with that because:
> 
> The GPMC controller gets reseted on kernel boot due to the missing/removed 
> HWMOD_INIT_NO_RESET flag.

Oh so you mean it only works on am335x if CONFIG_OMAP_GPMC_DEBUG is set?
 
> Primary this should not be a big problem, but on my board (maybe on all 
> AM335x) the GPMC doesn't behave as described in TRM.
> Especially the GPMC_CONFIG register is not reset to 0h after reset, 
> instead it holds the value 0xa00 which is very strange because bit 10-31 
> are reserved.
> 
> Further this 0xa00 means that Bit9 (WAIT1PINPOLARITY) is set, exactly this 
> causes my system to stall on first access the connected NAND flash because 
> it never becomes ready due to the wrong wait pin polarity. Maybe others 
> dont't run into trouble because they may use WAIT0PIN, which one has it's 
> old polarity.
> 
> First approach was simply to write 0x0 to the GPMC_CONFIG register during 
> gpmc_probe function.
> It solves the problem.

OK
 
> I also tried to issue some SYSRESET through GPMC registers without 
> success, same strange behavior.

Interesting, never heard of that one before.
 
> What?s your thinking around that?

We could add a custom hwmod reset function that sets GPMC_CONFIG to 0.
Similar to omap_i2c_reset() is set up. Or we could set up a property for
the wait pin polarity. Roger, got any better ideas?

Regards,

Tony
