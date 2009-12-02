From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] power_supply: Add driver for TWL4030/TPS65950 BCI charger
Date: Wed, 2 Dec 2009 22:38:31 +0200
Message-ID: <6ed0b2680912021238o29d7e773i9379369d7b277614@mail.gmail.com>
References: <1259333060-24277-1-git-send-email-notasas@gmail.com>
	 <012301ca71ed$449cb930$544ff780@am.dhcp.ti.com>
	 <20091130185813.GA32522@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:39304 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638AbZLBUi0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 15:38:26 -0500
In-Reply-To: <20091130185813.GA32522@oksana.dev.rtsoft.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: Madhusudhan <madhu.cr@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Mon, Nov 30, 2009 at 8:58 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Mon, Nov 30, 2009 at 12:45:20PM -0600, Madhusudhan wrote:
> [...]
>> > + =A0 case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> > + =A0 =A0 =A0 =A0 =A0 /* charging must be active for meaningful re=
sult */
>> > + =A0 =A0 =A0 =A0 =A0 if (!is_charging) {
>>
>> How about putting a kern_info here?
>
> It might be better to return -EINVAL.

That causes lots of warnings from power_supply core (driver failed to
report XXX property), Not sure what to do here, I'd prefer to keep
returning 0.

>
> Thanks!
>
> --
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
