From: venki kaps <venkiece2005@gmail.com>
Subject: Re: OMAP3 DSP MMU fault + off mode issue
Date: Wed, 15 Sep 2010 21:12:36 +0530
Message-ID: <AANLkTi=oSTBhceK+oMKH8r9ybeMo4XYcQ+hYQOTRY94u@mail.gmail.com>
References: <AANLkTikHM+o_FCgnVzGhs8UtQ_geXFzKNQpGSZiEN7sx@mail.gmail.com>
	<AANLkTimd_sRpOYaurOT0iSbfd0pMZvhxgUcaqbQvSobu@mail.gmail.com>
	<AANLkTimO1UK+WA8Mc3Myi3gWBpD=D7tXDOX104a8NMKW@mail.gmail.com>
	<87mxrjgjre.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <87mxrjgjre.fsf@deeprootsystems.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: nm@ti.com, h-kanigeri2@ti.com, omar.ramirez@ti.com, ext-phil.2.carmody@nokia.com, ext-andriy.shevchenko@nokia.com, fernando.lugo@ti.com, ohad@wizery.com, ivan.gomez@ti.com, x0095078@ti.com, felipe.contreras@gmail.com, ernesto@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, x0hebbar@ti.com, devel@linuxdriverproject.org, grgupta@ti.com, s-anna@ti.com, ameya.palande@nokia.com, deepak.chitriki@ti.com
List-Id: linux-omap@vger.kernel.org

Venkii,
On Wed, Sep 15, 2010 at 8:02 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> venki kaps <venkiece2005@gmail.com> writes:
>
>> On Tue, Sep 14, 2010 at 8:54 PM, venki kaps <venkiece2005@gmail.com> wro=
te:
>>> On Tue, Sep 14, 2010 at 1:28 AM, venki kaps <venkiece2005@gmail.com> wr=
ote:
>>>> Dear all,
>>>>
>>>> I have been facing an issue with OMAP3 PM with DSP MMU Fault (Kernel 2=
.6.32).
>>>>
>>>> The issue is describing as below mentioned way,
>>>> =A0 =A0 =A0 =A01). The Device is getting DSP MMU Fault when playing MP=
4 video clip.
>>>>
>>>> The system is not hitting off mode in the below scenario,
>>>> =A0 =A0 =A0 =A02). System boot ->play mp4 clip ->DSP MMU Fault -> allo=
w off
>>>> mode -----------> Never hits off mode
>>>>
>>>> But surprisingly the system is hitting off mode in the below scenario,
>>>> =A0 =A0 =A0 3). System boot ->allow off mode ->play mp4 clip ->DSP MMU
>>>> Fault -> allow off mode -----------> perfectly works
>>>>
>>>>
>>>> =A0- Could you please describe the root cause about the above issues 1=
 & 2?
>>>> =A0- How could solve the above issues?
>>>
>>> I have found the issue with UART3.
>>> In System configuration register (SYSC),-
>>> =A0 =A0 =A0 =A0 =A0 =A0 IDLEMODE =A0- Smart idle -------> working scena=
rio =A0------>
>>> system hits off mode.
>>> =A0 =A0 =A0 =A0 =A0 =A0 IDLEMODE =A0- No idle -------> Non working scen=
ario
>>> ------> system never hits off mode.
>>>
>>> Could you please explain why UART3 is not able to hit smart idle after
>>> DSP MMU fault ( System boot ->play mp4 clip ->DSP MMU Fault -> allow
>>> off -----------> Never hits off mode).,
>>
>> My problem is resolved.GPtimer7 was not reset during the MMU FAULT
>> occurrence before the first power cycle.
>> So this pending interrupt is preventing the system sleep entry.
>> Now it works fine after resetting Gptimer7 in pm suspend path.
>
> Sounds like a patch is needed for DSPBridge who manages that timer.

Patchwork DSPBRIDGE: MMU-Fault debugging enhancements,
https://patchwork.kernel.org/patch/91577/
>From the above patch, please see the below comment
/*
 * Send a GP Timer interrupt to DSP
 * The DSP expects a GP timer interrupt after an
 * MMU-Fault Request GPTimer
 */

The above changes allow for DSP task information to be printed
by the MPU dspbridge when DSP MMU fault ocurrs.

This above changes will be required during development.
In my scenario, it is not required so i have just commented.

Index: android-2.6.32.9/drivers/dsp/bridge/wmd/ue_deh.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- android-2.6.32.9.orig/drivers/dsp/bridge/wmd/ue_deh.c
2010-08-24 18:19:19.000000000 +0900
+++ android-2.6.32.9/drivers/dsp/bridge/wmd/ue_deh.c    2010-09-16
00:28:52.000000000 +0900
@@ -285,7 +285,8 @@
                         * The DSP expects a GP timer interrupt after an
                         * MMU-Fault Request GPTimer
                         */
-                       if (timer) {
+                       if (0) {
                                omap_dm_timer_enable(timer);
                                /* Enable overflow interrupt */
                                omap_dm_timer_set_int_enable(timer,


> Kevin
>
