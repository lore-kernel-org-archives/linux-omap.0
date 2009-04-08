From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC][PATCH] OMAP3: Clock FW: Camera module doesn't have IDLEST
 bit
Date: Wed, 8 Apr 2009 15:37:47 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904081536100.2803@utopia.booyaka.com>
References: <A24693684029E5489D1D202277BE89442EB826F5@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39349 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755393AbZDHVhs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Apr 2009 17:37:48 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89442EB826F5@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


On Mon, 6 Apr 2009, Aguirre Rodriguez, Sergio Alberto wrote:

> >From 8ea977337f4bd6121e9410bfd7f02fbd7f9cb762 Mon Sep 17 00:00:00 2001
> From: Sergio Aguirre <saaguirre@ti.com>
> Date: Mon, 6 Apr 2009 17:44:32 -0500
> Subject: [PATCH] OMAP3: Clock FW: Camera module doesn't have IDLEST bit
> 
> This patch avoids waiting for the camera module to become ready,
> since it doesn't have IDLEST bit.

Thanks Sergio, will queue this for the omap-clock-fixes branch.


- Paul
