From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-rc7-omap1-git 1/2] twl4030-core: move to drivers/mfd
Date: Thu, 2 Oct 2008 07:52:35 -0700
Message-ID: <200810020752.35738.david-b@pacbell.net>
References: <200810011947.55057.david-b@pacbell.net> <20081002090757.GJ7412@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:47655 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753412AbYJBOwi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 10:52:38 -0400
In-Reply-To: <20081002090757.GJ7412@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org

On Thursday 02 October 2008, Felipe Balbi wrote:
> On Wed, Oct 01, 2008 at 07:47:54PM -0700, David Brownell wrote:
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> I suppose this first one should be From:

Yes. 

> > +	return;
> 
> also this one

I've got a "lots of twl-core cleanups" patch; I'll include this
change there.  This was *just* a "move".
