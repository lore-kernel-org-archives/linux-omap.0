From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Fri, 31 Oct 2008 17:36:44 -0700
Message-ID: <200810311736.45168.david-b@pacbell.net>
References: <1225418657-31775-1-git-send-email-tony@atomide.com> <200810310300.24515.david-b@pacbell.net> <5e088bd90810311635p26bdd8b9n3e7429bac29bd82c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:33299 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750795AbYKAAgr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Oct 2008 20:36:47 -0400
In-Reply-To: <5e088bd90810311635p26bdd8b9n3e7429bac29bd82c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Friday 31 October 2008, Steve Sakoman wrote:
> TI claims that the 1.0.2 release of the 35XX EVM software will suppor=
t
> the libertas_sdio driver via the EVM's mmc slot. =A0However, I don't =
see
> that version of the software yet on the TI site, and my guess is that
> it will be using the internal TI kernel and not linux-omap.

Darn...

So while Tony's updates will enable root-on-MMC (vs just ramfs)
Overo won't yet have network links except over bluetooth.

Until the twl4030 USB transceiver driver goes to mainline,
at which point usb network links will work.  :)

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
