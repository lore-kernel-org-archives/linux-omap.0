From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: status of USB on omap35xx ?
Date: Thu, 11 Dec 2008 01:18:51 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870251066903@dbde02.ent.ti.com>
References: <1228870250.32014.148.camel@localhost.localdomain>
 <1228926833.32014.162.camel@localhost.localdomain>
 <20081210174030.GD9799@frodo> <200812101028.25235.david-b@pacbell.net>
 <20081210190100.GF9799@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54598 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbYLJTtG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Dec 2008 14:49:06 -0500
In-Reply-To: <20081210190100.GF9799@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>, David Brownell <david-b@pacbell.net>
Cc: Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe
>Balbi
>Sent: Wednesday, December 10, 2008 1:01 PM
>To: David Brownell
>Cc: me@felipebalbi.com; Jeff Steele; linux-omap
>Subject: Re: status of USB on omap35xx ?
>
>On Wed, Dec 10, 2008 at 10:28:25AM -0800, David Brownell wrote:
>> I don't know the details, but the big problem with EHCI
>> on OMAP3 is evidently some kind of silicon issue that
>> shows up through the transceiver hookup and prevents the
>> link from being reliable.  I'm told that some boards using
>> that without a transceiver -- for on-board communication,
>> not for an external link -- have been successful.

Internally in TI on SDP3430 we have EHCI working for PHY as well as TLL mode.
The PHY we used is ISP1504 for EHCI and ISP1301 for OHCI.

>>
>> Folk at TI were looking at those issues; I don't know if
>> they've been resolved yet, e.g. in the ES 3.0 silicon.
>
>Oh yeah, that's right. There was some pin-incompatibility with ohci
>which prevented port handoffs to be done reliably, or something like
>that.

USB-HOST core is primarily designed to support TLL mode.
Dynamic switch from EHCI to OHCI is not supported. It has to be statically set.

Eg:
Port1-EHCI
Port2-EHCI
Port3-OHCI

There was a limitation in earlier silicons that EHCI and OHCI cannot be used simultaneously, which has been resolved in ES3.0

>
>If I'm not wrong, once the port is handed over to ohci, it can never
>switch back to ehci and it dies.
>
>Can't really remember if this is the right issue since I haven't been
>working too much with ehci :-p
>
>--
>balbi
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

