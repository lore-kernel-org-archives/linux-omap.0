From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/2] Add touchscreen support for Pandora
Date: Thu, 6 Nov 2008 01:56:01 +0200
Message-ID: <20081105235541.GH4010@frodo>
References: <1225919983-26144-1-git-send-email-notasas@gmail.com> <20081105223920.GG4010@frodo> <6ed0b2680811051541t21a1be36i8ba85db9bfaaa025@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:45366 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbYKEX4L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 18:56:11 -0500
Content-Disposition: inline
In-Reply-To: <6ed0b2680811051541t21a1be36i8ba85db9bfaaa025@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: me@felipebalbi.com, linux-omap@vger.kernel.org, tony@atomide.com

On Thu, Nov 06, 2008 at 01:41:46AM +0200, Grazvydas Ignotas wrote:
> Yes, it's more like a placeholder for future patches. I plan to add a
> function prototype and some more GPIOs. I also plan adding another
> board file for input stuff (board-omap3pandora-input.c), as pandora
> has lots of GPIO buttons with full qwerty keypad, and I don't want to
> clutter the main board file with large arrays of structures.
> If this is not acceptable I can stuff everything into board-omap3pandora.c

I think tony has the final word here, but generally the other board
files have the keypad stuff in the main board file (board-n800.c,
board-3430sdp.c, board-2430sdp.c, etc)

About the defines, it's only nice to put them in the header iff you
need to use the same define on two (or more) different files. Otherwise,
you can make the defines local to the file that needs them :-)

-- 
balbi
