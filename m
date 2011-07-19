From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 2/6] omap: voltage: change code to use new location of voltage.h and vp.h
Date: Tue, 19 Jul 2011 10:47:16 +0300
Message-ID: <1311061636.10230.15.camel@sokoban>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com> <1311010522-5868-3-git-send-email-t-kristo@ti.com> <20110718181645.GI25081@legolas.emea.dhcp.ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44538 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339Ab1GSHrX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jul 2011 03:47:23 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20110718181645.GI25081@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, "Hilman, Kevin" <khilman@ti.com>, tony@atomide.com, toddpoynor@google.com, broonie@opensource.wolfsonmicro.com, "Girdwood, Liam" <lrg@ti.com>

On Mon, 2011-07-18 at 20:16 +0200, Balbi, Felipe wrote:
> Hi,
> 
> On Mon, Jul 18, 2011 at 08:35:18PM +0300, Tero Kristo wrote:
> > These are now under plat-omap/include/plat.
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> this has to be folded into previous patch, otherwise we will have a
> broken bisection point.
> 

Good to know for future, I will just drop this patch (and patch 1 also)
though as Kevin suggested and create a simple stub that provides only
the API needed.

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

