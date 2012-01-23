From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 1/5] OMAP4: hwmod: Add names for DMIC memory address
 space
Date: Mon, 23 Jan 2012 13:52:35 +0200
Message-ID: <4F1D4A03.3050700@ti.com>
References: <1322487943-14280-1-git-send-email-peter.ujfalusi@ti.com> <1322487943-14280-2-git-send-email-peter.ujfalusi@ti.com> <alpine.DEB.2.00.1112152327410.12660@utopia.booyaka.com> <4EEB5913.3090901@ti.com> <alpine.DEB.2.00.1112191451140.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:42917 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753194Ab2AWLwm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 06:52:42 -0500
Received: by mail-gy0-f182.google.com with SMTP id 10so1182250ghy.13
        for <linux-omap@vger.kernel.org>; Mon, 23 Jan 2012 03:52:41 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1112191451140.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

Hi Paul, Tony,

On 12/19/2011 11:51 PM, Paul Walmsley wrote:
> Hi
>=20
> On Fri, 16 Dec 2011, Cousson, Benoit wrote:
>=20
>> On 12/16/2011 7:28 AM, Paul Walmsley wrote:
>>> On Mon, 28 Nov 2011, Peter Ujfalusi wrote:
>>>
>>>> To be able to get the memory resources by name from
>>>> the DMIC driver (for MPU and for DMA).
>>>
>>> Any comments on this one?  Looks like we'd need to add these names =
as
>>> hints in the script.
>>
>> Maybe not, in theory we should be able to detect the dual mapping an=
d add the
>> proper name. I did that for some other IP in the ABE domain, so it s=
hould be
>> doable for that one too.
>>
>>>> Signed-off-by: Peter Ujfalusi<peter.ujfalusi@ti.com>
>>
>> Acked-by: Benoit Cousson <b-cousson@ti.com>
>=20
> Cool.  Queued for when Tony wants to pull it.

This patch seams to be missing from 3.3-rc1. The rest of the series is
there, but because of the missing patch audio does not probe on
4430SDP/Blaze.
Can you queue this as a fix for Linus?

Thanks,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
