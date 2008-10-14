From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/7] Twl4030 power code updated for new twl4030 core
Date: Tue, 14 Oct 2008 10:38:32 -0700
Message-ID: <200810141038.32966.david-b@pacbell.net>
References: <1223912652-24463-1-git-send-email-peter.de-schrijver@nokia.com> <1223912652-24463-3-git-send-email-peter.de-schrijver@nokia.com> <1223912652-24463-4-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:31623 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751394AbYJNRlu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2008 13:41:50 -0400
In-Reply-To: <1223912652-24463-4-git-send-email-peter.de-schrijver@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Monday 13 October 2008, Peter 'p2' De Schrijver wrote:
> ---
> =A0drivers/mfd/twl4030-power.c | =A0270 +++++++++++++++++++++++++++++=
++++++++++++++
> =A01 files changed, 270 insertions(+), 0 deletions(-)

I tend to agree with the comment from Felipe that moving
this file from i2c/chips to mfd should be one patch.

Again, the general rule about such stuff is that a patch
series should preserve bisectability.  Else it gets hard
to use "git bisect" to track down particularly pernicious
problem patterns, promptly puncturing perplexing puzzles.
:)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
