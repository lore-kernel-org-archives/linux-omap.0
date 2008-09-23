From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] PM: Fixed clockdomain state control for OMAP3
Date: Tue, 23 Sep 2008 07:21:57 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0809230721210.27938@utopia.booyaka.com>
References: <> <1221582816-21372-1-git-send-email-tero.kristo@nokia.com> <alpine.DEB.2.00.0809230654480.27938@utopia.booyaka.com> <B71CE868F2BC2847B3F23C5A8EE3943089069D@vaebe110.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41945 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbYIWNV6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 09:21:58 -0400
In-Reply-To: <B71CE868F2BC2847B3F23C5A8EE3943089069D@vaebe110.NOE.Nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: linux-omap@vger.kernel.org

Hello Tero,

On Tue, 23 Sep 2008, Tero.Kristo@nokia.com wrote:

> The access of element 0 only is not because we have only 1 clockdomain
> for each powerdomain, but because we only want to wake up some
> clockdomain
> to make the powerdomain come up. It does not matter which clockdomain is
> awakened, as long as one is, and I don't think it makes sense to wake
> all
> of them up because this would cause additional overhead.

Okay, that sounds fine.


- Paul
