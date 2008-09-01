From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 28/33] add tsc2301 driver
Date: Mon, 1 Sep 2008 10:35:12 +0300
Message-ID: <20080901103512.bc42d187.jarkko.nikula@nokia.com>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com>
	<1220116593-862-14-git-send-email-me@felipebalbi.com>
	<1220116593-862-15-git-send-email-me@felipebalbi.com>
	<1220116593-862-16-git-send-email-me@felipebalbi.com>
	<1220116593-862-17-git-send-email-me@felipebalbi.com>
	<1220116593-862-18-git-send-email-me@felipebalbi.com>
	<1220116593-862-19-git-send-email-me@felipebalbi.com>
	<1220116593-862-20-git-send-email-me@felipebalbi.com>
	<1220116593-862-21-git-send-email-me@felipebalbi.com>
	<1220116593-862-22-git-send-email-me@felipebalbi.com>
	<1220116593-862-23-git-send-email-me@felipebalbi.com>
	<1220116593-862-24-git-send-email-me@felipebalbi.com>
	<1220116593-862-25-git-send-email-me@felipebalbi.com>
	<1220116593-862-26-git-send-email-me@felipebalbi.com>
	<1220116593-862-27-git-send-email-me@felipebalbi.com>
	<1220116593-862-28-git-send-email-me@felipebalbi.com>
	<1220116593-862-29-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56952 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbYIAHhY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 03:37:24 -0400
In-Reply-To: <1220116593-862-29-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Sat, 30 Aug 2008 20:16:28 +0300
"ext Felipe Balbi" <me@felipebalbi.com> wrote:

> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/spi/Kconfig         |   22 +
>  drivers/spi/Makefile        |    3 +
>  drivers/spi/tsc2301-core.c  |  301 +++++++++++++
>  drivers/spi/tsc2301-mixer.c | 1004 ++++++++++++++++++++++++++++++++++
> +++++++++ 4 files changed, 1330 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/tsc2301-core.c
>  create mode 100644 drivers/spi/tsc2301-mixer.c
> 
Mixer driver here is also obsolete and used by N800 only. I think
TSC2003 driver is easier to handle by trying to push only core,
keyboard and ts part first. There is no place for mixer driver until
it's ported to ASoC codec driver.


Jarkko
