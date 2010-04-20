From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
Date: Tue, 20 Apr 2010 16:11:04 -0700
Message-ID: <871ve9d8jb.fsf@deeprootsystems.com>
References: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com>
	<i2x5d5443651004140034mdd11969cg72d4306c77f2bd0f@mail.gmail.com>
	<27F9C60D11D683428E133F85D2BB4A53043DA67699@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043DA67699@dlee03.ent.ti.com> (Abraham Arce's message of "Thu\, 15 Apr 2010 19\:04\:11 -0500")
Sender: linux-input-owner@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

"Arce, Abraham" <x0066660@ti.com> writes:

> Hi Trilok!
>
>> > =A0- matrix_keypac.c logic
>> > =A0- hwmod framework
>>=20
>> Do we have hwmod framework mainlined in the kernel?
>
> Not yet but wanted to gather initial comments to be ready once framew=
ork is pushed

Just to clarify, hwmod framework is already in mainline. =20

Only thing missing to test this driver is adding the hwmod data for
this device.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
