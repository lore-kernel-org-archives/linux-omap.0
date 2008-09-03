From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Git tree updated to v2.6.27-rc5, some USB diffs still lurking
Date: Thu, 4 Sep 2008 01:18:09 +0300
Message-ID: <20080903221807.GC6693@frodo>
References: <20080903221218.GD23085@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:33030 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbYICWSZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 18:18:25 -0400
Content-Disposition: inline
In-Reply-To: <20080903221218.GD23085@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, David Brownell <david-b@pacbell.net>

On Wed, Sep 03, 2008 at 03:12:19PM -0700, Tony Lindgren wrote:
> Hi all,
> 
> I've updated our git tree to -rc5. Now drivers/usb is pretty close to
> being in sync with mainline except for the following diff.
> 
> Dave, could you take a look at the following USB patch and see what
> should be merged, fixed or removed?
> 
> The patch is mostly some ehci-omap.[ch] and musb include fixes. And
> then there are also the H4 OTG patches from Imre still floating on
> this list.

The musb part I sent to Greg already, you should get on -rc6. Here's the
link on linux-usb archive:

http://marc.info/?l=linux-usb&m=122011455015140&w=2

-- 
balbi
