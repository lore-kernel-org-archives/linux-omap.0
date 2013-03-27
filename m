From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 02/10] gpio: gpio-mvebu.c: fix checkpatch errors
Date: Wed, 27 Mar 2013 13:39:49 +0100
Message-ID: <CACRpkdZ8mWC7ujrXHCGuugo7iHJS2-xhUdj1m5p29hr1Km5-Zg@mail.gmail.com>
References: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
	<1363781764-17330-3-git-send-email-laurent.navet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63686 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab3C0Mju (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 08:39:50 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so7048769iec.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Mar 2013 05:39:49 -0700 (PDT)
In-Reply-To: <1363781764-17330-3-git-send-email-laurent.navet@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Navet <laurent.navet@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Jamie Lentin <jm@lentin.co.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>
Cc: grant.likely@secretlab.ca, santosh.shilimkar@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 20, 2013 at 1:15 PM, Laurent Navet <laurent.navet@gmail.com> wrote:

> Fix :
>  gpio/gpio-mvebu.c:120: ERROR: space required before the open parenthesis '('
>  gpio/gpio-mvebu.c:136: ERROR: space required before the open parenthesis '('
>  gpio/gpio-mvebu.c:154: ERROR: space required before the open parenthesis '('
>  gpio/gpio-mvebu.c:404: ERROR: space required before the open parenthesis '('
>  gpio/gpio-mvebu.c:476: ERROR: "(foo*)" should be "(foo *)"
>  gpio/gpio-mvebu.c:480: ERROR: "(foo*)" should be "(foo *)"
>  gpio/gpio-mvebu.c:484: ERROR: "(foo*)" should be "(foo *)"
>  gpio/gpio-mvebu.c:512: ERROR: space prohibited after that '!' (ctx:BxW)
>  gpio/gpio-mvebu.c:518: ERROR: space prohibited after that '!' (ctx:BxW)
>  gpio/gpio-mvebu.c:518: ERROR: space required before the open brace '{'
>  gpio/gpio-mvebu.c:563: ERROR: space prohibited after that '!' (ctx:BxW)
>  gpio/gpio-mvebu.c:570: ERROR: trailing whitespace
>  gpio/gpio-mvebu.c:577: ERROR: space required before the open parenthesis '('
>  gpio/gpio-mvebu.c:635: ERROR: space prohibited after that '!' (ctx:BxW)
>
> Signed-off-by: Laurent Navet <laurent.navet@gmail.com>

Patch applied.

Thanks!
Linus Walleij
