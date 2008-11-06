From: Paul Walmsley <paul@booyaka.com>
Subject: Re: current git head craters on boot due to some MTD problem
Date: Thu, 6 Nov 2008 05:21:48 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0811060508120.11718@utopia.booyaka.com>
References: <alpine.DEB.2.00.0811060416090.11718@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47450 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbYKFMWK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 07:22:10 -0500
In-Reply-To: <alpine.DEB.2.00.0811060416090.11718@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, lauri.leukkunen@nokia.com, tony@atomide.com
Cc: ext-timo-pekka.launonen@nokia.com

Hi,

On Thu, 6 Nov 2008, Paul Walmsley wrote:

> The current git head crashes on boot due to some MTD-related problem on 
> 3430SDP.  Partial boot log below.

Timo-Pekka's robot tracked this down to commit 
4a4ada55c1bdaa2b9fd1293611b55ceba14b13e7, which is the system_rev to 
omap_rev() change.  board-3430sdp-flash.c needs to use omap_rev() also and 
not system_rev.  Will send patch as a separate E-mail.


- Paul

