From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC v1] regulator: core: introduce regulator chain locking
 scheme
Date: Mon, 15 Apr 2013 17:40:18 +0100
Message-ID: <20130415164018.GA14064@sirena.org.uk>
References: <1366031015-17073-1-git-send-email-grygorii.strashko@ti.com>
 <1366031015-17073-2-git-send-email-grygorii.strashko@ti.com>
 <20130415155040.GD15837@opensource.wolfsonmicro.com>
 <516C2905.8000200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <516C2905.8000200@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-kernel@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 15, 2013 at 07:21:25PM +0300, Andrii Tseglytskyi wrote:
> On 04/15/2013 06:50 PM, Mark Brown wrote:

> >>In addition, such locking scheme allows to have access to the supplier
> >>regulator API from inside child's (consumer) regulator API.

> >I've still not seen any use case articulated for doing this...

> Use case is introduced in ABB series:

Sorry, I meant any sensible use case.
