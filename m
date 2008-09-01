From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 05/33] add tlv320aic23 driver
Date: Mon, 1 Sep 2008 10:22:28 +0300
Message-ID: <20080901102228.02db1230.jarkko.nikula@nokia.com>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com>
	<1220116593-862-2-git-send-email-me@felipebalbi.com>
	<1220116593-862-3-git-send-email-me@felipebalbi.com>
	<1220116593-862-4-git-send-email-me@felipebalbi.com>
	<1220116593-862-5-git-send-email-me@felipebalbi.com>
	<1220116593-862-6-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:54983 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbYIAHXF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 03:23:05 -0400
In-Reply-To: <1220116593-862-6-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Sat, 30 Aug 2008 20:16:05 +0300
"ext Felipe Balbi" <me@felipebalbi.com> wrote:

> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/i2c/chips/Kconfig       |    7 +
>  drivers/i2c/chips/Makefile      |    1 +
>  drivers/i2c/chips/tlv320aic23.c |  675 ++++++++++++++++++++++++++++++
> +++++++++ 3 files changed, 683 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/chips/tlv320aic23.c
> 
This driver is obsolete audio codec driver and should disappear
eventually than going upstream. At least there is no place for it.

Right path is to have ASoC codec driver for aic23 and develope ASoC
machine driver for affected boards like Nokia 770 and OSK.


Jarkko
