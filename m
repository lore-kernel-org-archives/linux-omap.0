From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] Correct definition of register of OMAP4_RM_RSTST and
 OMAP4_RM_RSTTIME
Date: Tue, 7 Dec 2010 17:16:15 +0100
Message-ID: <4CFE5DCF.1090903@ti.com>
References: <AANLkTi=OdG2j2o+uZ+L_EpGKPTE8=fRBN8U60sJkqAhK@mail.gmail.com> <alpine.DEB.2.00.1012070902540.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59076 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982Ab0LGQQU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Dec 2010 11:16:20 -0500
In-Reply-To: <alpine.DEB.2.00.1012070902540.13430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: MING ZHOU <a17711@motorola.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi Paul,

On 12/7/2010 5:04 PM, Paul Walmsley wrote:
> Hello,
>
> On Tue, 7 Dec 2010, MING ZHOU wrote:
>
>> Since we need to reconfigure Reset time for OMAP4, we found the OMAP4
>> register definition for reset time is wrong according to spec of
>> OMAP4. And we verified this by reading default value of register. We
>> found the offset definition of Reset time and Reset Test register
>> should be switched. After correcting this bug, we verified by changing
>> the value of reset time register, the pulse generated for reset is
>> also changed as expected on scope.
>
> Thanks, will queue this for 2.6.38 since it looks like there are no
> in-tree users in 2.6.37.

These defines are not needed anymore, it is legacy stuff done before we 
generated the whole prm44xx.h.

Here are the entries in the prm44xx.h, line 574.

/* PRM.DEVICE_PRM register offsets */
#define OMAP4_PRM_RSTCTRL_OFFSET			0x0000
#define OMAP4_PRM_RSTST_OFFSET				0x0004
#define OMAP4_PRM_RSTTIME_OFFSET			0x0008


We'd better get rid of these old entries in prm.h

Regards,
Benoit
