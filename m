From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and
 G121X1-L01 LCD displays
Date: Tue, 31 Jul 2012 14:27:17 +0530
Message-ID: <CAJe_ZhfN1OEVq-MFdupZLjgc-LQBRred=L1o6wkd0FEDoSGUMA@mail.gmail.com>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com>
	<CAJe_ZhfoYoFd1AkFmb0E7=iSvZeAQRmSFONCW7jE8psCMDQ3Hg@mail.gmail.com>
	<1343721101.4685.35.camel@lappyti>
	<CAJe_Zheg_fpnRb+eLt5SQioSUXp=PFcPz-vWC-RL3_Mh35VBdA@mail.gmail.com>
	<1343722450.4685.37.camel@lappyti>
	<CAJe_Zhd4ubkfMRmVNt734N0Sc3+7OfXrgSPq-fUSH+uQfQ5RzA@mail.gmail.com>
	<1343724140.2633.20.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:38590 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814Ab2GaI5S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jul 2012 04:57:18 -0400
Received: by vcbfk26 with SMTP id fk26so5568960vcb.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 01:57:17 -0700 (PDT)
In-Reply-To: <1343724140.2633.20.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Raphael Assenat <raph@8d.com>, linux-omap@vger.kernel.org, Archit Taneja <a0393947@ti.com>

On 31 July 2012 14:12, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Tue, 2012-07-31 at 13:57 +0530, Jassi Brar wrote:
>> On 31 July 2012 13:44, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> > On Tue, 2012-07-31 at 13:33 +0530, Jassi Brar wrote:
>> >> On 31 July 2012 13:21, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> >>
>> >> > 2) Have the configuration for countless panels specified in the DT data
>> >> >
>> >> Why should a DT blob for a board contain more than 1 panel configuration?
>> >
>> > I meant the DT data generally, for all boards.
>> >
>> If you mean : Why have the configuration (those 15 integers) of the
>> panel on a board specified in board.dtb?
>> Well, that is an important purpose of DT - moving board specific
>> parameters, on which a generic code works, out of kernel (I am
>> refraining from preaching the goodness of that).
>
> Sure. But panel's unconfigurable properties are not board specific
> parameters, they are panel's internal stuff. It doesn't matter to which
> board I attach Acme Foo-123 panel, the panel timings are still the same.
>
It's not about the panel, it's about the board. For the generic driver
in the kernel , the 'panel' is just a set of 15 integer values.
There's no "Acme Foo-123" or "Acme Bar-123".  In fact, the _only_
purpose of the panel's name string in the driver is to pick the
correct set of "15 integers". With DT, the name string would be
unnecessary.

Consider two panels "ABC_123" and "XYZ_321" having identical
parameters but different internals.
Would you have duplicate elements in the generic_dpi_panels[] array ?
Because the 'panels' are different.
Or would you simply assume the XYZ_Board has the panel 'ABC_123'?
Because after all it's the parameters that matter.

In short, we should see a 'panel' simply as a set of 15 integers.
