From: Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH V5 1/3] arm: dts: dra7: Add crossbar device binding
Date: Tue, 6 May 2014 15:07:50 -0500
Message-ID: <20140506200750.GE2626@ti.com>
References: <1399384579-25620-1-git-send-email-r.sricharan@ti.com>
 <1399384579-25620-2-git-send-email-r.sricharan@ti.com>
 <20140506194055.GA6962@saruman.home> <53693C02.2090305@ti.com>
 <20140506195804.GD2626@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140506195804.GD2626@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, linux-doc@vger.kernel.org, tony@atomide.com, linus.walleij@linaro.org, rnayak@ti.com, linux-kernel@vger.kernel.org, balbi@ti.com, Sricharan R <r.sricharan@ti.com>, santosh.shilimkar@ti.com, bcousson@baylibre.com, galak@codeaurora.org, marc.zyngier@arm.com, tglx@linutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@linaro.org
List-Id: linux-omap@vger.kernel.org

Darren Etheridge <detheridge@ti.com> wrote on Tue [2014-May-06 14:58:04 -0500]:
> Nishanth Menon <nm@ti.com> wrote on Tue [2014-May-06 14:46:10 -0500]:
> > On 05/06/2014 02:40 PM, Felipe Balbi wrote:
> > > On Tue, May 06, 2014 at 07:26:17PM +0530, Sricharan R wrote:
> > >> This adds the irq crossbar device node.
> > >>
> > >> There is a IRQ crossbar device in the soc, which
> > >> maps the irq requests from the peripherals to the
> > >> mpu interrupt controller's inputs. The Peripheral irq
> > >> requests are connected to only one crossbar
> > >> input and the output of the crossbar is connected to only one
> > >> controller's input line. The crossbar device is used to map
> > >> a peripheral input to a free mpu's interrupt controller line.
> > >>
> > >> Cc: Benoit Cousson <bcousson@baylibre.com>
> > >> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > >> Cc: Rajendra Nayak <rnayak@ti.com>
> > >> Cc: Tony Lindgren <tony@atomide.com>
> > >> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> > >> Signed-off-by: Nishanth Menon <nm@ti.com>
> > >> ---
> > >> [V5] Rebased on top of 3.15-rc4 and corrected the
> > >>      irqs-reserved list
> > >>
> > >>  arch/arm/boot/dts/dra7.dtsi |    8 ++++++++
> > >>  1 file changed, 8 insertions(+)
> > >>
> > >> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> > >> index 149b550..0274a86 100644
> > >> --- a/arch/arm/boot/dts/dra7.dtsi
> > >> +++ b/arch/arm/boot/dts/dra7.dtsi
> > >> @@ -790,6 +790,14 @@
> > >>  			status = "disabled";
> > >>  		};
> > >>  	};
> > >> +
> > >> +	crossbar_mpu: crossbar@4a020000 {
> > > 
> > > shouldn't this be "status = disabled"; so that boards enable this
> > > on-demand ??
> > > 
> > It cannot be and does not need to be. crossbar is an SoC feature. by
> > defining crossbar, the IRQ numbers we provide in DTS now becomes
> > crossbar numbers which get mapped to GIC interrupt numbers dynamically.
> > 
> > further crossbar is not a board feature. it is as ingrained in DRA7
> > behavior as GIC is. we are fortunate that we have some default mapping
> > of crossbar that allows the current peripherals to work, with this
> > support, we dont have to depend any longer on "we are lucky that is
> > mapped".
> > 
> > That said, in hindsight, patch #1 and 2 should be squashed IMHO. else
> > we have a bisectability problem here.
> > 
> Yes the bisectability problem is completely true - I was just testing
> that as your email came in.  In fact I think all three patches need to
> be squashed into one, I can't boot the dra7-EVM unless I have all three
> patches applied.
> 

Or I just tried reordering, so patch 3/3 becomes patch 1 and then squash
patch 1/3 and patch 2/3 together to form patch 2.  That seems to at
least let the kernel boot to completion.

Darren
