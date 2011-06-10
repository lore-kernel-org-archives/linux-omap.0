From: onlyfever <onlyfever@gmail.com>
Subject: Re: HELP:How to power down TWL5030 Voice/Bluetooth
	sidetone PGA?
Date: Fri, 10 Jun 2011 21:27:21 +0800
Message-ID: <BANLkTi=9sg-WL+OXeA4J9rcH7c6zg+R3Pw@mail.gmail.com>
References: <BANLkTik0mX5wSYNdBwhjxuaKa6908fmazQ@mail.gmail.com>
	<201106101048.45966.peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <201106101048.45966.peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

2011/6/10 P=E9ter Ujfalusi <peter.ujfalusi@ti.com>:
> On Thursday 09 June 2011 16:40:15 onlyfever wrote:
>> Hello,
>> I want to power down Voice/Bluetooth sidetone PGA of TWL5030.
>> I set the VSTPGA Register/BTSTPGA Register to 0x00,but it seems that
>> the Voice/Bluetooth sidetone PGA still work,
>> and even set VSTPGA/BTSTPGA to Mute,there still have sidetone come out.
>>
>> How can I power down Voice/Bluetooth sidetone PGA?
>> I don't need sidetone.
>
> Are you sure, that the sidetone is added by the VSTPGA/BTSTPGA?
> Could you check, if you accidentally left either the analog loopbacks ena=
bled
> (or digital loopbacks)?
> Check for these:
> Right1/2 Analog Loopback, Left1/2 Analog Loopback, Voice Analog Loopback,
> Left/Right/Voice Digital Loopback
>
> Could you describe your scenario (uplink, downlink routing, etc)?
>
> --
> P=E9ter
>

1. when use Headset:
uplink routing:HSMIC --> AVTXR2PGA & AVTXL2PGA --> VDXS & VDXM --> PCM_VDX
downlink routing:PCM_VDR --> VDR -->  VRXPGA Fine gain --> DAC voice
--> VDL_GAIN Analog PGA --> HSOL/HSOR

I check the loopbacks,it seems that all Loopbacks have been disabled.
bash-3.2# alsa_amixer |grep Loopback
Simple mixer control 'Left Digital Loopback',0
Simple mixer control 'Left1 Analog Loopback',0
Simple mixer control 'Left2 Analog Loopback',0
Simple mixer control 'Right Digital Loopback',0
Simple mixer control 'Right1 Analog Loopback',0
Simple mixer control 'Right2 Analog Loopback',0
Simple mixer control 'Voice Analog Loopback',0
Simple mixer control 'Voice Digital Loopback',0

The sidetone is become louder if I increase the VSTPGA,
and when I increase the VDL_GAIN Analog PGA,the sidetone is become louder t=
oo.
But the VRXPGA seems don't affect the sidetone,so I think VSTPGA cause
the sidetone.

2.when use Bluetooth:
uplink routing:BT_PCM_VDR --> BTTXPGA --> VDXM --> PCM_VDX
downlink routing:PCM_VDR --> VDR --> BTRXPGA --> BT_PCM_VDX

When use Bluetooth interface,I don't know if something else can cause
sidetone except BTSTPGA.

thanks!
