From: Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Subject: Re: [PATCH] cbus-retu: Acquire mutex on write operation
Date: Mon, 28 Feb 2011 15:10:02 +0100
Message-ID: <1298902202.26482.3.camel@maggie>
References: <1298763273.21318.5.camel@marge>
	 <20110228083317.GH2459@legolas.emea.dhcp.ti.com>
	 (sfid-20110228_093326_715657_FFFFFFFFA688BA7F)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:46611 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753748Ab1B1OKL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 09:10:11 -0500
In-Reply-To: <20110228083317.GH2459@legolas.emea.dhcp.ti.com> (sfid-20110228_093326_715657_FFFFFFFFA688BA7F)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Mon, 2011-02-28 at 10:33 +0200, Felipe Balbi wrote: 
> On Sun, Feb 27, 2011 at 12:34:33AM +0100, Michael Buesch wrote:
> > The mutex has to be acquired on register write to avoid interference
> > with a simultaneous retu_set_clear_reg_bits operation.
> > 
> > Signed-off-by: Michael Buesch <mb@bu3sch.de>
> 
> good catch, please do the same for retu_read_reg()

I don't think this is necessary, because cbus_read_reg() and
cbus_write_reg() are atomic due to the cbus host->lock.
I think we can depend on this.
We could probably improve the comment on the lock in
cbus_transfer(), though.

-- 
Greetings Michael.

