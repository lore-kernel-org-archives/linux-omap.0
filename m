From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] MUSB: Set INDEX register to 0 before accessing CONFIGDATA
Date: Fri, 12 Sep 2008 10:34:24 -0700
Message-ID: <200809121034.24901.david-b@pacbell.net>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02C418D1B1@dbde02.ent.ti.com> <200809062204.01492.david-b@pacbell.net> <386072610809072012wcf053a6j37c238b82667c23a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:41199 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755075AbYILRjy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Sep 2008 13:39:54 -0400
In-Reply-To: <386072610809072012wcf053a6j37c238b82667c23a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>

On Sunday 07 September 2008, Bryan Wu wrote:
> For Blackfin, the register MUSB_CONFIGDATA is not exported out to software.
> So in the musb driver, Blackfin code can not access the MUSB_CONFIGDATA.
> The configuration is fixed in the software.

So an musb_read_configdata() inline could normally read
that register, but on Blackfin could return the equivalent
constant data ...


