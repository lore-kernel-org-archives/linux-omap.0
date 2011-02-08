From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 13:53:20 +0100
Message-ID: <201102081353.20390.arnd@arndb.de>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org> <201102081311.52004.arnd@arndb.de> <20110208121334.GB22877@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64056 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab1BHMxe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 07:53:34 -0500
In-Reply-To: <20110208121334.GB22877@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Dave Martin <dave.martin@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Tuesday 08 February 2011, Russell King - ARM Linux wrote:
> > I don't see any users of the sev/wfe/wfi macros in the current kernel,
> > so removing them seems like a good strategy to avoid people from
> > using them incorrectly.
> 
> That's because they've only just been added.  See the massive 63-patch set
> from Viresh which has been posting to this mailing list.

Ok, I see. At least that version seems ok because the code is cpu
specific already.

The omap do_wfi macro is specifically meant to avoid the multi-cpu
case by using the hexadecimal notation, so it can still be used while
building a kernel for ARMv6 or lower. Dave's version seems to have
the opposite intention here (choosing one version per arch level),
so it wouldn't be a replacement.

	Arnd
