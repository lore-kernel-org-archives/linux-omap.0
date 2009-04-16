From: twebb <taliaferro62@gmail.com>
Subject: Re: ehci problem on OMAP35xx
Date: Thu, 16 Apr 2009 10:53:15 -0400
Message-ID: <dbdb2ea60904160753r6da23b3fw18d90d2f4e4a7b9@mail.gmail.com>
References: <dbdb2ea60904150904j232e2803wb1dc973d727b941c@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E739404280467EF@dbde02.ent.ti.com>
	 <FCCFB4CDC6E5564B9182F639FC35608702EAA6AC27@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:13631 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbZDPOxQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Apr 2009 10:53:16 -0400
Received: by yw-out-2324.google.com with SMTP id 5so343604ywb.1
        for <linux-omap@vger.kernel.org>; Thu, 16 Apr 2009 07:53:15 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702EAA6AC27@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Thu, Apr 16, 2009 at 9:41 AM, Pandita, Vikram <vikram.pandita@ti.com=
> wrote:
>
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vge=
r.kernel.org] On Behalf Of twebb
>>> Sent: Wednesday, April 15, 2009 9:35 PM
>>> To: linux-omap@vger.kernel.org Mailing List
>>> Subject: ehci problem on OMAP35xx
>>>
>>> I'm having issues getting USB up and going on HSUSB2/EHCI on
>>> OMAP35xx-based hardware (very similar to beagle board). =A0We're us=
ing
>>> an SMSC3317 connected to HSUSB2, and in turn, the 3317 is connected=
 to
>
> Does SMSC3317 support Input clocking mode for the 60Mhz ULPI clk?
>

Yes.  It's not described in the datasheet but SMSC has confirmed the
part will work in the mode where the clock is driven from OMAP to
xcvr.

Other suggestions?  One thing we're now seeing is very inconsistent
readback of transceiver registers when accessed via INSNREG05_ULPI.
Even readback of RO registers (like Vendor ID High) doesn't work
consistently.

twebb
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
