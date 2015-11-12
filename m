From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: Minimal support for dm814x
Date: Thu, 12 Nov 2015 10:20:24 +0100
Message-ID: <CAALWOA_dEtajQBLrXesQ2bRCDf-1Dzg_tJw_=yAmaO=T3=KMZQ@mail.gmail.com>
References: <4999BB3D-4BB5-4F7C-96D7-FB687725CDCC@audioscience.com>
 <20151109150602.GR3199@atomide.com>
 <CAALWOA-NUyRYaGbmBZpc6CcFga8_BKPZ9WQTxa3t09bHS_6=qA@mail.gmail.com>
 <7933071D-84FD-4A85-8CD0-CC504CE1D9D1@audioscience.com>
 <20151111174028.GF3218@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151111174028.GF3218@atomide.com>
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
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Delio Brignoli <dbrignoli@audioscience.com>
List-Id: linux-omap@vger.kernel.org

On 11 November 2015 at 18:40, Tony Lindgren <tony@atomide.com> wrote:
> Well we do first try to set the rate using the divider only at least for
> drivers/clk/ti/fapll.c used on dm816x. I'm thinking about doing a similar
> driver for the dm814x adpll where we have a PLL and separate output clocks
> in a single driver as the PLL and output control registers are all mixed in.

Well the output control *is* part of the PLL block. More importantly,
due to the constraints of DPLL-LJ you may need to consider the
postdivider and PLL config together to produce the desired output
frequency.

Note BTW that afaik exactly the same two DPLL types are used in nearly
all TI SoCs (with exception of DM816x, and some enhancements have been
made in the latest SoCs), but since the PLLs themselves only have
wires sticking out, the register interface can vary significantly
between devices. Most of them also wrap a layer of abstraction around
them, while it seems the DM814x just directly wired all available
signals into registers, no added sugar.

Another difference is that normally nearly all DPLLs are DPLL-S (aka
"type A") and often only one is -LJ (aka "type B"), while the
situation is reversed on the DM814x which has only one instance of
DPLL-S and 12 instances of DPLL-LJ. Also unusual is that none have
more than one output divider (no HSDIVIDER blocks present) and only
two (HDMI and USB) make direct use of the undivided dco clock. This
means that, with those two exceptions, you do have complete freedom in
configuring the PLL for the needs of its single output clock.

It does however also mean you can't really escape dealing with the
fussiness of DPLL-LJ like you can on other devices (e.g. the am335x
has only one, which is configured correctly by ROM and can't be
reconfigured without breaking USB.)


Matthijs
