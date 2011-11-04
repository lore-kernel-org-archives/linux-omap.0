From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 2/4] regulator: adapt fixed regulator driver to dt
Date: Fri, 4 Nov 2011 14:18:24 -0700
Message-ID: <20111104211824.GA5608@quad.lixom.net>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
	<1319702185-16108-3-git-send-email-rnayak@ti.com>
	<20111104203422.GB3918@quad.lixom.net>
	<20111104210151.GA2541@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20111104210151.GA2541@opensource.wolfsonmicro.com>
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

On Fri, Nov 04, 2011 at 09:01:52PM +0000, Mark Brown wrote:
> On Fri, Nov 04, 2011 at 01:34:22PM -0700, Olof Johansson wrote:
> 
> > Shouldn't a fixed regulator just be a subset of a fixed one? If so, should the
> > binding be merged with that one?
> 
> No, the fixed voltage regultor is a superset of a general regulator - it
> has additional information like the voltage it supplies and the optional
> enable GPIO.

Still, seems like it could be merged into one regulator binding.

> > > +- regulator-fixed-enabled-at-boot: 1 = yes, 0 = no
> 
> > Same here, you can drop the prefix. Also, the regular regulators use
> > "regulator-name" for the supply name, it would make sense to reuse the same
> > naming here, right?
> 
> I'm having a hard time associating your second comment with the property
> being discussed - could you clarify please?

It was the first comment I wrote on the whole block and later interspersed
other comments above, so I don't blame you for not understanding. The
second comment was related to the "regulator-fixed-supply" property at
the top of the block.


-Olof
