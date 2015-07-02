From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM: DTS: am437x-sk-evm: Use simple-card for audio
 support
Date: Thu, 2 Jul 2015 15:55:13 +0300
Message-ID: <559534B1.5090301@ti.com>
References: <1435838286-30491-1-git-send-email-peter.ujfalusi@ti.com>
 <20150702121045.GC5837@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150702121045.GC5837-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/02/2015 03:10 PM, Felipe Balbi wrote:
> Hi,
>=20
> On Thu, Jul 02, 2015 at 02:58:04PM +0300, Peter Ujfalusi wrote:
>> Hi,
>>
>> There is no reason to use the davinci-evm machine driver's compatibl=
e for audio
>> support since the setup is simple and the common simple-audio-card c=
an handle it
>> just fine.
>> Also add McASP1 sleep pin configuration.
>>
>> Regards,
>> Peter
>> ---
>> Peter Ujfalusi (2):
>>   ARM: DTS: am437x-sk-evm: Add sleep pin settings for mcasp1
>>   ARM: DTS: am437x-sk-evm: Switch using simple-audio-card for audio
>>     support
>=20
> you should add a patch enabling CONFIG_SND_SIMPLE_CARD=3Dm in
> omap2plus_defconfig

Oh, true.
I'll then resend this as part of a bigger series (am335x-evmsk/evm,
am437x-gp/epos/sk).
I planned to send them as separate, but you are right, simple card need=
 to be
enabled first.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
