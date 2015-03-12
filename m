From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: ti,codec property in sound/soc/omap/omap-twl4030.c not used
Date: Thu, 12 Mar 2015 10:27:48 +0100
Message-ID: <CAAfyv348NDvuXARXCfuTqUnHnBZUfNQ9L=k9c3xLV22CJHAKfw@mail.gmail.com>
References: <CAAfyv34ebp1oL7t9GKT20_c4VYMM=3rfJTrj-MfT6NUBXk6d2A@mail.gmail.com>
	<55015A0A.1060309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43150 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbbCLJ1u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2015 05:27:50 -0400
Received: by widem10 with SMTP id em10so18600124wid.2
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2015 02:27:48 -0700 (PDT)
In-Reply-To: <55015A0A.1060309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: jarkko.nikula@bitmer.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, alsa-devel@alsa-project.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>

Hi,

On Thu, Mar 12, 2015 at 10:19 AM, Peter Ujfalusi <peter.ujfalusi@ti.com=
> wrote:
> On 03/12/2015 12:12 AM, Belisko Marek wrote:
>> Hi,
>>
>> I'm looking at sources for omap-twl4030.c driver which is used by ma=
ny
>> boards. In DT bindings documentation is property ti,codec described =
as
>> mandatory but it's never parsed in driver code. I did small experime=
nt
>> in gta04 board and remove ti,codec from devicetree and sound was
>> working. I think it can be removed from documentation and also from
>> various device trees. Is my assumption correct? Thanks.
>
> Correct. The ti,twl4030-audio is for the MFD driver and the device fo=
r the
> ASoC codec is created in there w/o actual DT compatible string. The a=
udio part
> of the twl4030 is responsible for the audio and the vibra functionali=
ty.
Thanks for reply.
>
> Are you going to send the patches?
Yes will do.
>
> Thanks,
> P=C3=A9ter

BR,

marek



--=20
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
=46reelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
