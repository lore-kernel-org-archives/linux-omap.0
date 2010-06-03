From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 00/14] omap: mailbox: bunch of cleanups
Date: Thu, 3 Jun 2010 12:47:26 +0100
Message-ID: <20100603114726.GC7127@n2100.arm.linux.org.uk>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com> <20100603.094022.200375421.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38721 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab0FCLrr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 07:47:47 -0400
Content-Disposition: inline
In-Reply-To: <20100603.094022.200375421.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: felipe.contreras@gmail.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jun 03, 2010 at 09:40:22AM +0300, Hiroshi DOYU wrote:
> > Felipe Contreras (14):
> >   omap: mailbox: trivial whitespace cleanups
> >   omap: mailbox: trivial cleanups

I think folk need to read this:

	http://lkml.org/lkml/2010/6/2/472

and consider what it means for the future, and what can be done to reduce
the amount of "churn".
