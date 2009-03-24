From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 1/1] Export notifier register functions for kernel module
 building
Date: Tue, 24 Mar 2009 03:48:36 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903240347180.8255@utopia.booyaka.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A9315C6F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54750 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758840AbZCXJsj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 05:48:39 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A9315C6F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

On Tue, 24 Mar 2009, Gupta, Ramesh wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com] 
> > 
> > DSPBridge and 
> > other drivers needing clock notifiers should pass function pointers to
> > clk_notifier_{register,unregister}() in their struct 
> > platform_data, rather than exporting those symbols.  This 
> > will keep the drivers platform-agnostic, since system-wide 
> > clock notifiers are not yet upstream.
> 
> I agree on this, I think the latest patch set from Rajendra Naik([1]) 
> removes the EXPORT_SYMBOL for the clk notifier functions.
> 
> We will send a patch to dspbridge sources to adopt these changes.
> 
> Please let me know your comments.

Sounds good to me.

regards,

- Paul
