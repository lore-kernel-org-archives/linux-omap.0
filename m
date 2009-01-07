From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [OMAPZOOM][PATCH 0/2] Some more camera syncup patches
Date: Wed, 7 Jan 2009 15:40:27 -0600
Message-ID: <A24693684029E5489D1D202277BE894416328B10@dlee02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702513F7974@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33500 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573AbZAGVke convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 16:40:34 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n07LeS2g006286
	for <linux-omap@vger.kernel.org>; Wed, 7 Jan 2009 15:40:33 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n07LeSu6028799
	for <linux-omap@vger.kernel.org>; Wed, 7 Jan 2009 15:40:28 -0600 (CST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702513F7974@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Oops, my bad. I'll fix that patch and resend. I'll use the omap_rev() inline for that. (I've just reworked some merge requests from the internal trees)

I'll get back to you in some more minutes.

Thanks,
Sergio

P.S. I'm currently performing some basic sanity tests on my 3430SDP VG5.0.1

> -----Original Message-----
> From: Pandita, Vikram
> Sent: Wednesday, January 07, 2009 3:35 PM
> To: Aguirre Rodriguez, Sergio Alberto; linux-omap@vger.kernel.org
> Subject: RE: [OMAPZOOM][PATCH 0/2] Some more camera syncup patches
> 
> Hi Alberto
>  Do you want to check your code, there is no CONFIG_OMAP3430_ES2 defined
> on zoom git.
> How are you testing your code?
> 
> 
> >-----Original Message-----
> >From: Aguirre Rodriguez, Sergio Alberto
> >Sent: Tuesday, January 06, 2009 7:06 PM
> >To: linux-omap@vger.kernel.org
> >Cc: Pandita, Vikram
> >Subject: [OMAPZOOM][PATCH 0/2] Some more camera syncup patches
> >
> >Hi,
> >
> >This 2 patches also syncs up some other features added previously on TI
> internal tree:
> >
> >- Preview settings fix: this fixes some gains in order to obtain a much
> better image in OV sensor.
> >
> >- Set VPP constraints: This is needes when TI PM is enabled, as this
> ensures
> >Proper operation maintaining voltage frequency levels.
> >
> >Regards,
> >Sergio
