From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] ARM: Parse ATAG_VIDEOLFB to screen_info
Date: Tue, 25 Nov 2008 10:17:43 +0200
Message-ID: <1227601063.7197.18.camel@tubuntu>
References: <1227263136-14862-1-git-send-email-tomi.valkeinen@nokia.com>
	 <20081124121217.GB5330@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20242 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbYKYISZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 03:18:25 -0500
In-Reply-To: <20081124121217.GB5330@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Hi,

On Mon, 2008-11-24 at 12:12 +0000, ext Russell King - ARM Linux wrote:
> On Fri, Nov 21, 2008 at 12:25:36PM +0200, Tomi Valkeinen wrote:
> > Parse ATAG_VIDEOLFB received from bootloader to screen_info struct,
> > so that video drivers can use the information.
> 
> Boot loaders tend to be absolutely diabolical about passing correct
> information to the kernel, so I really don't want to see such platform
> specific stuff being passed.  Please put it in the board specific file
> instead, just like everyone else does.

I though a general file would be better, because:

a) the tag contains only generic stuff and it is parsed directly to
screen_info, which is also generic

b) ATAG_VIDEOTEXT, which is very similar to ATAG_VIDEOLFB, is parsed in
setup.c also.

c) it is not used anywhere currently

So I don't see anything platform or board specific there. Or do you mean
that there are broken bootloaders out there and this would mess up
screen_info?

 Tomi


