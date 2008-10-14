From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/7] Hook twl4030 power code into twl4030 core.
Date: Tue, 14 Oct 2008 10:42:59 -0700
Message-ID: <200810141042.59823.david-b@pacbell.net>
References: <1223912652-24463-1-git-send-email-peter.de-schrijver@nokia.com> <1223912652-24463-4-git-send-email-peter.de-schrijver@nokia.com> <1223912652-24463-5-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:31915 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750934AbYJNR6z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2008 13:58:55 -0400
In-Reply-To: <1223912652-24463-5-git-send-email-peter.de-schrijver@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Monday 13 October 2008, Peter 'p2' De Schrijver wrote:
> +config TWL4030_POWER
> +=A0=A0=A0=A0=A0=A0=A0bool "Support power sequencing scripts on TWL40=
30/TPS659x0"
> +=A0=A0=A0=A0=A0=A0=A0depends on TWL4030_CORE=3Dy

Don't need "=3Dy" for that, since the CORE is already boolean.


> +=A0=A0=A0=A0=A0=A0=A0help
> +=A0=A0=A0=A0=A0=A0=A0 =A0Say yes here if you want to use the power m=
anagement features of
> +=A0=A0=A0=A0=A0=A0=A0 =A0the TWL4030/TPS659x0.

Saying "power management features" is misleading; there are lots
of PM features this doesn't cover.  Just say "power sequencing
scripts" here too ... and maybe add a sentence saying what such
a script *is* (controlling what type of action on what type of
event).


> +


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
