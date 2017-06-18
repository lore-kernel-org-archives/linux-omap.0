From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
Date: Mon, 19 Jun 2017 00:44:10 +0300
Message-ID: <20170618214410.evopfpw7no7odhst@darkstar.musicnaut.iki.fi>
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <faadb535-666e-1ac9-35c5-58916d3c92aa@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <faadb535-666e-1ac9-35c5-58916d3c92aa@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Jun 15, 2017 at 10:28:31AM +0300, Peter Ujfalusi wrote:
> On 2017-06-15 01:11, Aaro Koskinen wrote:
> > When booting v4.12-rc5 on Nokia N900, omapdrm fails to probe and there
> > is no display.
> > 
> > Bisected to:
> > 
> > a09d2bc1503508c17ef3a71c6b1905e3660f3029 is the first bad commit
> > commit a09d2bc1503508c17ef3a71c6b1905e3660f3029
> > Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Date:   Tue May 3 22:08:01 2016 +0300
> > 
> >     drm/omap: Use omapdss_stack_is_ready() to check that the display stack is up
> >     
> >     Instead of 'guessing' based on aliases of the status of the DSS drivers,
> >     use the new interface to check that all needed drivers are loaded.
> >     In this way we can be sure that all needed drivers are loaded so it is
> >     safe to continue the probing of omapdrm.
> >     This method will allow the omapdrm to be probed 'headless', without
> >     outputs.
> >     
> >     Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > 
> > Reverting the commit seems to fix the issue.
> 
> When you revert this patch do you see a warning saying:
> "could not connect display: blah" ? if so what is 'blah'?

No.

A.
