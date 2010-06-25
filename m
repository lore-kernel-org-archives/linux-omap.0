From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
Date: Fri, 25 Jun 2010 21:06:59 +0100
Message-ID: <20100625200659.GB22090@n2100.arm.linux.org.uk>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com> <1277422991-25350-2-git-send-email-khilman@deeprootsystems.com> <AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55811 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab0FYUHO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 16:07:14 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Eric Miao <eric.miao@canonical.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>

On Fri, Jun 25, 2010 at 09:26:43AM -0600, Grant Likely wrote:
> This approach is also not multiplatform friendly (cc'ing Eric and
> Nicolas who are working on ARM multiplatform).  It won't work for
> building a kernel that supports, say, both versatile and OMAP.

And I should also point out that multiplatform is not the answer to
Linus' concerns.  There's no way such work is going to be anywhere
near complete come the next merge window.

Note that the loss of the defconfigs will make the integration of
multiplatform patches extremely time consuming and slow.
