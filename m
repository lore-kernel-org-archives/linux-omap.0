From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Any one is still using omap-kernel on N810???
Date: Sat, 19 Sep 2009 10:06:27 +0300
Message-ID: <20090919100627.2b946f64.jhnikula@gmail.com>
References: <A2AD06B24DC9F846B5C9B99602FA10E7030D647E@cameurexb01.EUROPE.ROOT.PRI>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:61205 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851AbZISHGK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Sep 2009 03:06:10 -0400
Received: by ewy2 with SMTP id 2so1869696ewy.17
        for <linux-omap@vger.kernel.org>; Sat, 19 Sep 2009 00:06:13 -0700 (PDT)
In-Reply-To: <A2AD06B24DC9F846B5C9B99602FA10E7030D647E@cameurexb01.EUROPE.ROOT.PRI>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefano Panella <Stefano.Panella@csr.com>
Cc: linux-omap@vger.kernel.org

On Fri, 18 Sep 2009 10:42:22 +0100
"Stefano Panella" <Stefano.Panella@csr.com> wrote:

> Is there any one testing linux-omap on N810?
> I have got a N810 board and I am trying to install ubuntu on it.
> 
> Is there any how-to or update instruction I can follow?
> 
I haven't run linux-omap on N8x0 recently after the board files were
reset to mainline version. But before that, somewhere around May 2009,
it was still working quite well. I.e. fb, nand, mmc, keyboard, musb,
etc. You may find working commit from these threads:

http://marc.info/?l=linux-omap&m=123578444424326&w=2
http://marc.info/?l=linux-omap&m=124190972722908&w=2

Now there is good chance to get it working also on vanilla kernel as
the basic board file just went to mainline. It just needs that missing
pieces from git history are added into board-n8x0.c for those devices
which are in mainline.


-- 
Jarkko
