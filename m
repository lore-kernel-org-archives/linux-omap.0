From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: Re: RX51 modem support
Date: Mon, 09 Jan 2012 14:44:06 +0200
Message-ID: <1326113046.2702.7.camel@groo>
References: <20111231212406.GA17188@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:60944 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424Ab2AIMoz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Jan 2012 07:44:55 -0500
In-Reply-To: <20111231212406.GA17188@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sebastian Reichel <sre@debian.org>
Cc: linux-omap@vger.kernel.org

Hi Sebastian,

I am planning to ask Linus to pull the HSI framework in a couple of
days. Today, I have just rebased the patches against v3.2 tag and I am
waiting that everything is ok on linux-next to go ahead. In theory
should not be any problem.

About OMAP SSI driver, I will try to have it for 3.4. Unfortunately, I
can not fully commit to it. I will try to push the hwmod data patch in a
few days for review but I still have to do several changes in the
driver.

Br,
Carlos Chinea
  

On Sat, 2011-12-31 at 22:24 +0100, ext Sebastian Reichel wrote:
> Hi Carlos,
> 
> The HSI framework is in linux-next and should go into 3.3 in the
> next weeks. You wrote, that you will take care of SSI & rx51,
> once the framework is in the kernel [0].
> 
> What's the current status of this? Will this work be ready
> for 3.4?
> 
> [0] https://lkml.org/lkml/2011/6/8/42
> 
> -- Sebastian


