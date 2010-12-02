From: David Sin <davidsin@ti.com>
Subject: Re: [RFC v2 8/8] TILER-DMM: Linking TILER driver into the Linux
 kernel build
Date: Thu, 2 Dec 2010 07:46:57 -0600
Message-ID: <20101202134656.GC22875@lba0869738>
References: <1291147139-23472-1-git-send-email-davidsin@ti.com>
 <1291147139-23472-9-git-send-email-davidsin@ti.com>
 <20101201005647.GC29171@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101201005647.GC29171@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lajos Molnar <molnar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 30, 2010 at 04:56:47PM -0800, Greg KH wrote:
> On Tue, Nov 30, 2010 at 01:58:59PM -0600, David Sin wrote:
> > From: Lajos Molnar <molnar@ti.com>
> > 
> > This patch links the TILER driver into the Linux kernel build
> > and config system.
> > 
> > Signed-off-by: Lajos Molnar <molnar@ti.com>
> > Signed-off-by: David Sin <davidsin@ti.com>
> > ---
> >  drivers/misc/Kconfig  |    5 +++++
> >  drivers/misc/Makefile |    1 +
> >  2 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index ac6d6ac..fff7927 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -378,4 +378,9 @@ source "drivers/misc/eeprom/Kconfig"
> >  source "drivers/misc/cb710/Kconfig"
> >  source "drivers/misc/iwmc3200top/Kconfig"
> >  
> > +#
> > +# TI TILER driver support
> > +#
> 
> Comments not needed.
> 
> thanks,
> 
> greg k-h
thanks, Greg, for the comments.  I will make all of these changes 
in the next revision.
-- 
David Sin
