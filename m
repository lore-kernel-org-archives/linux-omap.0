From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: palmas: Add support for optional wakeup
Date: Tue, 2 Sep 2014 08:28:46 +0100
Message-ID: <20140902072846.GC17117@lee--X1>
References: <1408457197-30487-1-git-send-email-nm@ti.com>
 <20140829105619.GH24579@lee--X1>
 <54007515.5080506@ti.com>
 <20140901093206.GJ7374@lee--X1>
 <5404BB31.3060001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:47179 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbaIBH2x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2014 03:28:53 -0400
Received: by mail-ie0-f181.google.com with SMTP id rp18so6873286iec.26
        for <linux-omap@vger.kernel.org>; Tue, 02 Sep 2014 00:28:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5404BB31.3060001@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@linaro.org>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 01 Sep 2014, Nishanth Menon wrote:

> On 09/01/2014 04:32 AM, Lee Jones wrote:
> >On Fri, 29 Aug 2014, Nishanth Menon wrote:
> >>On 08/29/2014 05:56 AM, Lee Jones wrote:
> >>>On Tue, 19 Aug 2014, Nishanth Menon wrote:
> >>>
> >>>>With the recent pinctrl-single changes, omaps can treat wake-up e=
vents
> >>>>from deeper idle states as interrupts.
> >>>>
> >>>>Let's add support for the optional second interrupt for wake-up
> >>>>events. And then SoC can wakeup and handle the event using it's
> >>>>regular handler.
> >>>>
> >>>>Finally, to pass the wake-up interrupt in the dts file,
> >>>>interrupts-extended property needs to be passed.
> >>>>
> >>>>This is similar in approach to commit 2a0b965cfb6e ("serial: omap=
: Add
> >>>>support for optional wake-up")
> >>>>
> >>>>Signed-off-by: Nishanth Menon <nm@ti.com>
> >>>>---
> >>>>  Documentation/devicetree/bindings/mfd/palmas.txt |   20 +++++++=
+
> >>>
> >>>DT Ack please.
> >
> >Please read Documentation/devicetree/bindings/submittingpatches.txt
>=20
> I assume you wanted me to note the following:
> "
> The Documentation/ portion of the patch should be a separate patch.
> "
>=20
> Many maintainers prefer that when the bindings for the device is
> new, and when additional properties are added, they prefer it part
> of same patch.. Anyways.. if the above is what you prefer, I can
> follow that.

I tend to like it done properly please.

> In short, I assume you'd like three patches:
> a) fix up style of current documentation - palmas to palmas@40
> b) Split documentation for interrupt-extended from the current patch
> into it's own patch.
> c) remainder of this patch as is..
>=20
> Does that sound right?

That does, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
