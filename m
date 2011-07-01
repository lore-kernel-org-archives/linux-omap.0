From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/16] OMAP4: PRCM big spring (late) cleanup
Date: Fri, 1 Jul 2011 02:23:06 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107010221020.27025@utopia.booyaka.com>
References: <1308851025-26313-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1431689597-1309508586=:27025"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57132 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902Ab1GAIXH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 04:23:07 -0400
In-Reply-To: <1308851025-26313-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1431689597-1309508586=:27025
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt,

On Thu, 23 Jun 2011, Benoit Cousson wrote:

> Here are a bunch of cleanups on almost every PRCM related files.
> Some of them are purely code moves, and will look like a lot of
> noise for nothing, but this is needed if we want to keep the files
> aligned with generator tool and thus ease the future migration to
> whatever format (common clock framework + DT).
> Moreover, the diffstat is negative:-)

These look okay to me.  I guess you have at least one change to make to=20
patch 15; please also cc lakml when you repost.


- Paul
--155748971-1431689597-1309508586=:27025--
