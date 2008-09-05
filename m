From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] Implement powerdomain off on state counters
Date: Fri, 5 Sep 2008 08:51:17 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809050850360.5763@utopia.booyaka.com>
References: <1220620885-6096-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45156 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbYIEOvS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 10:51:18 -0400
In-Reply-To: <1220620885-6096-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Fri, 5 Sep 2008, Peter 'p2' De Schrijver wrote:

> This patchset implement counters to count the number of off to on state 
> transitions in a powerdomain. These counters will be made available to
> drivers in a later patchset to allow them to make a better informed
> decision wether to restore the hardware registers or not.

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
