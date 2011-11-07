From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] BUILD FIX:hwspinlock: do not return any value from void
 funtion
Date: Mon, 7 Nov 2011 14:03:28 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8023B1B@DBDE01.ent.ti.com>
References: <1320670686-29286-1-git-send-email-hvaibhav@ti.com>
 <CAK=WgbZyAEf_x3acGVf=7hPkrHGjg8LdP5ko2Hp_QZoebkhw=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32870 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932158Ab1KGODe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 09:03:34 -0500
In-Reply-To: <CAK=WgbZyAEf_x3acGVf=7hPkrHGjg8LdP5ko2Hp_QZoebkhw=Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Ohad Ben-Cohen [mailto:ohad@wizery.com]
> Sent: Monday, November 07, 2011 7:25 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: Re: [PATCH] BUILD FIX:hwspinlock: do not return any value from
> void funtion
> 
> On Mon, Nov 7, 2011 at 2:58 PM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
> > Fixes below compilation error -
> 
> Thanks. We already have this fix queued up though (reported by Axel awhile
> ago).
Found it...

http://comments.gmane.org/gmane.linux.kernel/1210678

Thanks,
Vaibhav
