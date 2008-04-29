From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: Android on N810 File System Problem
Date: Tue, 29 Apr 2008 12:49:40 +0300
Message-ID: <20080429124940.20cc88fd.jarkko.nikula@nokia.com>
References: <6a56d69c0804241248w5e46efe8k757c9e5fb9e3ce22@mail.gmail.com>
	<48116F5C.9040009@googlemail.com>
	<20080425183605.GA27479@kedavra.cpe.vivax.com.br>
	<87fxt7my4o.fsf@nokia.com>
	<20080427223248.GA5962@kedavra.cpe.vivax.com.br>
	<20080428233827.GE8449@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57715 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486AbYD2Jt0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2008 05:49:26 -0400
In-Reply-To: <20080428233827.GE8449@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, Kalle Valo <kalle.valo@nokia.com>, Dirk Behme <dirk.behme@googlemail.com>, Jonathan Herriott <herriojr@gmail.com>, linux-omap@vger.kernel.org

On Mon, 28 Apr 2008 16:38:28 -0700
"ext Tony Lindgren" <tony@atomide.com> wrote:

> I've merged Jarkko's asoc patch to linux-omap for testing. Have not
> gotten any sound out of it on my n810 though.. Maybe some alsamixer
> settings issue?
> 
Have you set CONFIG_OMAP_MUX? Otherwise McBSP2 pins are muxed for EAC
block by the bootloader.


Jarkko
