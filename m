From: =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>
Subject: Re: [PATCH] sound/tlv320dac33: Add device tree support
Date: Tue, 30 Jan 2018 10:11:02 +0100
Message-ID: <1141b126-b883-a246-85ad-c5a69acb90bb@gmail.com>
References: <20180129230539.GA18280@amd> <20180129232031.GA7695@lenoch>
 <20180129233301.GA18104@amd> <20180130083446.GA13498@lenoch>
 <20180130085314.GA4585@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180130085314.GA4585@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Ladislav Michl <ladis@linux-mips.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, bhumirks@gmail.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 01/30/2018 09:53 AM, Pavel Machek wrote:
> On Tue 2018-01-30 09:34:46, Ladislav Michl wrote:
>> On Tue, Jan 30, 2018 at 12:33:01AM +0100, Pavel Machek wrote:
>>> On Tue 2018-01-30 00:20:31, Ladislav Michl wrote:
>>>> On Tue, Jan 30, 2018 at 12:05:39AM +0100, Pavel Machek wrote:
>>>>>
>>>>> This adds device tree support to tlv320dac33.c.
>>>>>
>>>>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
>>>>> new file mode 100644
>>>>> index 0000000..6cbd311
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
>>>>> @@ -0,0 +1,32 @@
>>>>> +Texas Instruments - tlv320dac33 Codec module
>>>>> +
>>>>> +The tlv320dac33 serial control bus communicates through I2C protocols.
>>>>> +
>>>>> +Required properties:
>>>>> +
>>>>> +- compatible - "ti,tlv320dac33"
>>>>> +- reg - I2C slave address
>>>>> +
>>>>> +Optional properties:
>>>>> +
>>>>> +- power-gpios - gpio pin to power the device, active high
>>>>
>>>> While driver used gpio in platform data, isn't it more likely
>>>> regulator which powers device?
>>>
>>>                 power-gpios = <&gpio2 28 0>; /* gpio_60 */
>>>
>>> Looks like GPIO to me -- example is from Nokia N9. So this appears to
>>> be correct.
>>
>> Device datasheet doesn't list any pin which looks like "power-gpio"
>> http://www.ti.com/lit/ds/symlink/tlv320dac32.pdf
>> Unfortunately I do not know much about N9, but was able to find Nokia 5610
>> scheme to get clue how could be tlv320dac33 hardwired (see page 2):
>> http://mastermobile.spb.ru/service/nokia_5610_rm-242_service_schematics.pdf
>> Here AVDD is powered by LP3985 voltage regulator which is enabled using
>> VEN pin which might be connected to gpio. Or there could be completely
>> different voltage regulator with different controls. And since Linux
>> already has voltage regulator class, lets not limit ourselves to gpio
>> pins.
> 
> Well, notice I'm converting existing driver to device tree. And that
> one already has GPIO dependency. It is possible that more work needs
> to be done there, but that should not be a reason to delay this. Feel
> free to help.
> 
> 									Pavel
> 

According to N9 schematics
http://www.s-manuals.com/manuals/phone/nokia/nokia_n9_rm-696_service_schematics_v1.pdf
it's in fact GPIO pin that is connected to reset line (labeled
CODEC_RST). So calling it "power" might be misleading, but the driver
code is quite clear as it labels that GPIO as "tlv320dac33 reset"

Filip
