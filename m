From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: Only write the sysconfig on idle when
 necessary
Date: Wed, 17 Oct 2012 20:25:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210172023130.9767@utopia.booyaka.com>
References: <1350504742-19995-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47217 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047Ab2JQUZU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 16:25:20 -0400
In-Reply-To: <1350504742-19995-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, rnayak@ti.com, linux-arm <linux-arm-kernel@lists.infradead.org>

cc Rajendra

Hi Jon

On Wed, 17 Oct 2012, Jon Hunter wrote:

> Currently, whenever we idle a device _idle_sysc() is called and writes to the
> devices SYSCONFIG register to set the idle mode. A lot devices are using the
> smart-idle mode and so the write to the SYSCONFIG register is programming the
> same value that is already stored in the register.
> 
> Writes to the devices SYSCONFIG register can be slow, for example, writing to
> the DMTIMER SYSCONFIG register takes 3 interface clock cycles and 3 functional
> clock cycles. If the DMTIMER is using the slow 32kHz functional clock this can
> take ~100us.
> 
> Furthermore, during boot on an OMAP4430 panda board, I see that there are 100
> calls to _idle_sysc(), however, only 3 out of the 100 calls actually write
> the SYSCONFIG register with a new value.
> 
> Therefore, to avoid unnecessary writes to device SYSCONFIG registers when
> idling the device, only write the value if the value has changed. It should be
> safe to do this on idle as the context of the register will never be lost while
> the device is active.
> 
> Verified that suspend, CORE off and retention states are working with this
> change on OMAP3430 Beagle board.

The code used to do what you propose in _write_sysconfig(), which applied 
to all sysconfig writes, not just idle.  But it was changed by commit 
233cbe5b94096f95ba7bca2162d63275b0b90b5b ("OMAP2+: hwmod: Update the 
sysc_cache in case module context is lost").  Could you take a look at 
this and maybe discuss it with Rajendra?  It seems to make more sense to 
me to cache it by default, and only invalidate it when we know that 
context is lost.


- Paul
