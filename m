From: hong zhang <henryzhang62@yahoo.com>
Subject: Re: gpio interrupt is not invoked on Panda board
Date: Fri, 1 Jul 2011 16:15:42 -0700 (PDT)
Message-ID: <1309562142.93488.YahooMailClassic@web161708.mail.bf1.yahoo.com>
References: <4E0E3978.9050805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm30.bullet.mail.bf1.yahoo.com ([98.139.212.189]:20241 "HELO
	nm30.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758072Ab1GAXPn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 19:15:43 -0400
In-Reply-To: <4E0E3978.9050805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org

--- On Fri, 7/1/11, Jon Hunter <jon-hunter@ti.com> wrote:

> From: Jon Hunter <jon-hunter@ti.com>
> Subject: Re: gpio interrupt is not invoked on Panda board
> To: "hong zhang" <henryzhang62@yahoo.com>
> Cc: linux-omap@vger.kernel.org
> Date: Friday, July 1, 2011, 4:17 PM
> Hi Henry
>=20
> On 7/1/2011 1:10 PM, hong zhang wrote:
> > List,
> >
> > I try to get gpio_191 ping interrupted on panda but
> never succeeded. What I do is
> >
> > 1. set 0x410b on dpm_emu19 register to enable
> interrupt and wakeup
> >=A0 =A0=A0=A0on gpio_191
> > 2. set bit 31 to 1 on GPIO_IRQSTATUS_SET_0 register at
> 0x4805d034
> > 3. set bit 31 to 1 on GPIO_IRQWAKEN_0 register at
> 0x4805d044
> > 4. set bit 31 to 0 on GPIO_OE register at 0x4805d134
> (output)
> > 5. set bit 31 to 1 on GPIO_SETDATAOUT register at
> 0x4805d194
> >
> > Then I expect I should see interrupt on
> GPIO_IRQSTATUS_0 register at 0x4805d02c. But nothing happens
> for both output and input (put pin on ground or 1,8v).
>=20
> You will not get an interrupt if you are configuring the
> gpio as an=20
> output (GPIO_OE[31] =3D 0).
>=20
 Jon

GPIO_OE[31]=3D0 means output. I should get interrupt for output.
GPIO_OE[31]=3D1 means input, but I do not get interrupt too.

Do I miss anything here?=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
