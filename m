From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 11/11] ARM: DT: Add support to system
 control module for OMAP4
Date: Thu, 31 May 2012 14:52:34 +0200
Message-ID: <4FC76992.1040407@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-12-git-send-email-eduardo.valentin@ti.com>
	<4FC49BA5.5050008@dev.rtsoft.ru> <4FC5DC9F.7080104@ti.com>
	<4FC5E2EE.8030504@dev.rtsoft.ru> <4FC5E7DE.2060905@ti.com>
	<4FC75EA8.6090406@dev.rtsoft.ru> <20120531124958.GD3673@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120531124958.GD3673@besouro>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: eduardo.valentin@ti.com
Cc: amit.kucheria@linaro.org, balbi@ti.com, kishon@ti.com, Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 5/31/2012 2:49 PM, Eduardo Valentin wrote:
> Hello,
>
> On Thu, May 31, 2012 at 04:06:00PM +0400, Konstantin Baydarov wrote:
>>    Hi.
>>
>> On 05/30/2012 01:26 PM, Cousson, Benoit wrote:
>>> On 5/30/2012 11:05 AM, Konstantin Baydarov wrote:
>>>> On 05/30/2012 12:38 PM, Cousson, Benoit wrote:
>>>>> On 5/29/2012 11:49 AM, Konstantin Baydarov wrote:
>>>>>> Hi, Eduardo.
>>>>>>
>>>>>> On 05/25/2012 12:26 PM, Eduardo Valentin wrote:
>>>>>>> This patch add device tree entries on OMAP4 based boards for
>>>>>>> System Control Module (SCM).
>>>
>>> ...
>>>
>>>>>> I believe that CPU-specific bandgap definition should be moved to
>>>>>> bard specific dts.
>>>>>
>>>>> Mmm, why, since it is CPU specific and not board specific. I has to
>>>>> be in the SoC file.
>>>> Speaking about omap4430 - omap4430 bandgap differs from omap4460, so
>>>> if omap4430 bandgap support will be added to omap-bandgap driver the
>>>> version of bandgap should specified in dts file. omap4.dtsi is a
>>>> common for omap4 boards, that is why I'm suggesting to move bandgap
>>>> description to probably board specific file.
>>>
>>> OK, I got your point, but in that case we could potentially define a omap4460.dtsi file.
>>>
>>>> Another solution is to
>>>> determine bandgap type in driver probe function, but in that case
>>>> "ti,omap4460-bandgap" in omap4.dtsi should be replaced to
>>>> "ti,omap4-bandgap".
>>>
>>> Yes, this is the best solution, but that assume that we can identify the control module version from the HW, which is not necessarily true :-(
>>>
>>> The IP_REVISION (offset = 0) value are unfortunately not documented, so we should read it to check if they are different from omap4430 and 4460.
>>>
>>> The bitfield layout in that register is:
>>>
>>> IP_REV_MAJOR: 8..10
>>> IP_REV_CUSTOM: 6..7
>>> IP_REV_MINOR: 0..5
>> The value of CONTROL_GEN_CORE_REVISION register on my panda board(4430) is:
>> CONTROL_GEN_CORE_REVISION: 0x40000900
>> CONTROL_GEN_CORE_HWINFO:  0x0
>>
>>    Eduardo, could you check CONTROL_GEN_CORE_REVISION on your 4460 board.
>
> 4460:
> [root@(none) ~]# omapconf read 0x4A002000
> 40000A00
> [root@(none) ~]# omapconf read 0x4A002004
> 00000000
>
> 4470:
> [root@(none) ~]# omapconf read 0x4A002000
> 40000B00
> [root@(none) ~]# omapconf read 0x4A002004
> 00000000

Nice! We do have a cool progression 1 -> 2 -> 3 for each revision.
Well at least for the SCM.

Benoit
