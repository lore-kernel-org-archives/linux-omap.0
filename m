From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH RFC 2/2] mtd : Make the mtd_suspend return 0 if the suspend is not implemented
Date: Thu, 2 Feb 2012 19:40:26 +0100
Message-ID: <201202021940.26552.rjw@sisk.pl>
References: <1327306361-9803-1-git-send-email-shubhrajyoti@ti.com> <201201302358.26152.rjw@sisk.pl> <1328183022.28171.165.camel@sauron.fi.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34357 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756276Ab2BBSgo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Feb 2012 13:36:44 -0500
In-Reply-To: <1328183022.28171.165.camel@sauron.fi.intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com, David Woodhouse <dwmw2@infradead.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Brian Norris <computersforpeace@gmail.com>, Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Thursday, February 02, 2012, Artem Bityutskiy wrote:
> On Mon, 2012-01-30 at 23:58 +0100, Rafael J. Wysocki wrote:
> > Thanks, but is anyone actually going to push it to Linus any time soon?
> 
> I agree, but I am not the maintainer so cannot answer. David Woodhouse
> is aware of this, but I do not know when he gonna send the pull request.

Well, the problem is being reported by more and more people, so I'd
like to push the fix quickly.

David, please let me know if you don't want me to include the $subject patch
into the next PM fixes pull request.  If I don't hear from you, I'll push it
next week for -rc4.

Thanks,
Rafael
