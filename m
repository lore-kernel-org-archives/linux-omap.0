From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: ALSA with linux-omap
Date: Fri, 16 Jan 2009 09:37:53 +0200
Message-ID: <20090116093753.314559ab.jarkko.nikula@nokia.com>
References: <496FE1C9.509@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23089 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501AbZAPHiy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 02:38:54 -0500
In-Reply-To: <496FE1C9.509@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Philip Balister <philip@balister.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 15 Jan 2009 18:24:25 -0700
"ext Philip Balister" <philip@balister.org> wrote:

> cat /dev/random > /dev/dsp make a brief soft sound, then stops. Ctrl-c 
> and you can hear a pop a few seconds later.
> 
This sounds like digital audio link between cpu and codec is working but
DMA stalls after transmitting one ALSA period or buffer.

What's your HW? And probably you are using ASoC on OMAP. I.e.
CONFIG_SND_SOC & CONFIG_SND_OMAP_SOC?

> Does this make any sense to anyone? The non pm kernels have been working 
> great.
> 
I'm also curious to know since unfortunately I haven't investigated
yet how well ASoC OMAP drivers co-operate with the dynamic PM.


Jarkko
