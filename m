From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/5] OMAP3&4: Fixes in setup/suspend/powerdomain
Date: Mon, 13 Dec 2010 23:43:56 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012132342030.15971@utopia.booyaka.com>
References: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-2123025582-1292309036=:15971"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42562 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597Ab0LNGn6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 01:43:58 -0500
In-Reply-To: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-2123025582-1292309036=:15971
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt, Kevin,

On Mon, 13 Dec 2010, Benoit Cousson wrote:

> This is a series of fixes on OMAP3/4 in setup apis,
> in the suspend framework and in powerdomain modelling
> for OMAP4.

=2E..

> Rajendra Nayak (3):
>   OMAP4: PM: Use the lowpwrstatechange feature on OMAP4
>   OMAP4: PM: Do not assume clkdm supports hw transitions

The above two patches should be run by Kevin for his ack (cc'ed on this=20
message).  Kevin, care to ack these?



- Paul
--155748971-2123025582-1292309036=:15971--
