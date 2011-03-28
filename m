From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 2/2] RX-51: Enable isp1704 power on/off
Date: Mon, 28 Mar 2011 11:39:16 +0300
Message-ID: <20110328083915.GF2251@legolas.emea.dhcp.ti.com>
References: <1301295099-22066-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1301295099-22066-3-git-send-email-kalle.jokiniemi@nokia.com>
 <17a241ba5fb52c72ed49ad345910065f@mail.gmail.com>
 <9D0D31AA57AAF5499AFDC63D6472631B06CEE3@008-AM1MPN1-036.mgdnok.nokia.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:52172 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750776Ab1C1IjV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Mar 2011 04:39:21 -0400
Content-Disposition: inline
In-Reply-To: <9D0D31AA57AAF5499AFDC63D6472631B06CEE3@008-AM1MPN1-036.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kalle.jokiniemi@nokia.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, Heikki.Krogerus@nokia.com, jhnikula@gmail.com, khilman@ti.com

Hi,

(break your lines at 80-chars, I asked you to do this before)

On Mon, Mar 28, 2011 at 08:06:32AM +0000, kalle.jokiniemi@nokia.com wrote:
> Hi,
> 
>  > -----Original Message-----
>  > From: ext Keshava Munegowda [mailto:keshava_mgowda@ti.com]
>  > Sent: 28. maaliskuuta 2011 10:19
>  > To: Jokiniemi Kalle (Nokia-MS/Tampere); linux-usb@vger.kernel.org; linux-
>  > omap@vger.kernel.org; Felipe Balbi
>  > Cc: Krogerus Heikki (Nokia-MS/Helsinki); jhnikula@gmail.com; Kevin Hilman
>  > Subject: RE: [PATCH v2 2/2] RX-51: Enable isp1704 power on/off
>  > 
>  > > +
>  > >  static struct platform_device rx51_charger_device = {
>  > > -	.name = "isp1704_charger",
>  > > +	.name	= "isp1704_charger",
>  > 
>  > Both are same; you don't need this change!
> 
> No, actually they are not same. I added tab instead of space to match
> indentation with the .dev member. This is the correct way IMHO.

Still, changing that indentation isn't part of $SUBJECT. You need to put
that in another patch.

-- 
balbi
