From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCHv4] OMAP: Fix McBSP spin_lock deadlock
Date: Thu, 15 Jan 2009 01:35:27 -0800
Message-ID: <200901150135.27298.david-b@pacbell.net>
References: <1232010712-25142-1-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:41592 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753045AbZAOJf3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jan 2009 04:35:29 -0500
In-Reply-To: <1232010712-25142-1-git-send-email-stanley.miao@windriver.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org

On Thursday 15 January 2009, Stanley.Miao wrote:
> =A04 files changed, 78 insertions(+), 228 deletions(-)

You know, I'm always predisposed to like bugfixes that delete
more code than they add.  ;)


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
