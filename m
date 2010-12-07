From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] Correct definition of register of OMAP4_RM_RSTST and
 OMAP4_RM_RSTTIME
Date: Tue, 7 Dec 2010 09:04:11 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012070902540.13430@utopia.booyaka.com>
References: <AANLkTi=OdG2j2o+uZ+L_EpGKPTE8=fRBN8U60sJkqAhK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36860 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908Ab0LGQEM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 11:04:12 -0500
In-Reply-To: <AANLkTi=OdG2j2o+uZ+L_EpGKPTE8=fRBN8U60sJkqAhK@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: MING ZHOU <a17711@motorola.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hello,

On Tue, 7 Dec 2010, MING ZHOU wrote:

> Since we need to reconfigure Reset time for OMAP4, we found the OMAP4
> register definition for reset time is wrong according to spec of
> OMAP4. And we verified this by reading default value of register. We
> found the offset definition of Reset time and Reset Test register
> should be switched. After correcting this bug, we verified by changing
> the value of reset time register, the pulse generated for reset is
> also changed as expected on scope.

Thanks, will queue this for 2.6.38 since it looks like there are no 
in-tree users in 2.6.37.


- Paul
