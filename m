From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: omap_3430sdp_defconfig for multiple boards?
Date: Fri, 19 Jun 2009 22:11:40 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F53D2097@dbde02.ent.ti.com>
References: <A24693684029E5489D1D202277BE8944411FC47D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49561 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978AbZFSQlt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jun 2009 12:41:49 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5JGfjES018888
	for <linux-omap@vger.kernel.org>; Fri, 19 Jun 2009 11:41:51 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n5JGfjmU005532
	for <linux-omap@vger.kernel.org>; Fri, 19 Jun 2009 22:11:45 +0530 (IST)
In-Reply-To: <A24693684029E5489D1D202277BE8944411FC47D@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Aguirre
>Rodriguez, Sergio Alberto
>Sent: Friday, June 19, 2009 11:10 AM
>To: linux-omap@vger.kernel.org
>Subject: omap_3430sdp_defconfig for multiple boards?
>
>Hi,
>
>Is it intentional that the current omap_3430sdp_defconfig builds an image compatible with all this
>boards?

This is wrong. Should have only MACH SDP defined.

>
>> #
>> # OMAP Board Type
>> #
>> CONFIG_MACH_OMAP3_BEAGLE=y
>> CONFIG_MACH_OMAP_LDP=y
>> CONFIG_MACH_OVERO=y
>> CONFIG_MACH_OMAP3_PANDORA=y
>> CONFIG_MACH_OMAP_3430SDP=y
>
>Regards,
>Sergio
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

