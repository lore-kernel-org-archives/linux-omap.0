From: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/9] ARM: dts/OMAP: Pinmux audio configuration for OMAP4+
Date: Mon, 08 Oct 2012 11:00:30 +0300
Message-ID: <5072881E.2040009@ti.com>
References: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com> <20121005230354.GS3874@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:41894 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751113Ab2JHH7G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 03:59:06 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3443645obb.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Oct 2012 00:59:05 -0700 (PDT)
In-Reply-To: <20121005230354.GS3874@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 10/06/2012 02:03 AM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [121004 04:57]:
>> Hello,
>>
>> u-boot recently stopped configuring 'non essential' pin mux. This ch=
ange leaves
>> the audio essential pins in non configured state which prevents the =
use of audio.
>> The following series makes sure that the needed pins are configured =
correctly by
>> the kernel on OMAP4 and OMAP5.
>>
>> Tony: can this series queued for 3.7?
>=20
> Let's see if that's possible to avoid mysterious bug reports
> of things not working.
>=20
> If we can't merge it, then it might be worth adding a warning
> that bails out early after some pin is checked or similar.

With new enough u-boot the twl6040 fails to probe (mux for nirq2 and po=
wer
GPIO is not configured) which leads to no audio on OMAP4/5.
Adding another warning - and check - does not going to help to clarify =
the
situation IMHO.
We can still enable the CONFIG_SYS_ENABLE_PADS_ALL in u-boot and recomp=
ile it,
but this is disabled as default and to be frank there is no guaranty th=
at this
is going to be available let's say next week.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
