From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
Date: Fri, 30 Sep 2011 13:18:44 +0100
Message-ID: <20110930121844.GI5366@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-3-git-send-email-rnayak@ti.com>
	<20110927121003.GB4289@opensource.wolfsonmicro.com>
	<4E81E224.2070408@ti.com>
	<20110927150511.GM4289@opensource.wolfsonmicro.com>
	<4E854532.6080605@ti.com>
	<20110930102849.GA4195@opensource.wolfsonmicro.com>
	<20110930104820.GE2085@sirena.org.uk> <4E85A34E.9070203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4E85A34E.9070203@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 30, 2011 at 04:39:02PM +0530, Rajendra Nayak wrote:

> The "regulator-supplies" is used to specific the regulator *parent*.
> Same as what was earlier passed by using the
> "supply_regulator" field of regulator_init_data structure.
> Grant wanted the bindings to support specifying multiple parents
> and hence I was thinking of either a list of names *or*
> a list of phandles to specify multiple parents to a regulator.

So, as I'm fairly sure I said last time these are just standard
supplies.  It just happens to be that the consumer is a regulator.  The
fact that Linux chooses to have core framework handling for this is an
implementation detail of Linux (and indeed many devices ignore this for
their on board regulators).
