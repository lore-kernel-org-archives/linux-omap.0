From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH v2] mtd: omap: fix mtd devices not showing up
Date: Wed, 29 Oct 2014 12:36:12 +0100
Message-ID: <20141029113612.GA2499@ci00147.xsens-tech.local>
References: <1414416749-19598-1-git-send-email-frans.klaver@xsens.com>
 <1414420445-9020-1-git-send-email-frans.klaver@xsens.com>
 <544F6611.1000801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:45324 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105AbaJ2Lgh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2014 07:36:37 -0400
Content-Disposition: inline
In-Reply-To: <544F6611.1000801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Ezequiel =?utf-8?Q?Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Oct 28, 2014 at 11:46:57AM +0200, Roger Quadros wrote:
> On 10/27/2014 04:34 PM, Frans Klaver wrote:
> > Since commit 6d178ef2fd5e ("mtd: nand: Move ELM driver and rename as
> > omap_elm"), I don't have any mtd devices present on my am335x. This
> > changes the link order of the omap_elm and omap2 objects, causing them
> > to probe in the wrong order.
> > 
> > To fix this, make elm_config defer probing until the omap_elm driver is
> > actually loaded.
> > 
> > Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
> 
> Acked-by: Roger Quadros <rogerq@ti.com>

Thanks. How about Ezequiel's remark about doing both changes?

Thanks,
Frans
