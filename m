From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: dts: am4372: Add McASP nodes
Date: Tue, 22 Oct 2013 10:46:03 +0300
Message-ID: <52662D3B.5050204@ti.com>
References: <1382348758-1083-1-git-send-email-peter.ujfalusi@ti.com>
 <526579FB.10005@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <526579FB.10005@cogentembedded.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 10/21/2013 10:01 PM, Sergei Shtylyov wrote:

>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dt=
si
>> index c328d5c..defaad1 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -633,5 +633,32 @@
>>               dma-names =3D "tx", "rx";
>>           };
>>
>> +        mcasp0: mcasp@48038000 {
> =

>    According to ePAPR spec [1], "the name of a node should be somewhat
> generic, reflecting the function of the device and not its
> precise programming model". In this case probably "sound"?

We use the 'sound' node name for the sound card itself. The case with McASP=
 is
a bit complicated. It can operate in I2S mode (and similar protocols like R=
JM,
LJM, TDM) or it can interface with S/PDIF, IEC60958-1, AES-3 codecs.
The mode we put McASP depends on the external components, so the same McASP
can be used in I2S mode in one board while on the other it can be S/PDIF.
It would have been convenient if I could use 'i2s' as node name but it is n=
ot
true for McASP (Tegra, Exynos for example have I2S, AC97, S/PDIF as separat=
e IP).

IMHO the 'mcasp' is still the best node name for this IP. McASP stands for:
'Multichannel Audio Serial Port' and this is pretty much what McASP is.

-- =

P=E9ter
