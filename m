From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OMAP2420-HS flashing question
Date: Mon, 19 Oct 2009 13:32:12 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B318B04@dlee02.ent.ti.com>
References: <4ADCA2BF.3020105@globalautomationsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53212 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755050AbZJSScM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 14:32:12 -0400
In-Reply-To: <4ADCA2BF.3020105@globalautomationsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrejs Cainikovs <andrejsc@globalautomationsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Andrejs Cainikovs
> Sent: Monday, October 19, 2009 12:33 PM

> I've googled that OMAP HS are checking some kind of signature (applications
> should be signed with the special tool (OST Tools)) so the developer must own
> the keys for particular CPU? It is possible to turn off the HS option so I'll
> be able to work with non-signed binaries?
> The problem is that I want to get kernel running on custom OMAP2420-HS board
> but have no keys.

With out keys it's mostly impossible to introduce new boot code into the system.

There isn't a practical way to 'turn off HS' with out destroying the omap chip itself.

The way to add code would be through what ever mechanism the OEM has left to add code into the system (if any).  From there depending on software some kind of KEXEC could be attempted.

Regards,
Richard W.
