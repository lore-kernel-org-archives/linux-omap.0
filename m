From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Future of resource framework?
Date: Mon, 7 Jun 2010 22:31:48 +0300
Message-ID: <20100607193148.GA29354@nokia.com>
References: <AANLkTilpHjef3xbxB9QN9bj6MFmJA1jMwVxNQyZQcSKy@mail.gmail.com>
 <871vd5kxqg.fsf@deeprootsystems.com>
 <AANLkTinSB0bIorWTwLuNhWC9g4oQArAhx-WdY-K-aadS@mail.gmail.com>
 <87hbljisi1.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0321623820@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:41649 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab0FGTc6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 15:32:58 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0321623820@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Mike Chan <mike@android.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

On Fri, Jun 04, 2010 at 05:01:49AM +0200, ext Gadiyar, Anand wrote:
>What if a driver knows that it cannot afford to let the PM layer
>turn off the power domain at certain points of time (maybe as long
>as a USB cable is connected). How can this be specified in terms
>of a latency or throughput constraint?
>
>Just curious, since I don't understand current OMAP3 PM code
>as well as I would like to.

that should be simple if you set latency to 10us or mpu frequency to 
500MHz should do it.

-- 
balbi

DefectiveByDesign.org
