From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
	presence of 32k timer
Date: Tue, 10 Apr 2012 09:44:13 +0100
Message-ID: <20120410084413.GD25053@n2100.arm.linux.org.uk>
References: <79CD15C6BA57404B839C016229A409A8318461E8@DBDE01.ent.ti.com> <CAMQu2gxuFsovKTPK8wFOO8vMeiyMFnTqNDRZYgAcCsVWytpOTA@mail.gmail.com> <79CD15C6BA57404B839C016229A409A83184846A@DBDE01.ent.ti.com> <20120405095221.GC25053@n2100.arm.linux.org.uk> <79CD15C6BA57404B839C016229A409A831848621@DBDE01.ent.ti.com> <87hawxkgoi.fsf@ti.com> <79CD15C6BA57404B839C016229A409A831849432@DBDE01.ent.ti.com> <20120406180452.GB15734@atomide.com> <79CD15C6BA57404B839C016229A409A83184ABEF@DBDE01.ent.ti.com> <4F83440E.70502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37194 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab2DJIou (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 04:44:50 -0400
Content-Disposition: inline
In-Reply-To: <4F83440E.70502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, Ming Lei <tom.leiming@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Apr 09, 2012 at 03:18:22PM -0500, Jon Hunter wrote:
> True, but we would always want to use the 32k timer if CONFIG_PM is  
> specified. So what I am saying is that if a device has a 32ksync timer  
> and CONFIG_PM is defined, we always want to use the 32ksync timer and a  
> gptimer should never be used.

Why?  What if you want to have PM enabled, and you also want to use the
kernels high resolution timers, or you want more accurate timing than
the 30.5us tick interval of the 32k timer?
