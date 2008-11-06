From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] Add touchscreen support for Pandora
Date: Wed, 5 Nov 2008 17:17:38 -0800
Message-ID: <20081106011738.GK21736@atomide.com>
References: <1225919983-26144-1-git-send-email-notasas@gmail.com> <20081105223920.GG4010@frodo> <6ed0b2680811051541t21a1be36i8ba85db9bfaaa025@mail.gmail.com> <20081105235541.GH4010@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49178 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbYKFBRl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 20:17:41 -0500
Content-Disposition: inline
In-Reply-To: <20081105235541.GH4010@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [081105 15:56]:
> On Thu, Nov 06, 2008 at 01:41:46AM +0200, Grazvydas Ignotas wrote:
> > Yes, it's more like a placeholder for future patches. I plan to add a
> > function prototype and some more GPIOs. I also plan adding another
> > board file for input stuff (board-omap3pandora-input.c), as pandora
> > has lots of GPIO buttons with full qwerty keypad, and I don't want to
> > clutter the main board file with large arrays of structures.
> > If this is not acceptable I can stuff everything into board-omap3pandora.c
> 
> I think tony has the final word here, but generally the other board
> files have the keypad stuff in the main board file (board-n800.c,
> board-3430sdp.c, board-2430sdp.c, etc)
> 
> About the defines, it's only nice to put them in the header iff you
> need to use the same define on two (or more) different files. Otherwise,
> you can make the defines local to the file that needs them :-)

Well the header should be there only if needed for other boards.

Tony
