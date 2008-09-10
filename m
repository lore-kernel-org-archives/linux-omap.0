From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 1/2]  McBSP DMA support for  34xx
Date: Wed, 10 Sep 2008 14:14:52 +0300
Message-ID: <20080910141452.c59572e9.jarkko.nikula@nokia.com>
References: <51857.192.168.10.89.1219911960.squirrel@dbdmail.itg.ti.com>
	<20080828135202.657264e6.jarkko.nikula@nokia.com>
	<01fe01c90900$26f83320$LocalHost@wipultra806>
	<20080909163149.GO29054@atomide.com>
	<0d7601c9132e$72d82100$LocalHost@wipultra806>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34151 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbYIJLPh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 07:15:37 -0400
In-Reply-To: <0d7601c9132e$72d82100$LocalHost@wipultra806>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext shekhar, chandra" <x0044955@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Wed, 10 Sep 2008 15:47:34 +0530
"ext shekhar, chandra" <x0044955@ti.com> wrote:

> Most importantly,
> 4> McBSP buffer ( To save power, for 34xx).
> OMAP3430 McBSP interface 2 has 5k buffer for audio.  handling of this
> buffer should be specific to McBSP.
> 
Actually it's not specific to McBSP only. I haven't paid attention into
these HW buffering issues but they have an effect. Like

- IRCC ALSA expects that playback/record is really stopped when trigger
  callback returns
- How HW buffering affects pointer callback? Some low-latency audio
  algorithms require that buffer position is known very precisely. E.g.
  if modifying already queued audio buffer content but which is not
  played out yet


Jarkko
