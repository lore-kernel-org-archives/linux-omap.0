From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 11/9] move twl4030-gpio to drivers/gpio
Date: Wed, 1 Oct 2008 16:52:42 +0300
Message-ID: <20081001135242.GF7412@gandalf.research.nokia.com>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <200809271645.20782.david-b@pacbell.net> <20080928031411.GF8468@frodo> <200809272216.14672.david-b@pacbell.net> <94a0d4530810010646j7bc4bd8bsb2b94e96adbb0182@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25680 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbYJANxY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 09:53:24 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530810010646j7bc4bd8bsb2b94e96adbb0182@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Contreras <felipe.contreras@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jean Delvare <khali@linux-fr.org>

On Wed, Oct 01, 2008 at 04:46:14PM +0300, ext Felipe Contreras wrote:
> Hmm, I'm seeing two different configs:
> CONFIG_TWL4030_GPIO

dropped

> CONFIG_GPIO_TWL4030

new one.

-- 
balbi
