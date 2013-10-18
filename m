From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3 0/5] usb: musb_dsps: support for suspend and resume
Date: Fri, 18 Oct 2013 12:05:20 +0200
Message-ID: <526107E0.2070206@linutronix.de>
References: <1382089175-13487-1-git-send-email-zonque@gmail.com> <52610696.7020900@linutronix.de> <52610731.309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39631 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467Ab3JRKFW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 06:05:22 -0400
In-Reply-To: <52610731.309@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

On 10/18/2013 12:02 PM, Daniel Mack wrote:
> As mentioned, that doesn't hit me anymore with the current patch stack.
> 
> That doesn't mean we should ignore that issue, of course, we're still
> sleeping while atomic. But I removed the patch from the series for now,
> so we can address that separately.

Ach okay, I though you found a different solution.

> 
> Thanks,
> Daniel

Sebastian
