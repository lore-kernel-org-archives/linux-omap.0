From: Hannes Schmelzer <Hannes.Schmelzer@br-automation.com>
Subject: Antwort: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for
 debug
Date: Tue, 1 Sep 2015 15:31:42 +0200
Message-ID: <OFFEAB70E0.C9C6AAC7-ONC1257EB3.0049139E-C1257EB3.004A5089@br-automation.com>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <1432156863-19695-3-git-send-email-tony@atomide.com>
 <OFCA2F1DCE.C787A961-ONC1257EAE.001D79BC-C1257EAE.00203AFF@br-automation.com>
 <55E59B9A.1010007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <55E59B9A.1010007@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Hannes Schmelzer <Hannes.Schmelzer@br-automation.com>, linux-omap-owner@vger.kernel.org, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

> Hi Hannes,
Hi Roger,

> 
> On 27/08/15 08:52, Hannes Schmelzer wrote:
> > Hi Tony,
> > 
> > Did anyone test this changeset on some AM335x board?
> > 
> > Today I ran into trouble with that because:
> > 
> > The GPMC controller gets reseted on kernel boot due to the 
missing/removed 
> HWMOD_INIT_NO_RESET flag.
> > 
> > Primary this should not be a big problem, but on my board (maybe on 
all 
> AM335x) the GPMC doesn't behave as described in TRM.
> > Especially the GPMC_CONFIG register is not reset to 0h after reset, 
instead 
> it holds the value 0xa00 which is very strange because bit 10-31 are 
reserved.
> > 
> > Further this 0xa00 means that Bit9 (WAIT1PINPOLARITY) is set, exactly 
this 
> causes my system to stall on first access the connected NAND flash 
because it 
> never becomes ready due to the wrong wait pin polarity. Maybe others 
dont't 
> run into trouble because they may use WAIT0PIN, which one has it's old 
polarity.
> 
> So nand ready/busy pin is connected to waitpin1 through an inverter on 
your board?
> 
> On am335x-evm we use waitpin0. Nand ready/busy is directly connected to 
waitpin0.

No there is no inverter between flash and AM335x, the READY_nBUSY line is 
directly connected to waitpin1.
But your sentence brings some good idea to me, i will try to solder some 
inverter into the READY_nBUSY line on my board and see if the problem 
appears again.
If i'm right in my theory that the value 0xa00 in GPMC_CONFIG register is 
the problem, the inverter would solve it.

You're right am335x-evm uses waitpin0, which one is not affected from this 
"bug".
I have to use waitpin1, because i also have a 2nd ethernet interface 
connected, and there is waitpin0 uses for collission detect signal from 
the phy (other pinmux).

> For NAND operation read/write wait monitoring must be disabled.
> The nand driver uses the WAIT pin purely for Read/Busy signalling.
> Unfortunately the existing driver cannot handle anything other than 
waitpin 0 
> for nand for DT boot.
for sure ? have a look to omap-gpmc.c at line #90.
Here i can see that either can be used.

> 
> I've tried to address this issue here
> http://thread.gmane.org/gmane.linux.drivers.devicetree/131076
This is useful if the READY_nBUSY line cannot be connected to the GPMC 
itself, instead it maybe connected to some other gpio.
But it doesn't solve the problem.

> 
> cheers,
> -roger
best regards,
Hannes
