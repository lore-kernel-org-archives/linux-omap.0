From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: RE: [pacth] I2C bug fixes for L-O and L-Z
Date: Tue, 17 Feb 2009 08:02:40 +0200
Message-ID: <1234850560.13109.9.camel@eenurkka-desktop>
References: <1234767724.16827.7.camel@eenurkka-desktop>
	 <13B9B4C6EF24D648824FF11BE896716203771DC940@dlee02.ent.ti.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40833 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbZBQGFD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2009 01:05:03 -0500
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203771DC940@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2009-02-16 at 15:19 +0100, ext Woodruff, Richard wrote:
> Hi,
> 
> > Could you please also address the question of the load on the SCL line?
> 
> Are you talking about rise/fall time?
> 

Sorry for being unclear;

The I2C standard addresses also rise/fall times, but more interesting,
the tLow and tHigh (and a number of other parameters).

It seems with the open source drivers, that somehow they're after a
"balanced I2C clock" meaning tLow == tHigh, which is very, very
dangerous.

If you look at the I2C standard, you see that actually tLow is
about twice as large as tHigh! (that is closer to truth than
the balanced clock)

So I'm talking about the registers I2C_SCLL and I2C_SCLH. If they
have the TRM or "open source" values, then it's very likely 
the I2C clock is out of standard. The SCLL (tLow) is in danger
for being far too short.

The I2C chip manufacturers consider the I2C standard as basis for
any proper operation. They're not after "balanced" I2C clock.

So I wish I could get some comments on the SCLL and SCLH, TRM,
open source and obeying I2C standard.


