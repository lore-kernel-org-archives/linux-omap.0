From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] MUSB: fix memory corruption when using more than max
	endpoints
Date: Thu, 11 Sep 2008 11:16:27 +0300
Message-ID: <20080911081627.GA16796@gandalf.research.nokia.com>
References: <1221026036-26477-1-git-send-email-khilman@deeprootsystems.com> <20080910103616.GQ16796@gandalf.research.nokia.com> <48C7AD83.60703@deeprootsystems.com> <20080910112656.GR16796@gandalf.research.nokia.com> <20080910235202.GU21163@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23179 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbYIKIQp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 04:16:45 -0400
Content-Disposition: inline
In-Reply-To: <20080910235202.GU21163@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, Sep 10, 2008 at 04:52:03PM -0700, Tony Lindgren wrote:
> I guess you're talking about 8cc4af26d1e2b01cd9dc2c5e6b166d08946bc2e6
> that I just pushed?

Precisely.

-- 
balbi
