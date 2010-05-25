From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC/PATCH 1/2] omap: mailbox: initial hwmod support
Date: Tue, 25 May 2010 09:08:54 -0700
Message-ID: <87hblwneuh.fsf@deeprootsystems.com>
References: <1274549122-26521-1-git-send-email-felipe.contreras@gmail.com>
	<1274549122-26521-2-git-send-email-felipe.contreras@gmail.com>
	<871vd0voiu.fsf@deeprootsystems.com>
	<AANLkTilI_Fqlz9Bj6WDxahheVODv-OZEQcacWw4dz6dV@mail.gmail.com>
	<87bpc4qbnb.fsf@deeprootsystems.com>
	<AANLkTikXZRPJIeZcnUBdegFTnHIOaXUL9Ukns45GO1bh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42993 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119Ab0EYQI6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 12:08:58 -0400
Received: by pwi2 with SMTP id 2so1119604pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 25 May 2010 09:08:57 -0700 (PDT)
In-Reply-To: <AANLkTikXZRPJIeZcnUBdegFTnHIOaXUL9Ukns45GO1bh@mail.gmail.com> (Felipe Contreras's message of "Tue\, 25 May 2010 18\:23\:48 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, May 25, 2010 at 5:49 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> On Tue, May 25, 2010 at 3:00 AM, Kevin Hilman
>>> <khilman@deeprootsystems.com> wrote:
>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>

[...]

>>>>> -static struct platform_device mbox_device =3D {
>>>>> - =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap-mailbox",
>>>>> - =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
>>>>> -};
>>>>> + =A0 =A0 pdata.base_addr =3D hwmod->_rt_va;
>>>>
>>>> Shouldn't need the base address in pdata. =A0The driver should jus=
t do a
>>>> platform_get_resource() to get the physical address and then iorem=
ap.
>>>
>>> But the hwmod code already did ioremap in _find_mpu_rt_base().
>>
>> Yes, but that's a hwmod-internal implementation detail that may
>> change, or may not be needed for some hwmods, or may be iounmapped
>> after hwmod init etc.
>
> So I have to do another ioremap()?

Yes.

But keep in mind that these L4 devices have static mappings, so there
really not an additional mapping created.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
