From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH] omap3: mux: add shorthands for OUTPUT_PULL{UP,DOWN}
Date: Mon, 30 Nov 2009 23:58:14 +0200
Message-ID: <f870da180911301358t239b1820ia7cdecf932d579d1@mail.gmail.com>
References: <cover.1259481545.git.mike@compulab.co.il>
	 <1b6ff0b31e4c22532659749282e0dcf4dccdf5e4.1259481545.git.mike@compulab.co.il>
	 <20091130211255.GZ4348@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:52420 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbZK3V6I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 16:58:08 -0500
Received: by iwn1 with SMTP id 1so2624910iwn.33
        for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 13:58:14 -0800 (PST)
In-Reply-To: <20091130211255.GZ4348@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org

On Mon, Nov 30, 2009 at 11:12 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * Mike Rapoport <mike@compulab.co.il> [091129 00:10]:
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> ---
>> =A0arch/arm/mach-omap2/mux.h | =A0 =A02 ++
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
>> index e09c5d2..02a1b53 100644
>> --- a/arch/arm/mach-omap2/mux.h
>> +++ b/arch/arm/mach-omap2/mux.h
>> @@ -37,6 +37,8 @@
>>
>> =A0/* Active pin states */
>> =A0#define OMAP_PIN_OUTPUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0
>> +#define OMAP_PIN_OUTPUT_PULLUP =A0 =A0 =A0 =A0 =A0 =A0 =A0 (OMAP_PU=
LL_ENA | OMAP_PULL_UP)
>> +#define OMAP_PIN_OUTPUT_PULLDOWN =A0 =A0 OMAP_PULL_ENA
>> =A0#define OMAP_PIN_INPUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 OMAP_INPUT_EN
>> =A0#define OMAP_PIN_INPUT_PULLUP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(OMA=
P_PULL_ENA | OMAP_INPUT_EN \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 | OMAP_PULL_UP)
>
> Hmm, isn't this same as configuring as GPIO with up or
> down value?
>
> Or is there's some need doing it with mux only? Like
> power savings?

This is intended for dedicated pins rather than GPIO. Actually, I've
met only one till now, the HSUSB0_STP.
If you define most of the mux configuration in the kernel you
eventually run into very long lines in the omap_board_mux array. So,
shortening at least some of them seems good idea to me.
Take a look at my second patch ([1]) for example of what I mean :)

[1] http://en.wikipedia.org/wiki/Wikipedia:Tools/Editing_tools
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
	Sincerely Yours,
		Mike.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
