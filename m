From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [OMAPZOOM][PATCH 0/2] Some more camera syncup patches
Date: Thu, 8 Jan 2009 03:05:18 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702513F7974@dbde02.ent.ti.com>
References: <A24693684029E5489D1D202277BE8944163282D6@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37148 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755034AbZAGVf1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 16:35:27 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n07LZIlK002076
	for <linux-omap@vger.kernel.org>; Wed, 7 Jan 2009 15:35:25 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n07LZHn3000989
	for <linux-omap@vger.kernel.org>; Thu, 8 Jan 2009 03:05:17 +0530 (IST)
In-Reply-To: <A24693684029E5489D1D202277BE8944163282D6@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Alberto
 Do you want to check your code, there is no CONFIG_OMAP3430_ES2 defined on zoom git.
How are you testing your code? 


>-----Original Message-----
>From: Aguirre Rodriguez, Sergio Alberto
>Sent: Tuesday, January 06, 2009 7:06 PM
>To: linux-omap@vger.kernel.org
>Cc: Pandita, Vikram
>Subject: [OMAPZOOM][PATCH 0/2] Some more camera syncup patches
>
>Hi,
>
>This 2 patches also syncs up some other features added previously on TI internal tree:
>
>- Preview settings fix: this fixes some gains in order to obtain a much better image in OV sensor.
>
>- Set VPP constraints: This is needes when TI PM is enabled, as this ensures
>Proper operation maintaining voltage frequency levels.
>
>Regards,
>Sergio
