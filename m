From: =?UTF-8?Q?Ezequiel_Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH for v3.15] usb: musb: Fix panic upon musb_am335x module removal
Date: Mon, 23 Jun 2014 15:29:07 -0300
Message-ID: <CAAEAJfAH6V9BQH2adJq-FKAYrcDrw4x5Uc7S0nudL7cuJZzD0w@mail.gmail.com>
References: <1400371473-2053-1-git-send-email-ezequiel@vanguardiasur.com.ar>
	<20140520165510.GA28859@arch.cereza>
	<20140614125902.GA1202@arch.cereza>
	<20140623182300.GC5073@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20140623182300.GC5073@saruman.home>
Sender: stable-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Guido_Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>, George Cherian <george.cherian@ti.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 23 June 2014 15:23, Felipe Balbi <balbi@ti.com> wrote:

>>
>> Any comments on this? I don't like to remove a feature, but as
>> explained above, I don't see any other way to solve this.
>>
>> The driver is currently broken. I tried using of_platform_depopulate=
()
>> but failed.
>
> yeah, I know about the problem and, frankly, there's no other way to =
fix
> this. Just resend with linux-usb in Cc.
>

Ouch, forgot about linux-usb on this one! I'm resending on top of
v3.16-rc1 (although I think this one already applies).

Thanks for the feedback,
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
