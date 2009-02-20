From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [pacth] I2C bug fixes for L-O and L-Z
Date: Fri, 20 Feb 2009 14:59:25 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE896716203772C3CAF@dlee02.ent.ti.com>
References: <1234767724.16827.7.camel@eenurkka-desktop>
	 <13B9B4C6EF24D648824FF11BE896716203771DC940@dlee02.ent.ti.com>
 <1234850560.13109.9.camel@eenurkka-desktop>
 <13B9B4C6EF24D648824FF11BE896716203771DD194@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48844 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbZBTU7i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 15:59:38 -0500
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203771DD194@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Eero,

> > From: Eero Nurkkala [mailto:ext-eero.nurkkala@nokia.com]
>
> > On Mon, 2009-02-16 at 15:19 +0100, ext Woodruff, Richard wrote:
> > > Hi,
> > >
> > > > Could you please also address the question of the load on the SCL line?
> > >
> > > Are you talking about rise/fall time?
> > >
> > Sorry for being unclear;
> >
> > The I2C standard addresses also rise/fall times, but more interesting,
> > the tLow and tHigh (and a number of other parameters).
> >
> > It seems with the open source drivers, that somehow they're after a
> > "balanced I2C clock" meaning tLow == tHigh, which is very, very
> > dangerous.
>
> Oh, I see. I didn't look at that angle. I can inquire/look.
>
> For sure wave forms on O-Scope and LA showed variable data line times,
> sometimes longer then one would expect (for stop/start/ack).  But yes, clocks
> were pretty even iirc.

I received the following comment from a HW Apps person whom has dealt with this at the board level.

<comment start>
Attached is the I2C spec that I have.  As I understand it, the I2C only specify the minimum tLow and tHigh (which is not "balanced").  However what is more important is that the appropriate setup and hold time are followed.

If the equal time still meets the setup/hold time then there should not be any issue from a compliance standpoint.
<comment end>

Regards,
Richard W.
