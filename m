From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH RFC] ARM: dts: am335x: update USB DT references
Date: Wed, 23 Apr 2014 17:40:32 +0200
Message-ID: <5357DEF0.7030000@baylibre.com>
References: <1397647595-10927-1-git-send-email-leigh@solinno.co.uk> <5356794C.7070707@baylibre.com> <20140423144822.GA4833@atomide.com> <20140423151734.GA5867@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:44925 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbaDWPkf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 11:40:35 -0400
Received: by mail-we0-f181.google.com with SMTP id q58so1001944wes.26
        for <linux-omap@vger.kernel.org>; Wed, 23 Apr 2014 08:40:34 -0700 (PDT)
In-Reply-To: <20140423151734.GA5867@arch.cereza>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tony Lindgren <tony@atomide.com>
Cc: Leigh Brown <leigh@solinno.co.uk>, Mugunthan V N <mugunthanvnm@ti.com>, devicetree@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Ezequiel,

On 23/04/2014 17:17, Ezequiel Garcia wrote:
> On Apr 23, Tony Lindgren wrote:
>> * Benoit Cousson <bcousson@baylibre.com> [140422 07:14]:
>>> Hi Leigh,
>>>
>>> On 16/04/2014 13:26, Leigh Brown wrote:
>>>> In "ARM: dts: am33xx: correcting dt node unit address for usb", th=
e
>>>> usb_ctrl_mod and cppi41dma nodes were updated with the correct reg=
ister
>>>> addresses.  However, the dts files that reference these nodes were=
 not
>>>> updated, and those devices are no longer being enabled.
>>>>
>>>> This patch corrects the references for the affected dts files.
>
> Maybe someone can take care of using phandles instead?
>
> This way, the board's dts files would be immune to such .dtsi changes=
=2E

Indeed, that will avoid such issues.

Are you volunteer for that cleanup ? :-)

Thanks,
Benoit


--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
