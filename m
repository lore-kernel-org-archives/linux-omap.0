From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and
 G121X1-L01 LCD displays
Date: Tue, 31 Jul 2012 23:44:00 +0530
Message-ID: <CAJe_Zhdr9dEXFZJRdS1WU=vH9r+n6ri+a+jgOsyXe9Ysem+tYw@mail.gmail.com>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com>
	<CAJe_ZhfoYoFd1AkFmb0E7=iSvZeAQRmSFONCW7jE8psCMDQ3Hg@mail.gmail.com>
	<1343721101.4685.35.camel@lappyti>
	<CAJe_Zheg_fpnRb+eLt5SQioSUXp=PFcPz-vWC-RL3_Mh35VBdA@mail.gmail.com>
	<1343722450.4685.37.camel@lappyti>
	<CAJe_Zhd4ubkfMRmVNt734N0Sc3+7OfXrgSPq-fUSH+uQfQ5RzA@mail.gmail.com>
	<1343724140.2633.20.camel@deskari>
	<CAJe_ZhfN1OEVq-MFdupZLjgc-LQBRred=L1o6wkd0FEDoSGUMA@mail.gmail.com>
	<1343728654.4685.68.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:60477 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085Ab2GaSOC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jul 2012 14:14:02 -0400
Received: by vcbfk26 with SMTP id fk26so6133213vcb.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 11:14:00 -0700 (PDT)
In-Reply-To: <1343728654.4685.68.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Raphael Assenat <raph@8d.com>, linux-omap@vger.kernel.org, Archit Taneja <a0393947@ti.com>

On 31 July 2012 15:27, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Tue, 2012-07-31 at 14:27 +0530, Jassi Brar wrote:
>> On 31 July 2012 14:12, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> > On Tue, 2012-07-31 at 13:57 +0530, Jassi Brar wrote:
>> >> On 31 July 2012 13:44, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> >> > On Tue, 2012-07-31 at 13:33 +0530, Jassi Brar wrote:
>> >> >> On 31 July 2012 13:21, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> >> >>
>> >> >> > 2) Have the configuration for countless panels specified in the DT data
>> >> >> >
>> >> >> Why should a DT blob for a board contain more than 1 panel configuration?
>> >> >
>> >> > I meant the DT data generally, for all boards.
>> >> >
>> >> If you mean : Why have the configuration (those 15 integers) of the
>> >> panel on a board specified in board.dtb?
>> >> Well, that is an important purpose of DT - moving board specific
>> >> parameters, on which a generic code works, out of kernel (I am
>> >> refraining from preaching the goodness of that).
>> >
>> > Sure. But panel's unconfigurable properties are not board specific
>> > parameters, they are panel's internal stuff. It doesn't matter to which
>> > board I attach Acme Foo-123 panel, the panel timings are still the same.
>> >
>> It's not about the panel, it's about the board. For the generic driver
>> in the kernel , the 'panel' is just a set of 15 integer values.
>> There's no "Acme Foo-123" or "Acme Bar-123".  In fact, the _only_
>> purpose of the panel's name string in the driver is to pick the
>> correct set of "15 integers". With DT, the name string would be
>> unnecessary.
>
> Yes, the panel's name is used to "probe" the correct config. If we had
> panels that could be asked "which panel are you" we could use that, but
> with dummy panels we need to manually give the identifier (name) so that
> the driver can do the probe.
>
>> Consider two panels "ABC_123" and "XYZ_321" having identical
>> parameters but different internals.
>> Would you have duplicate elements in the generic_dpi_panels[] array ?
>> Because the 'panels' are different.
>> Or would you simply assume the XYZ_Board has the panel 'ABC_123'?
>> Because after all it's the parameters that matter.
>
> I would duplicate the elements. Or, if we have lots of panels having the
> exact same parameters, we could have an array of names instead of just a
> name.
>
>> In short, we should see a 'panel' simply as a set of 15 integers.
>
> Ok, I see. You mean that the 15 integers define the panel, so, in a
> sense, the 15 integers is the name/identifier for the panel.
>
> It would technically work, of course. But I do disagree with it:
>
> 1) I still don't see why you say it's board related. The properties in
> question are properties of the panel, told in the panel specs, and
> programmed when using the panel. No matter where the panel is used, the
> same properties should be used.
>
> 2) As I see it, describing non-configurable device hardware properties
> in the DT data is the wrong way. The driver should either probe the
> properties or an ID from the device, or the ID of the device should be
> given to the driver (a bit like what can be done with i2c).
>
> 3) Moving the data to DT would make any future changes more difficult.
> Say, we could (probably should) add some regulator handling to the
> driver, because usually panels need power to operate. Currently we just
> presume the powers are always on.
>
> Adding this is easy with the current approach. Adding it if the data is
> in DT would be difficult, if not impossible, as all the board out there
> could already be using the old DT format which doesn't have the
> regulator data. Even in the best case all the boards out there would not
> be able to use the regulator stuff.
>
>
> Academic issues aside, what is the issue with the current approach in
> practice? How would the DT approach make it better? Both approaches work
> just fine, afaik. The current approach requires some maintenance from
> me, but that's rather minor.
>
> Anyway, even if I don't see the point, I'm not strictly against your
> approach. If everybody thinks it's much better, it's fine for me.
>
No, I don't insist. Its only I in 'everybody' here, so please do it
only if you see any merit in passing panel parameters via DT. I only
wanted to share my opinion and so I did.

Best Regards.
-jassi
