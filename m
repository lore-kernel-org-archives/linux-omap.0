From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] i2c-omap: fix I2C timeouts due to recursive omap_i2c_{un,}idle()
Date: Fri, 10 Oct 2008 14:29:45 -0700
Message-ID: <200810101429.45548.david-b@pacbell.net>
References: <alpine.DEB.2.00.0810101056020.13922@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:44678 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760935AbYJJV3y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 17:29:54 -0400
In-Reply-To: <alpine.DEB.2.00.0810101056020.13922@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, r-woodruff2@ti.com

On Friday 10 October 2008, Paul Walmsley wrote:
> Problem reported by David Brownell <david-b@pacbell.net>.

Hmm, seems to solve the problem for me too... though for
the life of me I can't quite see how that explains all
the symptoms I've observed.  I'll keep an eye out to see
what comes up over time; I could believe this is only one
of the problems lurking here.

- Dave



