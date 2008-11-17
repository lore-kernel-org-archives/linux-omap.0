From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ALSA: ASoC: Add support for OMAP3 EVM
Date: Mon, 17 Nov 2008 13:57:05 +0200
Message-ID: <20081117135705.f7466b8e.jarkko.nikula@nokia.com>
References: <1226904949-32255-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49736 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbYKQL5r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Nov 2008 06:57:47 -0500
In-Reply-To: <1226904949-32255-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, 17 Nov 2008 12:25:49 +0530
"ext Anuj Aggarwal" <anuj.aggarwal@ti.com> wrote:

> 
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
>  sound/soc/omap/Kconfig    |    8 +++
>  sound/soc/omap/Makefile   |    2 +
>  sound/soc/omap/omap3evm.c |  147 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 157 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/omap/omap3evm.c
> 
This should go via alsa-devel mailing list. Generate it against
topic/asoc branch of Takashi Iwai's tree:

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git


Jarkko
