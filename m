From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: RE: [PATCH 1/1] Export notifier register functions for kernel
 module building
Date: Tue, 24 Mar 2009 15:12:37 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A9315C6F@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.0903240326330.8255@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60912 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756549AbZCXJnn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 05:43:43 -0400
In-Reply-To: <alpine.DEB.2.00.0903240326330.8255@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com] 
> Sent: Tuesday, March 24, 2009 2:58 PM
> To: Kevin Hilman
> Cc: Gupta, Ramesh; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/1] Export notifier register functions 
> for kernel module building
> 
> Hello Kevin, Ramesh,
> 
> On Thu, 12 Feb 2009, Kevin Hilman wrote:
> 
> > "Gupta, Ramesh" <grgupta@ti.com> writes:
> > 
> > > This Patch exports symbols 
> clk_notifier_register/unregister function 
> > > for other kernel modules usage.
> > >
> > > Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
> > 
> > Thanks, pushed to PM branch.
> 
> As an aside, this patch should be reverted.  DSPBridge and 
> other drivers needing clock notifiers should pass function pointers to
> clk_notifier_{register,unregister}() in their struct 
> platform_data, rather than exporting those symbols.  This 
> will keep the drivers platform-agnostic, since system-wide 
> clock notifiers are not yet upstream.

I agree on this, I think the latest patch set from Rajendra Naik([1]) removes the EXPORT_SYMBOL for the clk notifier functions.

Ref[1]: http://marc.info/?l=linux-omap&m=123755561914202&w=2
Ref[2]: http://marc.info/?l=linux-omap&m=123755561914205&w=2

We will send a patch to dspbridge sources to adopt these changes.

Please let me know your comments.

Thanks
Ramesh Gupta G