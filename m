From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] ARM: OMAP: CLKFW: Initial debugfs support for omap clock framework
Date: Thu, 17 Apr 2008 11:40:59 -0700
Message-ID: <200804171140.59906.david-b@pacbell.net>
References: <20080416205119.GF17055@atomide.com> <1208441374-25408-1-git-send-email-Hiroshi.DOYU@nokia.com> <alpine.DEB.1.00.0804170952270.3689@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:36186 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751207AbYDQSlD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Apr 2008 14:41:03 -0400
In-Reply-To: <alpine.DEB.1.00.0804170952270.3689@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org

On Thursday 17 April 2008, Paul Walmsley wrote:
> But it would be nice to be able to call into clock functions like 
> round_rate, set_rate, and set_parent via filesystem writes for debugging 
> purposes, and I don't think that debugfs supports this.

It does, if you set up the files properly ... except
maybe the set_parent stuff.

- Dave

