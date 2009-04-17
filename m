From: Artem Bityutskiy <dedekind@yandex.ru>
Subject: Re: [PATCH] OMAP3: lessen amount of noisy messages
Date: Fri, 17 Apr 2009 17:26:32 +0300
Message-ID: <49E89198.20200@yandex.ru>
References: <1239288072.3390.8.camel@localhost.localdomain>	<49E5D188.8060508@yandex.ru>	<alpine.DEB.2.00.0904150917520.3313@utopia.booyaka.com>	<1239810161.3390.190.camel@localhost.localdomain> <87myaf8kji.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19765 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbZDQO0q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 10:26:46 -0400
In-Reply-To: <87myaf8kji.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgen <tony@atomide.com>, linux-omap@vger.kernel.org

Kevin Hilman wrote:
> Artem Bityutskiy <dedekind@infradead.org> writes:
>=20
>> Hi,
>>
>> On Wed, 2009-04-15 at 09:22 -0600, Paul Walmsley wrote:
>>> stil thinking about it.  These messages have made it easy to catch =
bugs=20
>>> with the PM code in the past (e.g., sad2d).  Making them debug-leve=
l will=20
>>> require booting a kernel with clock debugging specifically=20
>>> compiled in.  So I wonder if there might be a better way to deal wi=
th=20
>>> these...
>> Yeah, I see your concern. I'm your user, and from my perspective thi=
s is
>> an excessive output to slow serial line.
>>
>> If you do not want re-compilation, I may send a different patch
>> like this:
>>
>> -	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
>> +	printk(KERN_DEBUG "Disabling unused clock \"%s\"\n", clk->name);
>>
>> in which case you would not loose the messages, but the messages
>> would not go to the serial line.
>>
>=20
> I prefer this method as well since i can see them simply by adding
> debug to the cmdline.
>=20

=46ine with me, thanks for looking at this.


--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
