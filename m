From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 16:17:58 +0100
Message-ID: <201102081617.59092.arnd@arndb.de>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org> <19a3630aad67b496a4e36354abc63c4a@mail.gmail.com> <AANLkTim90DF1pE0As_vNO-c4dn7S=2jVq+hkRo8CYsx4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:60327 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766Ab1BHPSI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 10:18:08 -0500
In-Reply-To: <AANLkTim90DF1pE0As_vNO-c4dn7S=2jVq+hkRo8CYsx4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

On Tuesday 08 February 2011, Dave Martin wrote:
> CFLAGS_cpu_specific_object.o        += -march=armv7-a
> 
> Whether it's safe to do it depends on whether code from that file
> could ever get run on other processors.  I'm not so sure of the answer
> to that..., but perhaps someone else has a better idea.

We already do this a lot from arch/arm/mm/Makefile, and those
files are typically just one function per file, so they can easily
be proven to be safe that way.

	Arnd
