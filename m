From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 1/4] regulator: helper routine to extract
	regulator_init_data
Date: Fri, 4 Nov 2011 21:29:10 +0000
Message-ID: <20111104212910.GB8266@opensource.wolfsonmicro.com>
References: <1319721864-30067-1-git-send-email-rnayak@ti.com>
	<20111104202905.GA3918@quad.lixom.net>
	<20111104211447.GC2541@opensource.wolfsonmicro.com>
	<20111104212216.GA5756@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20111104212216.GA5756@quad.lixom.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 04, 2011 at 02:22:16PM -0700, Olof Johansson wrote:
> On Fri, Nov 04, 2011 at 09:14:48PM +0000, Mark Brown wrote:

> > The name will be fixed by the individual device bindings, this is
> > specifying the general form of a supply property.  Each device binding
> > will define the set of supplies that the device can use.

> Ah, ok. It shouldn't be a part of this binding then and instead be added
> to the bindings for the consumers.

I think it's useful to define how consumers are supposed to do this
somewhere - it is actually part of the core binding how consumers are
supposed to do this.

There's also a bit of magic here for chained supplies with one regulator
supplying another (eg, using a DCDC to drop the system supply down to a
lower voltage to supply a bunch of LDOs for improved efficiency).
