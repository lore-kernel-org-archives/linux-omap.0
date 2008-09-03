From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Reset unused clocks during boot causing problem on 5912 OSK
Date: Wed, 3 Sep 2008 20:00:19 +0100
Message-ID: <20080903190019.GB19980@flint.arm.linux.org.uk>
References: <dfeb90390809030702o40710b8cpab328466dac3a4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56996 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbYICTAc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 15:00:32 -0400
Content-Disposition: inline
In-Reply-To: <dfeb90390809030702o40710b8cpab328466dac3a4a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arun KS <getarunks@gmail.com>
Cc: linux-omap@vger.kernel.org

On Wed, Sep 03, 2008 at 07:32:51PM +0530, Arun KS wrote:
> I am trying to write an ASOC driver for tlv320aic23 on 5912osk.

5912osk is OMAP1, yes ?  Uses arch/arm/mach-omap1/mcbsp.c ?

Which is the file I pointed out passing physical addresses for mcbsp1
and mcbsp3 instead of virtual addresses, resulting in code hitting
something else rather than the right registers ?
