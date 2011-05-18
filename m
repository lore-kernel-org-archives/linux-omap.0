From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: context_loss_count error value
Date: Wed, 18 May 2011 17:41:30 +0300
Message-ID: <1305729690.30372.7.camel@deskari>
References: <1305704452.1834.12.camel@deskari> <87k4douvsd.fsf@ti.com>
	 <1305718422.1834.23.camel@deskari>  <877h9ot7c3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:43435 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933029Ab1EROlg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 10:41:36 -0400
Received: by wyf19 with SMTP id 19so1625581wyf.14
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 07:41:34 -0700 (PDT)
In-Reply-To: <877h9ot7c3.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, 2011-05-18 at 16:24 +0200, Kevin Hilman wrote:

> Looking closer at the code, a zero return happens only when
> 
> 1) no hwmod associated to omap_device
> 2) no power domain associated to hwmod
> 3) power domain has not (yet) lost context
> 
> None of these are actually error conditions per-se, and in all cases, it
> indidates that context has not been lost (or we can't tell if context
> has been lost.) 

If the pm code cannot tell whether the context has been lost or not, the
driver must assume it has been lost, do you agree? If so, the driver
must handle zero return value differently, and always restore context.

> So I think the current code is correct.

How is it correct if it returns an error even if no error has happened
=)? Either the code or the documentation is wrong.

How about the wrap-around case? Does the loss count go back to zero?

> Are you finding a case where HW context has actually been lost and the
> powerdomain context loss is still at zero?

No, I haven't been actually testing the PM features at all, I was just
fixing the enablers in DSS and got a bunch of error prints as the DSS
driver was checking for the return value.

 Tomi


