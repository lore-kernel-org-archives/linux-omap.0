From: "Jason Marini" <jason.marini@gmail.com>
Subject: Re: [PATCH 1/1] Patch for I2C transmit overflow error
Date: Tue, 6 Jan 2009 15:12:46 -0500
Message-ID: <423644ca0901061212i280eff36o61def6fb812b6bd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.155]:49064 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbZAFUMr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 15:12:47 -0500
Received: by po-out-1718.google.com with SMTP id b23so5623341poe.4
        for <linux-omap@vger.kernel.org>; Tue, 06 Jan 2009 12:12:46 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>>This patch is to fix I2C transmit overflow error.
>>I guess it should fix the OSK5912 error. I dont have the board to test it.
>
>Yes, it makes those error reports go away. I'd say to merge this patch.

Chandra, why would the transmit underflow (XDR) status sometimes be
set at the same time as the XRDY status?  Why would you want to ignore
XDR (using 'continue') if XRDY is set?

Thank you in advance for clearing this up for me.

-Jason Marini
