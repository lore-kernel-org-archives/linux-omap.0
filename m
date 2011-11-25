From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv6 1/6] regulator: core: add support for external
 get/set_voltage
Date: Fri, 25 Nov 2011 16:52:14 +0000
Message-ID: <20111125165214.GG5315@opensource.wolfsonmicro.com>
References: <1322238562-19943-1-git-send-email-t-kristo@ti.com>
 <1322238562-19943-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51190 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751029Ab1KYQwR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 11:52:17 -0500
Content-Disposition: inline
In-Reply-To: <1322238562-19943-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, lrg@ti.com, gg@slimlogic.co.uk, rnayak@ti.com, b-cousson@ti.com

On Fri, Nov 25, 2011 at 06:29:17PM +0200, Tero Kristo wrote:

Why is this only on the OMAP list?  Always CC the relevant discussion
list for the subsystem, especially when proposing changes to the
subsystem!

> Regulator users can now set override functions for get_voltage and
> set_voltage. This is required by some regulators, which have two
> alternate control paths. E.g., OMAP SMPS regulators can be controlled
> either through the I2C interface or voltage processor control path,
> which uses specialized hardware.

My basic reaction to this is "eew, ick".  Doing this with a runtime call
just feels badly joined up, and there's nothing here which hands off the
configuration between the various drivers involved in the transitions.
We need to make sure that the voltage doesn't suddenly lurch around when
doing transitions.

There's also a lack of locking in the code which would seem to be
required and I'd expect regulator_set_external_ctl() to return an error
if it fails.
