From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 09/11] DT: regulator: Helper to extract regulator
 node based on supply name
Date: Thu, 15 Sep 2011 14:54:16 +0100
Message-ID: <20110915135416.GN7988@opensource.wolfsonmicro.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
 <1316085727-15023-5-git-send-email-rnayak@ti.com>
 <1316085727-15023-6-git-send-email-rnayak@ti.com>
 <1316085727-15023-7-git-send-email-rnayak@ti.com>
 <1316085727-15023-8-git-send-email-rnayak@ti.com>
 <1316085727-15023-9-git-send-email-rnayak@ti.com>
 <1316085727-15023-10-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39782 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751972Ab1IONyT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 09:54:19 -0400
Content-Disposition: inline
In-Reply-To: <1316085727-15023-10-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Thu, Sep 15, 2011 at 04:52:05PM +0530, Rajendra Nayak wrote:

> 		regulator = <&regulator1>,<&regulator2>;
> 		regulator-names = "supply1","supply2";
> 	};

This syntax is really painful - we're relying on keeping two arrays in
sync which isn't good for legibility or robustness.  I'd expect
something like having a property with the supply name referencing the
regulator node concerned like:

	dbvdd = <&regulator1>;
	dcvdd = <&regulator2>;

or something.  Keeping the two arrays separate doesn't seem great.
