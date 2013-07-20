From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH] Documentation: dt: bindings: TI WiLink modules
Date: Sat, 20 Jul 2013 10:48:08 +0300
Message-ID: <1374306488.8385.56.camel@cumari.coelho.fi>
References: <1372149330-24335-1-git-send-email-coelho@ti.com>
 <1372425670.21065.61.camel@cumari.coelho.fi>
 <1372682370.21065.68.camel@cumari.coelho.fi> <1698879.DLaB5pbe5M@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1698879.DLaB5pbe5M@avalon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mark Rutland <mark.rutland@arm.com>, mturquette@linaro.org, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, balbi@ti.com, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2013-07-18 at 01:58 +0200, Laurent Pinchart wrote:
> Hi Luciano,

Hi Laurent,

> On Monday 01 July 2013 15:39:30 Luciano Coelho wrote:
> > The only thing I can come up with is to make a small clock driver (maybe
> > even inside the WiLink module itself) that registers a new type of
> > clock, "ti,wilink-clock" or something.  But this would really be
> > overkill, wouldn't it?
> > 
> > Any other ideas?
> 
> One possibility would be to just call clk_get_rate() on the clock from the 
> WiLink driver, which would return the fixed frequency specified in DT, and 
> configure the WiLink hardware accordingly. This might be a bit hackish though.

The problem is not get the rate itself, the problem is knowing whether
the clock is XTAL or not.  The WiLink chip uses the clock in a slightly
different way if it is XTAL, due to some stabilization time constraints.

--
Luca.
