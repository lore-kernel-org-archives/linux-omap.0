From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: omap_3430sdp_defconfig for multiple boards?
Date: Fri, 19 Jun 2009 11:45:53 -0500
Message-ID: <A24693684029E5489D1D202277BE8944411FC4FC@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE8944411FC47D@dlee02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F53D2097@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38555 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799AbZFSQo0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jun 2009 12:44:26 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5JGiNGg032610
	for <linux-omap@vger.kernel.org>; Fri, 19 Jun 2009 11:44:28 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n5JGiNU4029474
	for <linux-omap@vger.kernel.org>; Fri, 19 Jun 2009 11:44:23 -0500 (CDT)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n5JGiNEj028211
	for <linux-omap@vger.kernel.org>; Fri, 19 Jun 2009 11:44:23 -0500 (CDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F53D2097@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>

From: Pandita, Vikram
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Aguirre
> >Rodriguez, Sergio Alberto
> >Sent: Friday, June 19, 2009 11:10 AM
> >To: linux-omap@vger.kernel.org
> >Subject: omap_3430sdp_defconfig for multiple boards?
> >
> >Hi,
> >
> >Is it intentional that the current omap_3430sdp_defconfig builds an image
> compatible with all this
> >boards?
> 
> This is wrong. Should have only MACH SDP defined.

(Looping Khasim)

OK.

I saw that the commit for including support for the 3430SDP has the defconfig with this options already enabled.

Regards,
Sergio
> 
> >
> >> #
> >> # OMAP Board Type
> >> #
> >> CONFIG_MACH_OMAP3_BEAGLE=y
> >> CONFIG_MACH_OMAP_LDP=y
> >> CONFIG_MACH_OVERO=y
> >> CONFIG_MACH_OMAP3_PANDORA=y
> >> CONFIG_MACH_OMAP_3430SDP=y
> >
> >Regards,
> >Sergio
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html

