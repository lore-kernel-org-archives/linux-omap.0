From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] alsa: add Beagleboard SoC configuration.
Date: Wed, 17 Sep 2008 09:19:48 +0300
Message-ID: <20080917091948.78604384.jarkko.nikula@nokia.com>
References: <1221597643-29601-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61029 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbYIQGUK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 02:20:10 -0400
In-Reply-To: <1221597643-29601-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, sakoman@gmail.com

On Tue, 16 Sep 2008 23:51:35 +0300
"ext Felipe Contreras" <felipe.contreras@gmail.com> wrote:

> This is exactly the same as the overo configuration. It might make
> sense to have them in a single one.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> 
> This was suggested by Koen Kooi.
> 
>  sound/soc/omap/Kconfig       |    8 ++
>  sound/soc/omap/Makefile      |    2 +
>  sound/soc/omap/omap3beagle.c |  149 +++++++++++++++++++++++++++++++++
> +++++++++ 3 files changed, 159 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/omap/omap3beagle.c
> 
Actually I've been using patched Overo driver in my Beagle for
couple days now :-)

However I propose to keep Beagle and Overo separated as this patch
does. I think Overo can have more versatile audio connections than
Beagle and thus likely to be extended over time where as Beagle audio
HW is fixed as it's now.

Steve, any comments?


Jarkko
