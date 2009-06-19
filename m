From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: omap_3430sdp_defconfig for multiple boards?
Date: Fri, 19 Jun 2009 11:10:29 -0500
Message-ID: <A24693684029E5489D1D202277BE8944411FC47D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47984 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610AbZFSQIu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jun 2009 12:08:50 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5JG8mqJ032133
	for <linux-omap@vger.kernel.org>; Fri, 19 Jun 2009 11:08:53 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n5JG8m6u027359
	for <linux-omap@vger.kernel.org>; Fri, 19 Jun 2009 11:08:48 -0500 (CDT)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n5JG8med010994
	for <linux-omap@vger.kernel.org>; Fri, 19 Jun 2009 11:08:48 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Is it intentional that the current omap_3430sdp_defconfig builds an image compatible with all this boards?

> #
> # OMAP Board Type
> #
> CONFIG_MACH_OMAP3_BEAGLE=y
> CONFIG_MACH_OMAP_LDP=y
> CONFIG_MACH_OVERO=y
> CONFIG_MACH_OMAP3_PANDORA=y
> CONFIG_MACH_OMAP_3430SDP=y

Regards,
Sergio
