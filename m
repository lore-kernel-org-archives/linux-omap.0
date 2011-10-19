From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
Date: Wed, 19 Oct 2011 15:50:00 +0100
Message-ID: <20111019144959.GA31850@opensource.wolfsonmicro.com>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
	<1318263578-7407-4-git-send-email-rnayak@ti.com>
	<20111018132032.GD30703@S2100-06.ap.freescale.net>
	<4E9EB61C.1040207@ti.com>
	<20111019144215.GA32007@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20111019144215.GA32007@S2100-06.ap.freescale.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 19, 2011 at 10:42:16PM +0800, Shawn Guo wrote:

*Please* delete irrelevant quotes from mails.

> On Wed, Oct 19, 2011 at 05:05:56PM +0530, Rajendra Nayak wrote:

> > Yes, it seems like a good idea given that most drivers seem to blindly
> > pass the regulator_init_data onto regulator_register, however there
> > are cases like the twl regulator driver which seems to peek into the
> > constraints passed from the board to make sure it drops anything that
> > the hardware does not support,

> I'm not sure why twl works in that way.  Is it a sign that those
> configuration peeked by twl regulator driver should be encoded in twl
> regulator driver itself instead of being passed from the board?  Or
> why the board does not pass something matching driver/hardware
> capability to save that peek?

It's completely unneeded but harmless, it's there because there were a
large number of discussions going on with the original author and it was
easier to merge the code.
