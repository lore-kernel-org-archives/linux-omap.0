From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: Nokia Internet Tablets
Date: Mon, 22 Dec 2008 15:00:44 +0200
Message-ID: <20081222150044.6f487f35.jarkko.nikula@nokia.com>
References: <20081222103422.GL29448@guug.org>
	<20081222122757.GI7125@gandalf.research.nokia.com>
	<1229949221.2782.63.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:28912 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697AbYLVNBA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Dec 2008 08:01:00 -0500
In-Reply-To: <1229949221.2782.63.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: igor.stoppa@nokia.com
Cc: felipe.balbi@nokia.com, ext Otto Solares <solca@guug.org>, linux-omap@vger.kernel.org

On Mon, 22 Dec 2008 14:33:41 +0200
"ext Igor Stoppa" <igor.stoppa@nokia.com> wrote:

> > hmm... it could be used for charging but it won't work unless you get
> > documentation of the charging chips used on n8x0. Also, you'd need to
> > change BME I suppose, which you can't :-s
> 
> I think there was the intention to provide BME still i nbinary form but
> make it available to the community and have somebody from nokia to
> recompile it when needed. Far from optimal but at least something.
> 
It is available for the community in binary form. Just
look the /dev/mtdblock3 partition :-)

It is possible to boot via normal initfs and get BME running. Worth to
note that MMC devices nodes are changed since 2.6.21 so one would need
to copy existing initfs, modify device nodes, generate new initfs jffs2
image and flash it back.

Then MMC card can be used as a root just by:

	flasher --set-root-device=mmc

Disclaimer: I'm not charging expert so don't know is this safe but
works for me :-)


Jarkko
