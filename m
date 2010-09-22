From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: clock: Fix missing optional clocks
Date: Wed, 22 Sep 2010 01:25:44 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009220123540.21002@utopia.booyaka.com>
References: <1285103430-5964-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1286241719-1285140344=:21002"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58687 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab0IVHZp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 03:25:45 -0400
In-Reply-To: <1285103430-5964-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1286241719-1285140344=:21002
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt,

On Tue, 21 Sep 2010, Benoit Cousson wrote:

> Please note that the diff is pretty bad for the clock table. It looks lik=
e
> everything has changed. I don't know if there is a way to have a better d=
iff
> with git.

It's due to an extra tab that somehow got added between the second and=20
third fields of the clkdev table in your patch.  I've removed that to=20
reduce the diff noise in the updated patch (forthcoming in a few minutes).


- Paul
--155748971-1286241719-1285140344=:21002--
