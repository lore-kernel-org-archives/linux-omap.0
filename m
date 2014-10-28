From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2] mtd: omap: fix mtd devices not showing up
Date: Tue, 28 Oct 2014 11:46:57 +0200
Message-ID: <544F6611.1000801@ti.com>
References: <1414416749-19598-1-git-send-email-frans.klaver@xsens.com> <1414420445-9020-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45075 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbaJ1JrY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Oct 2014 05:47:24 -0400
In-Reply-To: <1414420445-9020-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Frans Klaver <frans.klaver@xsens.com>, Brian Norris <computersforpeace@gmail.com>
Cc: =?ISO-8859-1?Q?Ezequiel_Garc=EDa?= <ezequiel@vanguardiasur.com.ar>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

On 10/27/2014 04:34 PM, Frans Klaver wrote:
> Since commit 6d178ef2fd5e ("mtd: nand: Move ELM driver and rename as
> omap_elm"), I don't have any mtd devices present on my am335x. This
> changes the link order of the omap_elm and omap2 objects, causing them
> to probe in the wrong order.
> 
> To fix this, make elm_config defer probing until the omap_elm driver is
> actually loaded.
> 
> Signed-off-by: Frans Klaver <frans.klaver@xsens.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger
