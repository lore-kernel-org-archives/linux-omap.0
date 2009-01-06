From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: Query on backlight driver
Date: Tue, 06 Jan 2009 23:42:16 +0000
Message-ID: <1231285336.5330.92.camel@dax.rpnet.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301BB75B335@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:52112 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbZAGAGI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Jan 2009 19:06:08 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301BB75B335@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2009-01-07 at 01:46 +0530, Premi, Sanjeev wrote:
> I have implemented a basic backlight driver for OMAP3EVM (patch below).
>  
> However, have been having few problems. Any suggestions would be useful.
>  
> 1) Though build was successful; the print from the backlight driver did
>    not appear during the kernel boot.

Your patch adds the platform driver but do you have a corresponding
platform device?

Also, please do not just copy the corgibl file, just install a
corresponding platform device and reuse the existing corgibl driver
instead. For reference, corgibl will be renamed genericbl soon to make
it clearer that its actually generic code that can be reused.

Regards,

Richard



