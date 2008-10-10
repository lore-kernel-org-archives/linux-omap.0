From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 7/7] omap3 evm, beagle and overo use the generic twl4030 script
Date: Fri, 10 Oct 2008 10:50:29 -0700
Message-ID: <200810101050.29525.david-b@pacbell.net>
References: <1223657776-16544-1-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-7-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-8-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:32824 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1761238AbYJJRuc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 13:50:32 -0400
In-Reply-To: <1223657776-16544-8-git-send-email-peter.de-schrijver@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Friday 10 October 2008, Peter 'p2' De Schrijver wrote:
> +extern struct twl4030_power_data generic3430_t2scripts_data;

Such "extern" decls should as a rule be in header files...

In this case the rule is appropriate, since you've got the
same decl in three different places.  That's about two times
more often than I'm comfortable making exceptions to such a
rule ... :)

- Dave

