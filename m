From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: omap5-uevm: remove always_on, boot_on from
 smps10_out1
Date: Fri, 11 Oct 2013 11:43:55 +0530
Message-ID: <52579723.6080209@ti.com>
References: <1381402195-29257-1-git-send-email-kishon@ti.com>
 <20131010141949.GA13277@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131010141949.GA13277@kahuna>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tony@atomide.com, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thursday 10 October 2013 07:49 PM, Nishanth Menon wrote:
> On 16:19-20131010, Kishon Vijay Abraham I wrote:
>> smps10 should be enabled only in the case of host mode. So stop
>> doing always_on, boot_on from smps10_out1. The driver will enable it in =
host
>> mode.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  arch/arm/boot/dts/omap5-uevm.dts |    2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-=
uevm.dts
>> index d784b3a..e06a04a 100644
>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>> @@ -334,8 +334,6 @@
>>  					regulator-name =3D "smps10_out1";
>>  					regulator-min-microvolt =3D <5000000>;
>>  					regulator-max-microvolt =3D <5000000>;
>> -					regulator-always-on;
>> -					regulator-boot-on;
>>  				};
>>  =

>>  				ldo1_reg: ldo1 {
>> -- =

> Always good to get rid of regulator-always-on. Thanks for it.
> =

> regulator-boot-on indicates that PMIC enables it by default as part of
> OTP or some internal behavior -> Looking at the measurements done on
> uEVM and OTP information -> regulator-boot-on should be kept here.

No. Actually I don=92t want PMIC to enable it by default. I want the palmas=
-usb
driver to handle it.
Enabling it by default makes palmas-usb to detect VBUS interrupt. This shou=
ld
ideally be detected only when you connect a host cable.
Btw I didn't exactly get why you want regulator-boot-on should be kept here.

Thanks
Kishon
