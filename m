From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: mmc1: error -110 whilst initialising SDIO card
Date: Sat, 11 Dec 2010 23:24:57 +0200
Message-ID: <AANLkTikESPwcaxUSDd3B=Oh7kBD-QpndKRHmu9-roDqs@mail.gmail.com>
References: <57CB308D-7237-46D7-9AF8-7093F52682E8@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f170.google.com ([209.85.214.170]:48568 "EHLO
	mail-iw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab0LKVce convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Dec 2010 16:32:34 -0500
Received: by iwn6 with SMTP id 6so7125720iwn.1
        for <linux-omap@vger.kernel.org>; Sat, 11 Dec 2010 13:32:34 -0800 (PST)
In-Reply-To: <57CB308D-7237-46D7-9AF8-7093F52682E8@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, OMAP Android Discussion Mailing List <omapandroid-discussion@omapzoom.org>

On Sat, Dec 11, 2010 at 9:59 PM, Elvis Dowson <elvis.dowson@mac.com> wr=
ote:
> mmc1: card claims to support voltages below the defined range. These =
will be ignored.

This is expected - not an error.

> When I build the TI WiLink drivers from the ti rowboat hardware/ti/wl=
an project

The linux-omap community can help you with mainline drivers, but no so
much with proprietary ones. Why don't you use the upstream wl12xx
driver ?

> [ =A0250.135864] mmc1: error -110 whilst initialising SDIO card
>
> How can I troubleshoot this issue?

Try to find what triggers this error. Start with mmc_attach_sdio() -
it should be around there.

If you ask me, I'd start with making sure that all the jumpers on your
Murata module are set correctly.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
