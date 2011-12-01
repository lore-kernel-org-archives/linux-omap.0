From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: Setting OMAP DSS fck
Date: Thu, 1 Dec 2011 09:00:27 -0800
Message-ID: <CAJOA=zNfi-_rek82RTtoZ=XLH6o6e9k-gfvQYYmsPHbQGz3ANw@mail.gmail.com>
References: <1322727382.16429.4.camel@deskari> <4ED741C3.9010904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:51455 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755356Ab1LARA7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Dec 2011 12:00:59 -0500
Received: by mail-iy0-f174.google.com with SMTP id e36so3393610iag.5
        for <linux-omap@vger.kernel.org>; Thu, 01 Dec 2011 09:00:48 -0800 (PST)
In-Reply-To: <4ED741C3.9010904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap mailing list <linux-omap@vger.kernel.org>

On Thu, Dec 1, 2011 at 12:58 AM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> On 12/1/2011 9:16 AM, Tomi Valkeinen wrote:
>> =A0From driver's perspective I think this only makes things more com=
plex,
>> as the driver is not interested in the parent, only about the dss fc=
k.
>
> Fully agree. It should transparent for the driver.

The new common clk patches do try to take care of this.  A child clk
may be marked with CLK_PARENT_RATE_CHANGE flag which tells
clk_set_rate to (potentially) propagate up to the parent and change
it's rate.

This won't help you currently Tomi, but you can take comfort knowing
that someday your driver won't have to know details about dss_fck's
parent ;-)

Regards,
Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
