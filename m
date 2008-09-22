From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH PM-0] ARM: OMAP3: HSMMC: Ensure HSMMC is fully reset on
 boot
Date: Sun, 21 Sep 2008 23:26:44 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0809212325320.29963@utopia.booyaka.com>
References: <1221740552-27110-1-git-send-email-khilman@deeprootsystems.com> <20080918124501.GF28615@gandalf.research.nokia.com> <8763os3e3m.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-435621511-1222061204=:29963"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57234 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbYIVF0p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2008 01:26:45 -0400
In-Reply-To: <8763os3e3m.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: felipe.balbi@nokia.com, ext Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-435621511-1222061204=:29963
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Jouni,

On Fri, 19 Sep 2008, H=C3=B6gander Jouni wrote:

> Anyway the plan is to have some generic code which resets all omap
> modules on boot. Maybe even configure them in a way that they do
> not break PM (or anything else). This would make sure that omap
> modules that do not have drivers, would still be in a known
> state. This is planned to be implemented in tiocp code. Paul, am I in
> line with you in this?

Yes, that is the plan.


- Paul
--155748971-435621511-1222061204=:29963--
