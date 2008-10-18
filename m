From: notaz <notasas@gmail.com>
Subject: Re: [PATCH] omap: Add basic support for Pandora handheld console
Date: Sat, 18 Oct 2008 19:05:50 +0300
Message-ID: <6ed0b2680810180905nc68bb9dif056d25a61b5118b@mail.gmail.com>
References: <1224341130-2666-1-git-send-email-notasas@gmail.com>
	 <20081018152914.GR18573@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:44597 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbYJRQFw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Oct 2008 12:05:52 -0400
Received: by ug-out-1314.google.com with SMTP id k3so325623ugf.37
        for <linux-omap@vger.kernel.org>; Sat, 18 Oct 2008 09:05:50 -0700 (PDT)
In-Reply-To: <20081018152914.GR18573@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Thanks for the review.

> Are all the uarts really in use?
>
> Does pandora have a real serial port for debugging?
Yes, early devboards have serial connector on the board itself, and
production boards will have serial exposed over ext connector. But
true, we only use UART3, will ask our hardware guy if UART3 is the one
to be used in final boards too and resubmit.
