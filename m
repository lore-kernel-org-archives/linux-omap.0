From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v3 0/5]  OMAP/ASoC: McBSP: FIFO handling related fixes
Date: Tue, 1 Jun 2010 14:40:46 +0300
Message-ID: <20100601144046.a3d20481.jhnikula@gmail.com>
References: <1275391104-26387-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:63914 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab0FALiZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 07:38:25 -0400
Received: by ewy8 with SMTP id 8so1186293ewy.28
        for <linux-omap@vger.kernel.org>; Tue, 01 Jun 2010 04:38:24 -0700 (PDT)
In-Reply-To: <1275391104-26387-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, tony@atomide.com, ext-eero.nurkkala@nokia.com, eduardo.valentin@nokia.com

On Tue,  1 Jun 2010 14:18:19 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> Hello,
> 
> Changes since RFC v2:
> - Comments added explaining the changes, and documenting the API in patch2
> - In patch5:
>  - Variable names changed in the hw_rule function
>  - hw_rule function got renamed
>  - The snd_pcm_hw_rule_add calls moved so it anly got set on OMAP3
> 
To whole series:

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
