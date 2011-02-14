From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 3/3] OMAP4: clockdomain: Add wkup/sleep dependency
 support
Date: Mon, 14 Feb 2011 09:48:06 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102140946420.21991@utopia.booyaka.com>
References: <1297084631-27474-1-git-send-email-rnayak@ti.com> <1297084631-27474-2-git-send-email-rnayak@ti.com> <1297084631-27474-3-git-send-email-rnayak@ti.com> <1297084631-27474-4-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1102101905160.21991@utopia.booyaka.com>
 <3754d10e94217aa81846aa1d41fe0a9d@mail.gmail.com> <alpine.DEB.2.00.1102102135220.21991@utopia.booyaka.com> <74b7dfbe67e19da4358f7df0bc4dd8f1@mail.gmail.com> <alpine.DEB.2.00.1102102209080.21991@utopia.booyaka.com> <478620b0abf7ff99cb41192dd4ee9e6d@mail.gmail.com>
 <alpine.DEB.2.00.1102121529100.21991@utopia.booyaka.com> <5cabb72b90513c61bc32035e3888577f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42138 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab1BNQsH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 11:48:07 -0500
In-Reply-To: <5cabb72b90513c61bc32035e3888577f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

On Mon, 14 Feb 2011, Rajendra Nayak wrote:

> Thanks for the changes. I used the 'integration-2.6.39-20110212-002'
> tag (with the OMAP4 changes as well) and tested OFF mode in suspend
> on my 3430sdp.
> Also boot tested (making sure all static deps are cleared at boot)
> on my 4430sdp.

Sounds good, thanks for the tests.


- Paul
