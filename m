From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Thu, 6 Nov 2008 22:19:06 +0200
Message-ID: <6ed0b2680811061219p40439337h2a6938009aa20522@mail.gmail.com>
References: <1225418657-31775-1-git-send-email-tony@atomide.com>
	 <200811051554.24055.david-b@pacbell.net>
	 <20081106033210.GP21736@atomide.com>
	 <200811052309.59974.david-b@pacbell.net>
	 <20081106170445.GU21736@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:36758 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbYKFUTI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 15:19:08 -0500
Received: by ey-out-2122.google.com with SMTP id 6so370354eyi.37
        for <linux-omap@vger.kernel.org>; Thu, 06 Nov 2008 12:19:07 -0800 (PST)
In-Reply-To: <20081106170445.GU21736@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

I have another SD slot connected to MMC2 via transceiver (in addition
to usual MMC1). I wonder how can I add support for that? The easiest
way is to add remaining twl_mmc2_* functions mmc-twl4030.c, and it
works, but this stuff would be useless for all other boards, and I
know you hate #ifdefs here. Another way is to just copy mmc-twl4030.c
and add stuff there, but that would result in lots of code
duplication. BTW, we also have wifi chip on MMC3.
Any ideas?

Gra=9Evydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
