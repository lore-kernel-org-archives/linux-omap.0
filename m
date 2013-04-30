From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Latest build results - errors/warnings - lots of them
Date: Tue, 30 Apr 2013 13:54:50 +0200
Message-ID: <201304301354.50210.arnd@arndb.de>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk> <201304301304.20650.arnd@arndb.de> <20130430114229.GA2439@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55927 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760257Ab3D3LzZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Apr 2013 07:55:25 -0400
In-Reply-To: <20130430114229.GA2439@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>

On Tuesday 30 April 2013, Dave Martin wrote:
> From 193f254689beaa1612d29bcc5ba004a933b37d95 Mon Sep 17 00:00:00 2001
> From: Dave Martin <dave.martin@linaro.org>
> Date: Tue, 30 Apr 2013 12:25:04 +0100
> Subject: [PATCH 1/3] ARM: mcpm: Add explicit AFLAGS to support v6/v7
>  multiplatform kernels
> 
> The full mcpm layer is not likely to be relevant to v6 based platforms,
> so a multiplatform kernel won't use that code if booted on v6 hardware.
> 
> This patch modifies the AFLAGS for affected mcpm .S files to specify
> armv7-a explicitly for that code.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
