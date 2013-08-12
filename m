From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv3 1/9] memory: emif: Move EMIF register defines to
 include/linux/
Date: Mon, 12 Aug 2013 12:32:41 -0700
Message-ID: <20130812193241.GA18547@kroah.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-2-git-send-email-d-gerlach@ti.com>
 <52039EB2.5070508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55996 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab3HLTcm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Aug 2013 15:32:42 -0400
Content-Disposition: inline
In-Reply-To: <52039EB2.5070508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Benoit Cousson <benoit.cousson@linaro.org>, Aneesh V <aneesh@ti.com>

On Thu, Aug 08, 2013 at 09:35:46AM -0400, Santosh Shilimkar wrote:
> (You have not CC'ed Greg, Looping him)
> 
> On Tuesday 06 August 2013 01:49 PM, Dave Gerlach wrote:
> > OMAP4 and AM33XX share the same EMIF controller IP. Although there
> > are significant differences in the IP integration due to which
> > AM33XX can't reuse the EMIF driver DVFS similar to OMAP4,
> > it can definitely benefit by reusing the EMIF related macros
> > defined in drivers/memory/emif.h.
> > 
> > In the current OMAP PM framework the PM code resides under
> > arch/arm/mach-omap2/. To enable reuse of the register defines move
> > the register defines in the emif header file to include/linux so that
> > both the EMIF driver and the AM33XX PM code can benefit.
> > 
> > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Benoit Cousson <benoit.cousson@linaro.org>
> > Cc: Aneesh V <aneesh@ti.com>
> > ---
> >  drivers/memory/emif.h   |  543 +--------------------------------------------
> >  include/linux/ti_emif.h |  558 +++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 559 insertions(+), 542 deletions(-)
> >  create mode 100644 include/linux/ti_emif.h
> > 
> For file movement or some part of file movement, while formating
> patch, use "git format-patch -C" so that only delta change will
> appear in the patch.
> 
> The patch as such is fine by me.
> Acked-by: Santosh Shililmar <santosh.shilimkar@ti.com>
> 
> Greg,
> Your ack is needed on this patch so that it can go
> along with the series. Subsequent patch from this series
> use the register defines from this patch.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
