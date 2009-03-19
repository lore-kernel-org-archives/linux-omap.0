From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCHv2] OMAP: McBSP: Always maintain McBSP fclk while active
Date: Thu, 19 Mar 2009 14:29:13 +0200
Message-ID: <20090319142913.fa051504.jarkko.nikula@nokia.com>
References: <12373758621770-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22950 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbZCSM3j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 08:29:39 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2JCTUOA025340
	for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2009 07:29:36 -0500
In-Reply-To: <12373758621770-git-send-email-ext-eero.nurkkala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 18 Mar 2009 12:31:02 +0100
"Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
wrote:

> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> 
> McBSP fclk must be maintained for the duration of
> audio playback or recording. Otherwise the fclk
> may get autogated when the PER96M clk is no longer
> required by other modules. This results in audio
> activity being hang. Also, if the McBSP is run
> as a slave, it is possible that words are
> randomly missed from the playback. Fix all this
> phenomenom by enabling the McBSP fclk
> clockactivity bit for the entire active duration
> of the McBSP usage.
> 
> Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> ---
...
>  		w = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
> -		w &= ~(ENAWAKEUP | SIDLEMODE(0x03));
> -		w |= (ENAWAKEUP | SIDLEMODE(0x02));
> +		w &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY
> (0x03));
> +		w |= (ENAWAKEUP | SIDLEMODE(0x02) | CLOCKACTIVITY
> (0x02));

Based on updated TRM info:
http://marc.info/?l=linux-omap&m=123674373120880&w=2

Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
