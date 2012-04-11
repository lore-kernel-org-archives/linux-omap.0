From: Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH v4 04/12] ARM: OMAP1: OHCI: use platform_data fn ptr to
 enable OCPI bus
Date: Wed, 11 Apr 2012 09:49:28 +0200
Message-ID: <4F853788.2030007@antcom.de>
References: <20120411003454.27059.37500.stgit@dusk> <20120411003528.27059.8836.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:48963 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748Ab2DKHtb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 03:49:31 -0400
In-Reply-To: <20120411003528.27059.8836.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Anand Gadiyar <gadiyar@ti.com>

On 04/11/2012 02:35 AM, Paul Walmsley wrote:
> Also interesting is that drivers/usb/host/ohci-nxp.c contains a stub
> for ocpi_enable() - perhaps the NXP chips use a similar OCPI IP block?

I'd rather suspect a copy-paste error here since ocpi_enable() is unused
in ohci-nxp.c and the extern declaration looks like an incomplete but
intended removal.

Will probably just remove this reference in my DT patchset.

Roland
