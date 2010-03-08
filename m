From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [RFC part1/2 merge v2][PATCH 00/11] omap2/3/4: uart4 fixes +
 zoom2/3 changes
Date: Mon, 8 Mar 2010 11:22:29 -0600
Message-ID: <A24693684029E5489D1D202277BE894453D68E93@dlee02.ent.ti.com>
References: <1268068854-13429-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51885 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985Ab0CHRWe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 12:22:34 -0500
In-Reply-To: <1268068854-13429-1-git-send-email-saaguirre@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

> -----Original Message-----
> From: Aguirre, Sergio
> Sent: Monday, March 08, 2010 11:21 AM
> To: linux-omap@vger.kernel.org
> Cc: Kevin Hilman; Pandita, Vikram; Paul Walmsley; Tony Lindgren; Aguirre,
> Sergio
> Subject: [RFC part1/2 merge v2][PATCH 00/11] omap2/3/4: uart4 fixes +
> zoom2/3 changes
> 
> Hi,
> 
> This is v2 of my serial work series merge found here: [1]
> 
> And it's meant to be applied on top of Thomas's patch: [2]
> 
> Changelog compared to previous version:
>  - Replaced hardcoded IRQ for UART4 in 3630 by newly created
>    INT_36XX_UART4_IRQ define. (Thanks Kevin)

Oops, sent a wrong past internal revision... sorry for the spam, but I'll resend with the correction.

Regards,
Sergio
