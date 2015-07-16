From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] Input: tsc2005 - simplify drvdata acquisition
Date: Wed, 15 Jul 2015 17:22:56 -0700
Message-ID: <20150716002256.GE24393@dtor-ws>
References: <1436962408-5206-1-git-send-email-sre@kernel.org>
 <1436962408-5206-4-git-send-email-sre@kernel.org>
 <20150715213107.GB24393@dtor-ws>
 <20150715220220.GC2591@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150715220220.GC2591@earth>
Sender: linux-input-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-input@vger.kernel.org, Michael Welling <mwelling@emacinc.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 16, 2015 at 12:02:21AM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Jul 15, 2015 at 02:31:07PM -0700, Dmitry Torokhov wrote:
> > On Wed, Jul 15, 2015 at 02:13:27PM +0200, Sebastian Reichel wrote:
> > > Do not convert device to spi_device just for getting
> > > the driver data, since spi_get_drvdata() just calls
> > > dev_get_drvdata().
> > 
> > Even though at the moment they all share the same data I consider them
> > logically different and so would prefer not to substityte one for
> > another.
> 
> I guess your problem is with mixing spi_*_drvdata and dev_*_drvdata
> calls? In that case I will also change spi_set_drvdata to
> dev_set_drvdata, so that spi_*_drvdata is not used at all.
> 
> This will still reduce lines of code and flatten the way for tsc2004
> support (which is i2c based).

OK, that will work.

Thanks.

-- 
Dmitry
