From: Vovan <vovan888@gmail.com>
Subject: Re: [PATCH 5/5] Add gsm phone support for the mixer in tsc2101 alsa
	driver.
Date: Mon, 25 Sep 2006 21:19:24 +0400
Message-ID: <op.tgf2em02dbah4f@vovan>
References: <44E51565.6020505@cc.jyu.fi> <20060905151808.GC18073@atomide.com>
	<44FF2A6D.3000500@cc.jyu.fi>
	<ce55079f0609250442x5638a93fuac95c65a54a0927@mail.gmail.com>
	<4517FFF4.8060501@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4517FFF4.8060501@cc.jyu.fi>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lamikr@cc.jyu.fi
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

25.09.06 =E2 20:12 lamikr wrote:

> Vladimir wrote:
>>> 1) As we do not yet have any kind of multiplexing support to gsm modu=
le
>>> (currently directly accesing dev/ttyS1 for at commands)
>>> our phone app is not able to run simultaneously with the ppp. I am no=
t
>>> sure should I resolve this in the kernel space or user space.
>>>
>>
>> I work on getting linux running on Siemens SX1 mobile phone.
>> and I use GSM multiplexer daemon from here -
>> http://developer.berlios.de/projects/gsmmux/
>> it works fine for me.
> Have you tried to use pppd over that?

No, I havn`t tried pppd yet. I am still implementing IPC protocols with =20
modem that control sound,battery etc.
But sending plain AT commands works fine.

> Currently the userspace apps are not in handy enought shape and we need
> for example to close the phone app
> (http://xanadux.cvs.sourceforge.net/xanadux/gomunicator/)
> before establishing gprs connection with pppd.
> (http://www.handhelds.org/moin/moin.cgi/hpipaqh6300gprs)

I am still far from such userspace support :)

>
> Mika
>
>
