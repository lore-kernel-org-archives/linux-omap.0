From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v4] power_supply: Add driver for TWL4030/TPS65950 BCI
 charger
Date: Thu, 30 Sep 2010 19:33:37 +0400
Message-ID: <20100930153336.GA5923@oksana.dev.rtsoft.ru>
References: <1285618704-8985-1-git-send-email-notasas@gmail.com>
 <20100928060554.GF2702@legolas.emea.dhcp.ti.com>
 <AANLkTikZqtXa2YQsDehoWVMRstefUyafsQn2mph7U3CZ@mail.gmail.com>
 <20100928084251.GC3900@legolas.emea.dhcp.ti.com>
 <AANLkTin-6BLBHeiyA1edTJVjwVAimmJLVicZj8c_VC_2@mail.gmail.com>
 <20100928090637.GD3900@legolas.emea.dhcp.ti.com>
 <AANLkTim28RmH28LGgp6bEJ7XbyL4oO_5_C0phLL86roY@mail.gmail.com>
 <20100928094122.GA7081@legolas.emea.dhcp.ti.com>
 <20100928112643.GC22734@oksana.dev.rtsoft.ru>
 <20100928133345.GA8575@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59892 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117Ab0I3Pdu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 11:33:50 -0400
Content-Disposition: inline
In-Reply-To: <20100928133345.GA8575@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Arun Murthy <arunrmurthy.83@gmail.com>

On Tue, Sep 28, 2010 at 04:33:45PM +0300, Felipe Balbi wrote:
[...]
> >>>Hm you are probably talking about TWL5031, which has redesigned
> >>>charger block that is named BCC. TWL4030 charger is different, called
> >>>BCI and requires software charger detection from what I see in it's
> >>>TRM.
> >>
> >>ok, might be that I got confused. Then it's ok the way it is. So we need
> >>other means to detect the charger :-p
> >
> >May we consider this as a minor issue that can be improved later?
> 
> Sure, it's fine.
> 
> >If so, I would like to apply it, but I'll wait a day or two for
> >Reviewed-by or Acked-by tags to give the proper credits.
> 
> Here you go.
> 
> Acked-by: Felipe Balbi <balbi@ti.com>

Applied, thanks everyone!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
