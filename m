From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] mfd: cpcap: Fix bad use of IRQ sense register
Date: Sun, 19 Mar 2017 09:07:20 -0700
Message-ID: <20170319160720.GZ20572@atomide.com>
References: <20170317003633.7361-1-tony@atomide.com>
 <20170317003633.7361-5-tony@atomide.com>
 <20170319020118.4oh6sny5phqpatit@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170319020118.4oh6sny5phqpatit@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [170318 19:03]:
> On Thu, Mar 16, 2017 at 05:36:33PM -0700, Tony Lindgren wrote:
> > The cpcap INTS registers are for getting the value of the line,
> > not for configuring the type.
> > 
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Marcel Partap <mpartap@gmx.net>
> > Cc: Michael Scott <michael.scott@linaro.org>
> > Cc: Sebastian Reichel <sre@kernel.org>
> 
> Reviewed-By: Sebastian Reichel <sre@kernel.org>
> 
> > Signed-off-by: Tony Lindgrne <tony@atomide.com>
> 
> https://lwn.net/Articles/717281/ ;)

Nah, just a time to clean-up the keyboard again!

Tony
