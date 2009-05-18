From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 08/11] OMAP3: PM: Ensure MUSB block can idle when
	driver not loaded
Date: Mon, 18 May 2009 14:16:11 +0100
Message-ID: <20090518131611.GG3067@n2100.arm.linux.org.uk>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-2-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-3-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-4-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-5-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-6-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-7-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-8-git-send-email-khilman@deeprootsystems.com> <1242412851-16606-9-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42061 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbZERNQT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 09:16:19 -0400
Content-Disposition: inline
In-Reply-To: <1242412851-16606-9-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

On Fri, May 15, 2009 at 11:40:48AM -0700, Kevin Hilman wrote:
> Otherwise, bootloaders may leave MUSB in a state which prevents
> retention.

Hmm, so what happens if a boot loader has touched this MUSB thing, but
the kernel which is being run doesn't have CONFIG_USB_MUSB_SOC enabled?
