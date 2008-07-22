From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [i2c] N800 problems with MMC, LM8323 on current linux-omap git head
Date: Tue, 22 Jul 2008 09:20:46 -0500
Message-ID: <eb09f11f1e5a25903cfd4c2157ecbba5@felipebalbi.com>
References: <20080722124743.GA5820@kos.to> <90eb4be1e5a489819f08e76ad872e920@felipebalbi.com> <20080722133742.GA7492@kos.to> <20080722134314.GC8318@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55969 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbYGVOUv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jul 2008 10:20:51 -0400
In-Reply-To: <20080722134314.GC8318@fluff.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, linux-omap@vger.kernel.org, i2c@lm-sensors.org

Hi,

On Tue, 22 Jul 2008 14:43:14 +0100, Ben Dooks <ben-linux@fluff.org> wrote:
> Split them into a common and then machine specfic structures, you are
> allowed to register more than one board per bus.

Good to know :-)

Riku, could you update your patch then ?

but it anyways doesn't annul the need of a better error handling
in lm8323. I think both patches will need to be applied :-)

-- 
Best Regards,

Felipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com

