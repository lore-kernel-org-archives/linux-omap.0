From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: ASoC audio not working on OMAP3 EVM
Date: Thu, 12 Feb 2009 11:49:48 +0200
Message-ID: <20090212114948.5fe50dd8.jarkko.nikula@nokia.com>
References: <1234424393.13374.2.camel@eenurkka-desktop>
	<2ee9e08d0902120138p62b91989rbaf525d2efbbad21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28768 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbZBLJuB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 04:50:01 -0500
In-Reply-To: <2ee9e08d0902120138p62b91989rbaf525d2efbbad21@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Anuj Aggarwal <anuj.aggarwal@gmail.com>
Cc: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 12 Feb 2009 10:38:27 +0100
ext Anuj Aggarwal <anuj.aggarwal@gmail.com> wrote:

> The patch doesn't help, result is same...
> 
> Any help is welcome
> 
My Beagle is working fine on top of l-o head (commit
70ff4a1aafd2378c9e3ff153135ba6d0bde45215) and with Steve's patch

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commit;h=80c509fdd74f3b158267374cc55156965c8bf930

What codec OMAP3 EVM is using? If AIC3x, then Eero's patch might help

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commit;h=4453dba54de7e517b0cd6f5e4a3f4af3b34f9e79


Jarkko
