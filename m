From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: ASoC audio not working on OMAP3 EVM
Date: Fri, 13 Feb 2009 12:33:17 +0200
Message-ID: <20090213123317.1c73c722.jarkko.nikula@nokia.com>
References: <1234424393.13374.2.camel@eenurkka-desktop>
	<2ee9e08d0902120138p62b91989rbaf525d2efbbad21@mail.gmail.com>
	<20090212114948.5fe50dd8.jarkko.nikula@nokia.com>
	<E25633C1-D318-4AAC-BEA0-006034B1D619@student.utwente.nl>
	<2ee9e08d0902130144qba6a130l331c663cfdaa574c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35549 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbZBMKdI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 05:33:08 -0500
In-Reply-To: <2ee9e08d0902130144qba6a130l331c663cfdaa574c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Anuj Aggarwal <anuj.aggarwal@gmail.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 13 Feb 2009 10:44:02 +0100
ext Anuj Aggarwal <anuj.aggarwal@gmail.com> wrote:

> Hi All,
> 
> Thanks for your help, it came out as a hardware issue. Same image
> worked fine when tried on a different EVM. Now the audio is playing
> fine, except that I am hearing a very light pop-noise as soon I start
> the playback.
> 
> Any suggestions on removing that? It didn't occur if I play something
> second time.
> 
Pop-noise is caused somewhere in the audio path when it's powered up.
Either in last output stage is causing it or last stages are activated
too early to suppress noise caused in middle of path.

Why you don't hear it second time or soon enough is that ASoC DAPM keeps
audio path powered about 5 seconds after stream is closed for
eliminating pops between e.g. audio tracks in a player.


Jarkko
