From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: OMAP 35x security accelerators
Date: Wed, 18 Feb 2009 19:18:29 +0200
Message-ID: <20090218171828.GC32125@frodo>
References: <dbdb2ea60902180911u24d3e176w948677e931dd512f@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46627 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbZBRRSe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2009 12:18:34 -0500
Content-Disposition: inline
In-Reply-To: <dbdb2ea60902180911u24d3e176w948677e931dd512f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, dacohen@gmail.com

On Wed, Feb 18, 2009 at 12:11:30PM -0500, twebb wrote:
> Does anyone have any knowledge of existing code/drivers that take
> advantage of the on-board security block of the OMAP 35xx processors?
> I've been told that the GP part includes the hardware accelerators for
> RNG, DES, AES, SHA, etc.  Are drivers available for this
> functionality?

david cohen had implemented for 2420, at least MD5/SHA1 driver, I guess
it could be extended for omap3 support.

Check drivers/crypto/omap-sha1-md5.c and you might be able to extend it.

-- 
balbi
