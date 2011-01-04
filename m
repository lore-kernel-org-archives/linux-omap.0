From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] arm: omap: select HAVE_SPARSE_IRQ
Date: Tue, 4 Jan 2011 11:42:07 +0000
Message-ID: <20110104114207.GA19293@n2100.arm.linux.org.uk>
References: <1294133966-20279-1-git-send-email-balbi@ti.com> <1294133966-20279-3-git-send-email-balbi@ti.com> <20110104095410.GA17298@n2100.arm.linux.org.uk> <20110104103432.GM2656@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39997 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab1ADLmT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 06:42:19 -0500
Content-Disposition: inline
In-Reply-To: <20110104103432.GM2656@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 04, 2011 at 12:34:32PM +0200, Felipe Balbi wrote:
> do you mean:

Yes, but without the breakage caused by your mailer - posting patches
with flowed formatting is a recipe for this kind of disaster:

Content-Type: text/plain; charset=us-ascii; format=flowed

You appear to be using mutt, so set:

set text_flowed=no

in your .muttrc to avoid this corruption.
