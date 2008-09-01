From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 05/33] add tlv320aic23 driver
Date: Mon, 1 Sep 2008 11:13:12 +0300
Message-ID: <20080901111312.176e3a4c.jarkko.nikula@nokia.com>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com>
	<1220116593-862-2-git-send-email-me@felipebalbi.com>
	<1220116593-862-3-git-send-email-me@felipebalbi.com>
	<1220116593-862-4-git-send-email-me@felipebalbi.com>
	<1220116593-862-5-git-send-email-me@felipebalbi.com>
	<1220116593-862-6-git-send-email-me@felipebalbi.com>
	<20080901102228.02db1230.jarkko.nikula@nokia.com>
	<20080901080158.GV9887@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61834 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbYIAIOJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 04:14:09 -0400
In-Reply-To: <20080901080158.GV9887@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Mon, 1 Sep 2008 11:01:58 +0300
"ext Felipe Balbi" <me@felipebalbi.com> wrote:

> > Right path is to have ASoC codec driver for aic23 and develope ASoC
> > machine driver for affected boards like Nokia 770 and OSK.
> 
> Do we still have anything using on l-o ? Could you send a patch
> getting rid of it ?
> 
At least OSK is still using. I sent some time ago a patch removing 770
related hacks from the driver since they didn't compile anymore.


Jarkko
