From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 06/10] ARM: OMAP: Fix DMA CCR programming for request line > 63, v2
Date: Mon, 12 Jan 2009 16:42:37 +0000
Message-ID: <20090112164237.GD6152@n2100.arm.linux.org.uk>
References: <20090112144453.24205.18451.stgit@localhost> <5A47E75E594F054BAF48C5E4FC4B92AB02E678260F@dbde02.ent.ti.com> <20090112153526.GN9373@atomide.com> <20090112160114.GB6152@n2100.arm.linux.org.uk> <20090112161052.GO9373@atomide.com> <20090112161629.GC6152@n2100.arm.linux.org.uk> <20090112164044.GQ9373@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60877 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbZALQm7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 11:42:59 -0500
Content-Disposition: inline
In-Reply-To: <20090112164044.GQ9373@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Jan 12, 2009 at 06:40:45PM +0200, Tony Lindgren wrote:
> How about this? Of course the bits should be defined for
> DMA_SYNCHRO_CONTROL_UPPER and DMA_SYNCHRO_CONTROL, but that may not
> count as a fix..

Ok.

