From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 17/33] add tea5761 radio driver
Date: Mon, 1 Sep 2008 10:24:31 +0300
Message-ID: <20080901102431.b7bc647e.jarkko.nikula@nokia.com>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com>
	<1220116593-862-2-git-send-email-me@felipebalbi.com>
	<1220116593-862-3-git-send-email-me@felipebalbi.com>
	<1220116593-862-4-git-send-email-me@felipebalbi.com>
	<1220116593-862-5-git-send-email-me@felipebalbi.com>
	<1220116593-862-6-git-send-email-me@felipebalbi.com>
	<1220116593-862-7-git-send-email-me@felipebalbi.com>
	<1220116593-862-8-git-send-email-me@felipebalbi.com>
	<1220116593-862-9-git-send-email-me@felipebalbi.com>
	<1220116593-862-10-git-send-email-me@felipebalbi.com>
	<1220116593-862-11-git-send-email-me@felipebalbi.com>
	<1220116593-862-12-git-send-email-me@felipebalbi.com>
	<1220116593-862-13-git-send-email-me@felipebalbi.com>
	<1220116593-862-14-git-send-email-me@felipebalbi.com>
	<1220116593-862-15-git-send-email-me@felipebalbi.com>
	<1220116593-862-16-git-send-email-me@felipebalbi.com>
	<1220116593-862-17-git-send-email-me@felipebalbi.com>
	<1220116593-862-18-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19707 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbYIAHYs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 03:24:48 -0400
In-Reply-To: <1220116593-862-18-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Sat, 30 Aug 2008 20:16:17 +0300
"ext Felipe Balbi" <me@felipebalbi.com> wrote:

> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/media/radio/Kconfig         |   13 +
>  drivers/media/radio/Makefile        |    1 +
>  drivers/media/radio/radio-tea5761.c |  517 ++++++++++++++++++++++++++
> +++++++++ 3 files changed, 531 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/media/radio/radio-tea5761.c
> 
I have the impression that Eduardo Valentin had work in progress to
push this via v4l list. However, don't know the current status.


Jarkko
