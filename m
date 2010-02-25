From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: ads7846: add regulator support
Date: Thu, 25 Feb 2010 02:01:51 -0800
Message-ID: <20100225100151.GE10823@core.coreip.homeip.net>
References: <1266078714-18155-1-git-send-email-notasas@gmail.com>
 <20100213184910.GB31704@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100213184910.GB31704@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Feb 13, 2010 at 06:49:11PM +0000, Mark Brown wrote:
> On Sat, Feb 13, 2010 at 06:31:54PM +0200, Grazvydas Ignotas wrote:
> > The ADS7846/TSC2046 touchscreen controllers can (and usually are)
> > connected to various regulators for power, so add regulator support.
> > 
> > Valid regulator will now be required, so boards without complete
> > regulator setup should either disable regulator framework or enable
> > CONFIG_REGULATOR_DUMMY.
> > 
> > Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> 
> Looks good from a regulator API point of view:
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Will apply to next, thank you Grazvydas.

-- 
Dmitry
