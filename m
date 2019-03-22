From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: Fix broken GPIO ID allocation
Date: Fri, 22 Mar 2019 15:21:34 -0700
Message-ID: <20190322222134.GI19425@atomide.com>
References: <20190319201952.1309-1-jmkrzyszt@gmail.com>
 <20190320010150.GA7872@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190320010150.GA7872@darkstar.musicnaut.iki.fi>
Sender: stable-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [190320 01:02]:
> On Tue, Mar 19, 2019 at 09:19:52PM +0100, Janusz Krzysztofik wrote:
> > In order to request dynamic allocationn of GPIO IDs, a negative number
> > should be passed as a base GPIO ID via platform data.  Unfortuntely,
> > commit 771e53c4d1a1 ("ARM: OMAP1: ams-delta: Drop board specific global
> > GPIO numbers") didn't follow that rule while switching to dynamically
> > allocated GPIO IDs for Amstrad Delta latches, making their IDs
> > overlapping with those already assigned to OMAP GPIO devices.  Fix it.
> > 
> > Fixes: 771e53c4d1a1 ("ARM: OMAP1: ams-delta: Drop board specific global GPIO numbers")
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > Cc: stable@vger.kernel.org
> 
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applying into omap-for-v5.1/fixes thanks.

Tony
