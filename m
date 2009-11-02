From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: Do defconfigs work for 2.6.32-rc5 mainline kernels?
Date: Mon, 2 Nov 2009 14:33:21 -0600
Message-ID: <A24693684029E5489D1D202277BE89444D4B44A7@dlee02.ent.ti.com>
References: <4AEB5CD8.8060603@billgatliff.com> <4AEF2320.8040100@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38946 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754799AbZKBUbd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 15:31:33 -0500
In-Reply-To: <4AEF2320.8040100@am.sony.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tim Bird <tim.bird@am.sony.com>, Bill Gatliff <bgat@billgatliff.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tim Bird
> Sent: Monday, November 02, 2009 12:21 PM
> To: Bill Gatliff
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Do defconfigs work for 2.6.32-rc5 mainline kernels?
> 
> Bill Gatliff wrote:
> > I'm trying to build a kernel for beagleboard, using the 
> defconfig found
> > in 2.6.32-rc5 and the 2.6.32-rc5 source code.
> > 
> > Said kernel hangs after the uncompressor, I'm just trying 
> to figure out
> > if this is a known issue or not.  The defconfig in the 
> linux-omap tree
> > does seem to work with the linux-omap source code, FWIW...
> 
> Short story:
> I found that the omap OSK defconfig is broken in mainline also.
> 
> Long story:
> I found that the defconfig in the mainline 2.6.32-rc1 kernel
> didn't work on an OMAP OSK board.  Thinking there was some
> problem in the code itself, I bisected from a known working
> config on 2.6.29 all the way back up to 2.6.32-rc1.  When
> I was done I was at the current code base, but with a .config
> that had about 650 differences.
> 
> I haven't had time to go back and find the individual config
> option that changed to break things.  I would need some kind
> of "config bisect" to find this efficiently.
> 
> I didn't think to try the OSK defconfig in the omap tree.
> (Silly me, might have saved me some grief. :-)
> 
> Is there a maintainer for individual defconfig files?
> In other words, if I repair the OSK defconfig, who do
> I send it to?

Why don't you guys enable Kernel Low level prints and send the logs?

Otherwise its pretty hard to see what's wrong.

Regards,
Sergio
> 
>  -- Tim
> 
> =============================
> Tim Bird
> Architecture Group Chair, CE Linux Forum
> Senior Staff Engineer, Sony Corporation of America
> =============================
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 