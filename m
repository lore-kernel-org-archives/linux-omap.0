From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH] Add support for hook switch on ams-delta
Date: Mon, 29 Mar 2010 14:46:48 +0100
Message-ID: <20100329134647.GA29369@rakim.wolfsonmicro.main>
References: <200905262057.21890.jkrzyszt@tis.icnet.pl>
 <20090602220433.GD31770@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:60161 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750902Ab0C2Nqu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Mar 2010 09:46:50 -0400
Content-Disposition: inline
In-Reply-To: <20090602220433.GD31770@earth.li>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jonathan McDowell <noodles@earth.li>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, linux-omap@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Jun 02, 2009 at 11:04:33PM +0100, Jonathan McDowell wrote:

> * The commented out code to include the GPIO status in sysfs shouldn't
>   be included. Does the input layer not provide a way to obtain the
>   state of the switch?

It does, but only via an ioctl().
