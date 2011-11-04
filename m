From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v4 1/4] regulator: helper routine to extract
	regulator_init_data
Date: Fri, 4 Nov 2011 14:22:16 -0700
Message-ID: <20111104212216.GA5756@quad.lixom.net>
References: <1319721864-30067-1-git-send-email-rnayak@ti.com>
	<20111104202905.GA3918@quad.lixom.net>
	<20111104211447.GC2541@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20111104211447.GC2541@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 04, 2011 at 09:14:48PM +0000, Mark Brown wrote:
> On Fri, Nov 04, 2011 at 01:29:05PM -0700, Olof Johansson wrote:
> > On Thu, Oct 27, 2011 at 06:54:24PM +0530, Rajendra Nayak wrote:
> 
> > > @@ -0,0 +1,33 @@
> > > +Voltage/Current Regulators
> 
> > There should be a mandatory compatible field here, right? I.e. a topmost
> > generic one, "regulator" or similar.
> 
> It's not really useful for the regulator subsystem to directly bind to
> the device as something needs to actually control it, the idea is that
> this binding is included by reference in the bindings for specific
> devices.

Right, same goes for many other devices. Some use a toplevel compatible field,
some do not. Either way, not a big deal if you don't want to include one.

> > Also, lower-caps is common instead of V and A.
> 
> On the other hand the case is pretty important for SI units

Yeah, true. The fixed regulators used microvolt instead, which could be a good
way to do it.

> > > +- <name>-supply: phandle to the parent supply/regulator node
> 
> > Having a fixed name here instead of a free form string would probably be a good
> > idea?
> 
> The name will be fixed by the individual device bindings, this is
> specifying the general form of a supply property.  Each device binding
> will define the set of supplies that the device can use.

Ah, ok. It shouldn't be a part of this binding then and instead be added
to the bindings for the consumers.


-Olof
