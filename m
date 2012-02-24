From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/3] tty: serial: OMAP: block idle while the UART is transferring
 data in PIO mode
Date: Fri, 24 Feb 2012 15:35:44 +0100
Message-ID: <4F47A040.6030502@ti.com>
References: <20120126024903.31613.24730.stgit@dusk> <20120126025036.31613.67819.stgit@dusk> <4F423E28.3040404@ti.com> <alpine.DEB.2.00.1202211456160.25023@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43815 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755050Ab2BXOf4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 09:35:56 -0500
In-Reply-To: <alpine.DEB.2.00.1202211456160.25023@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

Salut Paul,

On 2/21/2012 11:02 PM, Paul Walmsley wrote:
> Salut Beno=EEt,
>
> On Mon, 20 Feb 2012, Cousson, Benoit wrote:
>
>> 3.3-rc4 is broken in the DT case because of the serial driver. And i=
t
>> looks like it is due to this fix.  We cannot rely on pdata anymore i=
n
>> DT, and in that case it leads to an Oops due to NULL pdata.
>
> Sorry about the breakage.  I agree with the diagnosis.  That code was=
 just
> copied from the DMA errata part of the driver, so it will need to be =
fixed
> as well.  Otherwise the same problem will happen when DMA is enabled.
>
>> And then we will have to add the support for all these OMAP custom h=
ooks without pdata.
>
> That's really the key question for the medium- to long-term...

I know you know, I'm always hoping that someone will step up and propos=
e=20
some cool idea to fix that :-)

>> A basic fix (below) for the moment is to test for valid pdata inside=
 the driver.
>> I'll repost it properly if you are fine with it.
>
> Looks fine to me, although I'd suggest fixing the DMA workaround path=
 as
> well.

Mmm, I've tried to fix every instances of pdata in the code, you think =
I=20
missed some?

I'll check again.

> Reviewed-by: Paul Walmsley<paul@pwsan.com>

Thanks,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
