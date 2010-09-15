From: venki kaps <venkiece2005@gmail.com>
Subject: Re: OMAP3 DSP MMU fault + off mode issue
Date: Wed, 15 Sep 2010 21:33:52 +0530
Message-ID: <AANLkTi=wydMEm4=kEuxLvNMfAWE6kzAKQ4wBHKFfgXGZ@mail.gmail.com>
References: <AANLkTikHM+o_FCgnVzGhs8UtQ_geXFzKNQpGSZiEN7sx@mail.gmail.com>
	<AANLkTimd_sRpOYaurOT0iSbfd0pMZvhxgUcaqbQvSobu@mail.gmail.com>
	<AANLkTimO1UK+WA8Mc3Myi3gWBpD=D7tXDOX104a8NMKW@mail.gmail.com>
	<87mxrjgjre.fsf@deeprootsystems.com>
	<AANLkTi=oSTBhceK+oMKH8r9ybeMo4XYcQ+hYQOTRY94u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63280 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398Ab0IOQEO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 12:04:14 -0400
In-Reply-To: <AANLkTi=oSTBhceK+oMKH8r9ybeMo4XYcQ+hYQOTRY94u@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: omar.ramirez@ti.com, h-kanigeri2@ti.com, ameya.palande@nokia.com, fernando.lugo@ti.com, x0hebbar@ti.com, ernesto@ti.com, felipe.contreras@gmail.com, s-anna@ti.com, grgupta@ti.com, ivan.gomez@ti.com, ext-andriy.shevchenko@nokia.com, x0095078@ti.com, deepak.chitriki@ti.com, nm@ti.com, ext-phil.2.carmody@nokia.com, ohad@wizery.com, devel@linuxdriverproject.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Venkii,
On Wed, Sep 15, 2010 at 9:12 PM, venki kaps <venkiece2005@gmail.com> wr=
ote:
> Venkii,
> On Wed, Sep 15, 2010 at 8:02 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> venki kaps <venkiece2005@gmail.com> writes:
>>
>>> On Tue, Sep 14, 2010 at 8:54 PM, venki kaps <venkiece2005@gmail.com=
> wrote:
>>>> On Tue, Sep 14, 2010 at 1:28 AM, venki kaps <venkiece2005@gmail.co=
m> wrote:
>>>>> Dear all,
>>>>>
>>>>> I have been facing an issue with OMAP3 PM with DSP MMU Fault (Ker=
nel 2.6.32).
>>>>>
>>>>> The issue is describing as below mentioned way,
>>>>> =A0 =A0 =A0 =A01). The Device is getting DSP MMU Fault when playi=
ng MP4 video clip.
>>>>>
>>>>> The system is not hitting off mode in the below scenario,
>>>>> =A0 =A0 =A0 =A02). System boot ->play mp4 clip ->DSP MMU Fault ->=
 allow off
>>>>> mode -----------> Never hits off mode
>>>>>
>>>>> But surprisingly the system is hitting off mode in the below scen=
ario,
>>>>> =A0 =A0 =A0 3). System boot ->allow off mode ->play mp4 clip ->DS=
P MMU
>>>>> Fault -> allow off mode -----------> perfectly works
>>>>>
>>>>>
>>>>> =A0- Could you please describe the root cause about the above iss=
ues 1 & 2?
>>>>> =A0- How could solve the above issues?
>>>>
>>>> I have found the issue with UART3.
>>>> In System configuration register (SYSC),-
>>>> =A0 =A0 =A0 =A0 =A0 =A0 IDLEMODE =A0- Smart idle -------> working =
scenario =A0------>
>>>> system hits off mode.
>>>> =A0 =A0 =A0 =A0 =A0 =A0 IDLEMODE =A0- No idle -------> Non working=
 scenario
>>>> ------> system never hits off mode.
>>>>
>>>> Could you please explain why UART3 is not able to hit smart idle a=
fter
>>>> DSP MMU fault ( System boot ->play mp4 clip ->DSP MMU Fault -> all=
ow
>>>> off -----------> Never hits off mode).,
>>>
>>> My problem is resolved.GPtimer7 was not reset during the MMU FAULT
>>> occurrence before the first power cycle.
>>> So this pending interrupt is preventing the system sleep entry.
>>> Now it works fine after resetting Gptimer7 in pm suspend path.
>>
>> Sounds like a patch is needed for DSPBridge who manages that timer.
>
> Patchwork DSPBRIDGE: MMU-Fault debugging enhancements,
> https://patchwork.kernel.org/patch/91577/
> From the above patch, please see the below comment
> /*
> =A0* Send a GP Timer interrupt to DSP
> =A0* The DSP expects a GP timer interrupt after an
> =A0* MMU-Fault Request GPTimer
> =A0*/
>
> The above changes allow for DSP task information to be printed
> by the MPU dspbridge when DSP MMU fault ocurrs.
>
> This above changes will be required during development.
> In my scenario, it is not required so i have just commented.
>
> Index: android-2.6.32.9/drivers/dsp/bridge/wmd/ue_deh.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- android-2.6.32.9.orig/drivers/dsp/bridge/wmd/ue_deh.c
> 2010-08-24 18:19:19.000000000 +0900
> +++ android-2.6.32.9/drivers/dsp/bridge/wmd/ue_deh.c =A0 =A02010-09-1=
6
> 00:28:52.000000000 +0900
> @@ -285,7 +285,8 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * The DSP expects a G=
P timer interrupt after an
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * MMU-Fault Request G=
PTimer
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (timer) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_d=
m_timer_enable(timer);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Ena=
ble overflow interrupt */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_d=
m_timer_set_int_enable(timer,
>

In latest kernels (Eg, linux-2.6.36-rc3),The MMU-Fault debugging
enhancements code is moved under CONFIG_TIDSPBRIDGE_BACKTRACE.

>> Kevin
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
