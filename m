From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v5 0/7] Add TI EMIF SDRAM controller driver
Date: Thu, 3 May 2012 17:03:12 -0700
Message-ID: <20120504000312.GB32225@kroah.com>
References: <1335529449-28046-1-git-send-email-santosh.shilimkar@ti.com>
 <CAP=VYLrCTOb9Qtz_HU5976cew_FR=qN6=x=_nD48ZprTcCjoUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP=VYLrCTOb9Qtz_HU5976cew_FR=qN6=x=_nD48ZprTcCjoUg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, May 03, 2012 at 06:38:23PM -0400, Paul Gortmaker wrote:
> On Fri, Apr 27, 2012 at 8:24 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> > Add a driver for the EMIF SDRAM controller used in Texas Instrument SoCs
> 
> Hi Santosh,
> 
> Can you send Greg a patch that adds proper dependencies to the Kconfig?
> I was going to simply add an ARM dependency, but perhaps you want to
> restrict it further to a subset of OMAP platforms?
> 
> At the moment it is causing build failures in other architectures.
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/6243036/

I think there's a config option for readl/writel, but yes, ARM would
probably be fine as well.

thanks,

greg k-h
