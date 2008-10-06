From: David Brownell <david-b@pacbell.net>
Subject: Re: Compilation broken for 3430SDP defconfig
Date: Mon, 6 Oct 2008 09:41:36 -0700
Message-ID: <200810060941.36725.david-b@pacbell.net>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D6107644@dbde02.ent.ti.com> <20081006154716.GA8273@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:30613 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752953AbYJFQli (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 12:41:38 -0400
In-Reply-To: <20081006154716.GA8273@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Monday 06 October 2008, Felipe Balbi wrote:
> Yes, we need defconfig changes since Kconfig is not asking about the new
> CONFIG_GPIO_TWL4030 symbol added.

I seem to have tested with "make oldconfig" not "make ..._defconfig".

