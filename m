From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 0/2] thermal: omap: dra752: Remove TSHUT configuration
Date: Tue, 24 Jan 2017 02:13:02 -0800
Message-ID: <20170124101300.GA21523@localhost.localdomain>
References: <1483682503-27803-1-git-send-email-j-keerthy@ti.com>
 <560cf909-0303-1827-1f58-c700d785a2b9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <560cf909-0303-1827-1f58-c700d785a2b9@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, rk@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 23, 2017 at 08:49:29PM +0530, Keerthy wrote:
> Eduardo,
> 
> On Friday 06 January 2017 11:31 AM, Keerthy wrote:
> >Technical Reference Manual [1] mandates that software should
> >not be configuring the thermal shutdown thresholds. Hence
> >removing TSHUT_CONFIG.
> 
> Any comments on this?

I do not see issues on these patches. Queueing for next rc.

> 
> - Keerthy
> >
> >[1] http://www.ti.com/lit/ug/sprui30b/sprui30b.pdf
> >
> >Keerthy (2):
> >  thermal: omap: dra752: Remove TSHUT configuration
> >  thermal: omap: dra752: Remove all TSHUT related definitions
> >
> > drivers/thermal/ti-soc-thermal/dra752-bandgap.h    | 19 ---------------
> > .../thermal/ti-soc-thermal/dra752-thermal-data.c   | 28 +---------------------
> > 2 files changed, 1 insertion(+), 46 deletions(-)
> >
