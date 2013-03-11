From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] omap: convert to devm_ioremap_resource()
Date: Mon, 11 Mar 2013 20:43:47 +0200
Message-ID: <513E25E3.5050907@bitmer.com>
References: <1363017537-11602-1-git-send-email-silviupopescu1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:55495 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753906Ab3CKSoI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 14:44:08 -0400
In-Reply-To: <1363017537-11602-1-git-send-email-silviupopescu1990@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Cc: linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, lgirdwood@gmail.com, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org

Hi

On 03/11/2013 05:58 PM, Silviu-Mihai Popescu wrote:
> Convert all uses of devm_request_and_ioremap() to the newly introduced
> devm_ioremap_resource() which provides more consistent error handling.
> 
> devm_ioremap_resource() provides its own error messages so all explicit
> error messages can be removed from the failure code paths.
> 
> Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
> ---
>  sound/soc/omap/omap-dmic.c  |    9 +++------
>  sound/soc/omap/omap-mcpdm.c |    8 +++-----
>  2 files changed, 6 insertions(+), 11 deletions(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
