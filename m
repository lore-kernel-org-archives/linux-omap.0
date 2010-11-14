From: Marc Zyngier <maz@misterjones.org>
Subject: Re: [PATCH] Fix IGEPv2 second MMC channel power supply
Date: Sun, 14 Nov 2010 18:52:07 +0000
Message-ID: <20101114185207.252e3c1f@taxman.wild-wind.fr.eu.org>
References: <1289734452-31625-1-git-send-email-maz@misterjones.org>
	<14a0f1b94e21549cf4ad2f33647364e3@secure211.sgcpanel.com>
	<AANLkTi=wJ24iqN8+tPw=AOO1H7u0oxaO=SaBh5-Lxr_m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from inca-roads.misterjones.org ([213.251.177.50]:42229 "EHLO
	inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756779Ab0KNSwO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 14 Nov 2010 13:52:14 -0500
In-Reply-To: <AANLkTi=wJ24iqN8+tPw=AOO1H7u0oxaO=SaBh5-Lxr_m@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric =?ISO-8859-1?B?QmFsbGV0YvI=?= i Serra <eballetbo@gmail.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Sun, 14 Nov 2010 19:11:46 +0100
Enric Balletb=F2 i Serra <eballetbo@gmail.com> wrote:

> Why we need to define an unexistent regulator in board file ? This
> should not be done enabling the CONFIG_DUMMY_REGULATOR in your kernel
> configuration  ?

I'm not adding another regulator, but instead simply exposing the fact
(or rather my guess) that the same regulator (vmmc1) is powering the
two MMC channels. Not having access to the board schematics, I can't
tell if that reflects the reality or not.

But using CONFIG_DUMMY_REGULATOR seems the wrong idea to me, as it's
just papering over the issue. We should be exposing what's really on
the board (a fixed regulator if that's the case).

	M.
--=20
I'm the slime oozin' out from your TV set...
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
