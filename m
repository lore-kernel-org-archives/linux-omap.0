From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/2] I2C: i2c-omap: Change device name: i2c_omap ->
 omap_i2c
Date: Thu, 9 Dec 2010 10:04:47 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012091003400.11479@utopia.booyaka.com>
References: <1291904657-32729-1-git-send-email-b-cousson@ti.com> <1291904657-32729-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45531 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985Ab0LIREs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 12:04:48 -0500
In-Reply-To: <1291904657-32729-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Ben Dooks <ben-i2c@fluff.org>

On Thu, 9 Dec 2010, Benoit Cousson wrote:

> The convention for omap device naming is omap_XXX.
> 
> Rename the device and driver name in order to stick
> to this naming convention.
> 
> Change device name in clock nodes as well.

Acked-by: Paul Walmsley <paul@pwsan.com>

- Paul

