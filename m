From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH v10 0/7] MFD: TWL4030: power script and workaround for
 erratum 27
Date: Thu, 2 Jun 2011 10:12:25 -0700
Message-ID: <BANLkTino_3MphLsfq8i=J65H7hEMR3HMNQ@mail.gmail.com>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
	<BANLkTinEmyxuNb9p=VNkeLM1zMcxqBiCzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64627 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab1FBRM0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 13:12:26 -0400
Received: by vws1 with SMTP id 1so779991vws.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 10:12:25 -0700 (PDT)
In-Reply-To: <BANLkTinEmyxuNb9p=VNkeLM1zMcxqBiCzA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@ti.com>

On Thu, Jun 2, 2011 at 8:36 AM, Steve Sakoman <sakoman@gmail.com> wrote=
:
> On Fri, May 6, 2011 at 6:17 AM, Lesly A M <leslyam@ti.com> wrote:
>> Patch series for TWL4030 power scripts for OMAP3 boards and
>> workaround for TWL erratum 27.
>>
>> Changes for implementing TWL4030 power scripts recommended by hardwa=
re team.
>> Introduced a new TWL4030 power script file, which can be used by dif=
ferent
>> OMAP3 board with the power companion chip TWL4030.
>>
>> Updated the changes for TWL4030 errata 27 & 28, and modified
>> the TWL4030 power script.
>> Workaround for TWL4030 erratum 27 is required for Si version less th=
an or
>> equal to TWL5030 ES1.1.
>>
>> TWL4030 script changes re-based on Kevin's PM tree in pm branch.
>>
>> This patch series have a dependency with the patch:
>> =A0 =A0 =A0 =A0http://www.spinics.net/lists/linux-omap/msg50547.html
>>
>> Changes in v7:
>> =A0 =A0 =A0 =A0changes to fix Nishanth Menon's comments
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i) Added the workaround for TWL4030 E=
rratum 27
>>
>> =A0 =A0 =A0 =A0split the first patch in v6
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i) =A0fix for twl4030 script load
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ii) correct the warning print during =
script loading
>>
>> =A0 =A0 =A0 =A0Added new patch files
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i) changing sys_off signal polarity
>>
>> Changes in v8:
>> =A0 =A0 =A0 =A0updated the change logs
>> =A0 =A0 =A0 =A0moving the TWL IDCODE checking to twl-core.c
>>
>> Changes in V9:
>> =A0 =A0 =A0 =A0changes to fix David Derrick's comments
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i) turn OFF the NRES_PWRON resource i=
n warm reset sequence
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ii) optimize the i2c writes during re=
source configuration
>>
>> Changes in V10:
>> =A0 =A0 =A0 =A0changes for Tony's comments
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i) making the TWL4030 power scripts l=
oadable module
>>
>> Since the voltage layer is evolving to a new design, the voltage dep=
endant
>> changes required for the TWL4030 script are not incorporated in the =
patch series.
>> So this TWL4030 script patch series can be tested with a separate pa=
tch for
>> voltage layer changes.
>>
>> =A0 =A0 =A0 =A0link: http://pastebin.mozilla.org/1219625
>>
>> This changes are tested on OMAP3430 & OMAP3630 SDP with off mode ena=
bled in suspend path.
>> =A0 =A0 =A0 =A0Tested with suspend/resume script, which will test sy=
stem suspend in a loop.
>> =A0 =A0 =A0 =A0Tested for more than 1000 iterations.
>> =A0 =A0 =A0 =A0Also tested the reboot with WRM_RST button & reboot c=
ommand.
>
> I've tested this series on Overo and it seems to have no effect.
>
> After 'echo mem > /sys/power/state' my system draws 53mA both with an=
d
> without the above patch set.
>
> Has anyone else confirmed these changes on a platform other than the =
SDP?

I suppose I should add my assumptions in testing:

- CONFIG_TWL4030_SCRIPT needs to be turned on in omap2plus_defconfig
- no board changes are required

Correct assumptions?

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
