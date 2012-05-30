From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 11/11] ARM: DT: Add support to system
 control module for OMAP4
Date: Wed, 30 May 2012 12:22:49 +0200
Message-ID: <4FC5F4F9.6020106@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-12-git-send-email-eduardo.valentin@ti.com>
	<4FC49BA5.5050008@dev.rtsoft.ru> <4FC5DC9F.7080104@ti.com>
	<4FC5E2EE.8030504@dev.rtsoft.ru> <4FC5E7DE.2060905@ti.com>
	<4FC5F3C3.2000309@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FC5F3C3.2000309@dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: balbi@ti.com, kishon@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 5/30/2012 12:17 PM, Konstantin Baydarov wrote:
>    Hi.
> On 05/30/2012 01:26 PM, Cousson, Benoit wrote:
>> On 5/30/2012 11:05 AM, Konstantin Baydarov wrote:
>>> On 05/30/2012 12:38 PM, Cousson, Benoit wrote:
>>>> On 5/29/2012 11:49 AM, Konstantin Baydarov wrote:
>>>>> Hi, Eduardo.
>>>>>
>>>>> On 05/25/2012 12:26 PM, Eduardo Valentin wrote:
>>>>>> This patch add device tree entries on OMAP4 based boards for
>>>>>> System Control Module (SCM).
>>
>> ...
>>
>>>>> I believe that CPU-specific bandgap definition should be moved to
>>>>> bard specific dts.
>>>>
>>>> Mmm, why, since it is CPU specific and not board specific. I has to
>>>> be in the SoC file.
>>> Speaking about omap4430 - omap4430 bandgap differs from omap4460, so
>>> if omap4430 bandgap support will be added to omap-bandgap driver the
>>> version of bandgap should specified in dts file. omap4.dtsi is a
>>> common for omap4 boards, that is why I'm suggesting to move bandgap
>>> description to probably board specific file.
>>
>> OK, I got your point, but in that case we could potentially define a omap4460.dtsi file.
>>
>>> Another solution is to
>>> determine bandgap type in driver probe function, but in that case
>>> "ti,omap4460-bandgap" in omap4.dtsi should be replaced to
>>> "ti,omap4-bandgap".
>>
>> Yes, this is the best solution, but that assume that we can identify the control module version from the HW, which is not necessarily true :-(
>>
>> The IP_REVISION (offset = 0) value are unfortunately not documented, so we should read it to check if they are different from omap4430 and 4460.
>>
>> The bitfield layout in that register is:
>>
>> IP_REV_MAJOR: 8..10
>> IP_REV_CUSTOM: 6..7
>> IP_REV_MINOR: 0..5
> Probably, cpu_is_omap443x() and cpu_is_omap446x() can be used in bandgap driver probe function. Actually many drivers use cpu_is_omap*():

No, we cannot, we are in the process of getting rid of that.
A driver should only focus on the IP version in theory. The CPU version 
is not the proper way of getting that. It will make the driver not 
scalable at all for future OMAP revision.

> drivers/mfd/omap-usb-host.c
> drivers/mfd/twl-core.c

Yeah, these are the ones that still need to be fixed...

Regards,
Benoit
