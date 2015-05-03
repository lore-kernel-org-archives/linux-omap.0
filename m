From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: v4.1-rc1 & N900: annoying Nokia modem spam
Date: Sun, 3 May 2015 12:27:25 +0300
Message-ID: <20150503092725.GA2358@fuloong-minipc.musicnaut.iki.fi>
References: <20150502184337.GA575@fuloong-minipc.musicnaut.iki.fi>
 <20150503002938.GA11653@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:56105 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbbECJ1c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 3 May 2015 05:27:32 -0400
Content-Disposition: inline
In-Reply-To: <20150503002938.GA11653@earth>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-omap@vger.kernel.org

Hi,

On Sun, May 03, 2015 at 02:29:38AM +0200, Sebastian Reichel wrote:
> On Sat, May 02, 2015 at 09:43:37PM +0300, Aaro Koskinen wrote:
> > With v4.1-rc1, after loading nokia_modem I get the following endless
> > log spam until I load cmt_speech (for whatever reason it does not get
> > modprobed automatically with busybox modprobe):
> 
> So ssi-protocol is loaded automatically and cmt-speech is not?
> That's strange, since they are requested the same way.

Hmm, right. This seems to be issue in my initramfs setup.

> > 	[   41.626983] nokia-modem n900-modem: Missing cmt-speech driver
>
> Everything (except of the first line) is because you have
> CONFIG_DEBUG_GPIO enabled and nokia-modem returns -EPROBE_DEFER
> until all drivers are available, so GPIOs will be acquired again
> the next time the drivers tries to probe.

Actually only the first line (Missing cmt-speech driver) was the annoying
part - because it's an error log it reached the frame buffer and there
was so many of them that everything else scrolled off...

A.
