From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/5] regulator: twl: Remove hardcoded board
 constraints from driver
Date: Mon, 10 Oct 2011 17:25:07 +0100
Message-ID: <20111010162507.GF3607@opensource.wolfsonmicro.com>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
 <1318263578-7407-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1318263578-7407-2-git-send-email-rnayak@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 10, 2011 at 09:49:34PM +0530, Rajendra Nayak wrote:
> Remove the hardcoded .valid_modes_mask and .valid_ops_mask for
> each regulator from the twl driver and let the boards pass it.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Please update this changelog - as I said in reply to your previous
posting this isn't actually hardcoding anything, it's dropping things
from the constraints which the hardware doesn't support.
