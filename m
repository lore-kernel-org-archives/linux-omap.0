From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/2] MUSB: 2 patches to fix some bug found on Blackfin
Date: Sat, 17 May 2008 07:37:37 -0700
Message-ID: <200805170737.37806.david-b@pacbell.net>
References: <1211022081-27298-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:22575 "HELO
	smtp107.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755077AbYEQOhn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 17 May 2008 10:37:43 -0400
In-Reply-To: <1211022081-27298-1-git-send-email-cooloney@kernel.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: me@felipebalbi.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 17 May 2008, Bryan Wu wrote:
> 
> We discussed these 4 bugs before. Now we fixed them.
> Please review following 2 patches.

They looked plausible to me ... though the urb->status
one is a bit of a band-aid, and when that field finally
vanishes a better fix will be needed.

- Dave
