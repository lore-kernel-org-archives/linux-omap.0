From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: READ THIS: the next mach-types update
Date: Sat, 17 Sep 2011 15:34:27 +0100
Message-ID: <20110917143427.GA16591@n2100.arm.linux.org.uk>
References: <20110915102528.GI6267@n2100.arm.linux.org.uk> <2A3DCF3DA181AD40BDE86A3150B27B6B03B4C80171@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59463 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab1IQOen (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Sep 2011 10:34:43 -0400
Content-Disposition: inline
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4C80171@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Sep 17, 2011 at 07:58:20PM +0530, Pedanekar, Hemant wrote:
> But since I had submitted v1 (see [1]) and am working on v2 post review, can you
> please suggest how to go about it as I will need the above for adding support
> for TI8148 EVM?

The answer you require is in this statement:

# This is a cut-down version of the file; it contains only machines that
# are merged into mainline or have been edited in the machine database
# within the last 12 months.  References to machine_is_NAME() do not count!

which highlights the policy.  The key thing there is "edited".
