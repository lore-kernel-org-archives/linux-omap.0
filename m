From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] Input: tsc2005 - simplify drvdata acquisition
Date: Wed, 15 Jul 2015 14:31:07 -0700
Message-ID: <20150715213107.GB24393@dtor-ws>
References: <1436962408-5206-1-git-send-email-sre@kernel.org>
 <1436962408-5206-4-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436962408-5206-4-git-send-email-sre@kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-input@vger.kernel.org, Michael Welling <mwelling@emacinc.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 15, 2015 at 02:13:27PM +0200, Sebastian Reichel wrote:
> Do not convert device to spi_device just for getting
> the driver data, since spi_get_drvdata() just calls
> dev_get_drvdata().

Even though at the moment they all share the same data I consider them
logically different and so would prefer not to substityte one for
another.

Thanks.

-- 
Dmitry
