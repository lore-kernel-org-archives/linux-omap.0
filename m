From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 28/33] add tsc2301 driver
Date: Mon, 1 Sep 2008 11:11:07 +0300
Message-ID: <20080901111107.541c3471.jarkko.nikula@nokia.com>
References: <1220116593-862-21-git-send-email-me@felipebalbi.com>
	<1220116593-862-22-git-send-email-me@felipebalbi.com>
	<1220116593-862-23-git-send-email-me@felipebalbi.com>
	<1220116593-862-24-git-send-email-me@felipebalbi.com>
	<1220116593-862-25-git-send-email-me@felipebalbi.com>
	<1220116593-862-26-git-send-email-me@felipebalbi.com>
	<1220116593-862-27-git-send-email-me@felipebalbi.com>
	<1220116593-862-28-git-send-email-me@felipebalbi.com>
	<1220116593-862-29-git-send-email-me@felipebalbi.com>
	<20080901103512.bc42d187.jarkko.nikula@nokia.com>
	<20080901075806.GT9887@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53953 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbYIAIMS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 04:12:18 -0400
In-Reply-To: <20080901075806.GT9887@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Mon, 1 Sep 2008 10:58:08 +0300
"ext Felipe Balbi" <me@felipebalbi.com> wrote:

> > Mixer driver here is also obsolete and used by N800 only. I think
> > TSC2003 driver is easier to handle by trying to push only core,
> > keyboard and ts part first. There is no place for mixer driver until
> > it's ported to ASoC codec driver.
> 
> Cool, I'll drop this one as well. Will you take care of moving it to
> ASoC ?
> 
Unfortunately I have very low priority for it :-(


Jarkko
