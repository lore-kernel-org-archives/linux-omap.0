From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: User/kernel memory split
Date: Mon, 6 Jul 2009 11:07:49 +0100
Message-ID: <20090706100749.GA12046@n2100.arm.linux.org.uk>
References: <017301c9fe1f$91b92100$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51330 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070AbZGFKH5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jul 2009 06:07:57 -0400
Content-Disposition: inline
In-Reply-To: <017301c9fe1f$91b92100$LocalHost@wipultra793>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Mon, Jul 06, 2009 at 03:23:07PM +0530, Hemanth V wrote:
> Has anyone tried 3.5G/1.5G user/kernel memory split. 

No such thing is possible.  3.5G/0.5G or 2.5G/1.5G both fit in the
available 4G.

However, what I suggest is looking at highmem rather than changing
the split.
