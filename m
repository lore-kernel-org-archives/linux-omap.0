From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: dts: am4372: Add McASP nodes
Date: Tue, 22 Oct 2013 10:33:01 +0200
Message-ID: <5266383D.7090709@baylibre.com>
References: <1382348758-1083-1-git-send-email-peter.ujfalusi@ti.com> <526579FB.10005@cogentembedded.com> <52662D3B.5050204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52662D3B.5050204@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Jyri Sarha <jsarha@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 22/10/2013 09:46, Peter Ujfalusi wrote:
> Hi,
>
> On 10/21/2013 10:01 PM, Sergei Shtylyov wrote:
>
>>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am43=
72.dtsi
>>> index c328d5c..defaad1 100644
>>> --- a/arch/arm/boot/dts/am4372.dtsi
>>> +++ b/arch/arm/boot/dts/am4372.dtsi
>>> @@ -633,5 +633,32 @@
>>>                dma-names =3D "tx", "rx";
>>>            };
>>>
>>> +        mcasp0: mcasp@48038000 {
>>
>>     According to ePAPR spec [1], "the name of a node should be somew=
hat
>> generic, reflecting the function of the device and not its
>> precise programming model". In this case probably "sound"?
>
> We use the 'sound' node name for the sound card itself. The case with=
 McASP is
> a bit complicated. It can operate in I2S mode (and similar protocols =
like RJM,
> LJM, TDM) or it can interface with S/PDIF, IEC60958-1, AES-3 codecs.
> The mode we put McASP depends on the external components, so the same=
 McASP
> can be used in I2S mode in one board while on the other it can be S/P=
DIF.
> It would have been convenient if I could use 'i2s' as node name but i=
t is not
> true for McASP (Tegra, Exynos for example have I2S, AC97, S/PDIF as s=
eparate IP).
>
> IMHO the 'mcasp' is still the best node name for this IP. McASP stand=
s for:
> 'Multichannel Audio Serial Port' and this is pretty much what McASP i=
s.

Yes, I do agree, there are tons of nodes that cannot have generic name.=
=20
Moreover, we are already using that name in few OMAP dts, so for=20
consistency, let's keep that name.

Benoit

--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
