From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] omap-mcbsp: properly check for availablity of mcbsp mux
 settings
Date: Mon, 20 Aug 2012 09:02:30 +0300
Message-ID: <5031D2F6.3020905@bitmer.com>
References: <1345403692-20829-1-git-send-email-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:46121 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742Ab2HTGCh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 02:02:37 -0400
In-Reply-To: <1345403692-20829-1-git-send-email-andreas@kemnade.info>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: peter.ujfalusi@ti.com, linux-omap@vger.kernel.org

Hi

On 08/19/2012 10:14 PM, Andreas Kemnade wrote:
> The code did return -EINVAl when the mux_signal function pointer is available.
> If not, the corresponding function (the NULL pointer) is called.
> This patch inverts that logic.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
Thanks for the patch. Fortunately Peter has already the same fix d0db84e
(ASoC: omap-mcbsp: Fix 6pin mux configuration) for it in:

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git

I expect fix to hit 3.6-rc and 3.4-3.5 stable soon.

-- 
Jarkko
