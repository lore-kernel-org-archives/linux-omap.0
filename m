From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Issue: TWL4030-USB
Date: Wed, 17 Dec 2008 19:13:14 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087025127C19E@dbde02.ent.ti.com>
References: <A24693684029E5489D1D202277BE894415E6E3C1@dlee02.ent.ti.com>
 <200812111524.57050.david-b@pacbell.net>
 <FCCFB4CDC6E5564B9182F639FC356087025127BDF7@dbde02.ent.ti.com>
 <200812161236.17658.david-b@pacbell.net>
 <FCCFB4CDC6E5564B9182F639FC356087025127BDFE@dbde02.ent.ti.com>
 <20081216210951.GB28981@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35334 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbYLQNnf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Dec 2008 08:43:35 -0500
In-Reply-To: <20081216210951.GB28981@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>-----Original Message-----
>From: Felipe Balbi [mailto:me@felipebalbi.com]
>Sent: Tuesday, December 16, 2008 3:10 PM
>To: Pandita, Vikram
>Cc: David Brownell; linux-omap@vger.kernel.org
>Subject: Re: Issue: TWL4030-USB
>
>On Wed, Dec 17, 2008 at 02:25:29AM +0530, Pandita, Vikram wrote:
>> I looked into: drivers/i2c/chips/twl4030-usb.c
>> Is this supposed to be removed then?
>
>you should probably git pull :-)
>
>This code doesn't exist in current linux-omap.

Yes the git pull solved the issue. 

>
>--
>balbi

