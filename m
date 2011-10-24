From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
Date: Mon, 24 Oct 2011 11:19:25 +0200
Message-ID: <20111024091924.GA6148@opensource.wolfsonmicro.com>
References: <20111019144215.GA32007@S2100-06.ap.freescale.net>
	<4E9FAF42.5060200@ti.com>
	<20111020061408.GE32007@S2100-06.ap.freescale.net>
	<4EA00F7C.1080005@ti.com>
	<20111021082309.GA337@S2100-06.ap.freescale.net>
	<4EA13053.7080306@ti.com>
	<20111021115809.GB337@S2100-06.ap.freescale.net>
	<4EA4FF6B.2080906@ti.com>
	<20111024081706.GC8708@ponder.secretlab.ca>
	<4EA5279E.3000505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4EA5279E.3000505@ti.com>
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
Cc: patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, lrg@ti.com, Shawn Guo <shawn.guo@freescale.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 24, 2011 at 02:23:50PM +0530, Rajendra Nayak wrote:

> How about the driver passing the of_node to be associated with the
> regulator, as part of regulator_desc, to the regulator core,
> instead of this complete DT search and the restriction of having
> to match DT node names with names in regulator_desc.

regulator_desc should be const so that we handle multiple instances of
the same device nicely.  We could pass the information in as an argument
I guess.
