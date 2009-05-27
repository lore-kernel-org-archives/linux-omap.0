From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Wed, 27 May 2009 20:58:53 +0200
Message-ID: <200905272058.55404.jkrzyszt@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl> <20090527095949.51ed4b83.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:33924 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757556AbZE0S7g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 May 2009 14:59:36 -0400
In-Reply-To: <20090527095949.51ed4b83.jhnikula@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

Hi,

Tired with hopeless looking for the correct mcbsp dai format, I took the 
oposite direciton, trying to break what Mark Underwood had managed to get 
working. Step by step, I got to exactly the same mcbsp register configuration 
as used in the reference osk board, reverting all changes that Mark could 
introduce, and the driver still worked as before. So it looks like playing 
with mcbsp dai format is not the way to solve the problem.

Wednesday 27 May 2009 07:57:27 Peter Ujfalusi wrote:
> This means that the McBSP module is not transmitting/receiving any data.
> Which suggests that the clocking is not working in your setup. Check the
> slave master mode for the codec.

Now I think I understand better what you mean. However, I don't know any way 
of configuring the codec except for switching its pin connections from msbcp 
to modem chip and back. I can find nothing relevant in the original patch 
that could help.

> Also worth checking the PIN configuration for the McBSP1 module, just in
> case it is correct.

Wednesday 27 May 2009 08:59:49 Jarkko Nikula wrote:
> Looks like McBSP is not getting bit-clock and frame-sync signals from
> the codec. Do you have any way to measure is the codec sending those?
>
> Another possibility are the OMAP pins muxed for McBSP? I assume they
> are if the bootloader is still the same but worth to find check was
> previous kernel doing any runtime remuxing for those pins with
> omap_cfg_reg calls.

So I am going to restart with checking if the original patch still works with 
the latest kernel version supporting omap-alsa.

Thanks for your help so far. Any hints are still welcome.

Cheers,
Janusz


