From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [GIT PULL] OMAP4 coupled CPUidle support for v3.6
Date: Fri, 27 Jul 2012 23:36:24 +0200
Message-ID: <CAMQu2gw0Ff_PdOQJSHHUVureq32zNZW3qd=ucB4CGN+FK-sb-w@mail.gmail.com>
References: <87394enqz8.fsf@ti.com> <CAOesGMiTfW6Qz=z4FvG=SomCuKo3C8um1M=uXJV8ZAjeKhRoOg@mail.gmail.com>
 <CAMQu2gynmXqprXPctYHA-V6niE4QptJ_fQ8Fv7J5OAooK1A6wQ@mail.gmail.com>
 <CAMbhsRSdWpsYub+M9Li44cW1dc2wg76Q3njAxNK2vjC0_jOeJg@mail.gmail.com> <CAOesGMiVRR4F+zad1hKdX-ZuC79U_F5ASG3C52EyFUJpGQv2ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:38598 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751820Ab2G0Vgw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jul 2012 17:36:52 -0400
Received: by ghrr11 with SMTP id r11so3996858ghr.33
        for <linux-omap@vger.kernel.org>; Fri, 27 Jul 2012 14:36:44 -0700 (PDT)
In-Reply-To: <CAOesGMiVRR4F+zad1hKdX-ZuC79U_F5ASG3C52EyFUJpGQv2ow@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Colin Cross <ccross@android.com>, Kevin Hilman <khilman@ti.com>, arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Fri, Jul 27, 2012 at 10:22 PM, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Jul 26, 2012 at 11:44 PM, Colin Cross <ccross@android.com> wrote:
>> On Thu, Jul 26, 2012 at 11:34 PM, Shilimkar, Santosh
>> <santosh.shilimkar@ti.com> wrote:
>>> On Fri, Jul 27, 2012 at 2:19 AM, Olof Johansson <olof@lixom.net> wrote:
>>>> Kevin,
>>>>
>>>> On Thu, Jul 26, 2012 at 2:37 PM, Kevin Hilman <khilman@ti.com> wrote:
>>>>> Hi Arnd, Olof,
>>>>>
>>>>> I know it is late, but I'm really hoping this can still make it for
>>>>> v3.6, so consider this a [GIT PLEA].  ;)
>>>>
>>>> New features submitted halfway through the merge window? Yeah, that's late.
>>>>
>>>> I'll pull it in as late2/pm once the below is fixed, but I won't
>>>> promise we'll send it up.
>>>>
>>>>
>>>>> Kevin Hilman (1):
>>>>>       ARM: OMAP4: CPUidle: add synchronization for coupled idle states
>>>>>
>>>>> Santosh Shilimkar (3):
>>>>>       ARM: OMAP: timer: allow gp timer clock-event to be used on both cpus
>>>>>       ARM: OMAP4: CPUidle: Use coupled cpuidle states to implement SMP cpuidle.
>>>>>       ARM: OMAP4: CPUidle: Open broadcast clock-event device.
>>>>
>>>> This looks odd, Colin was author to the first of the commits
>>>> attributed to Santosh.
>>>>
>>> Not sure what you mean. These patches are written by me. Kevin, Collin helped
>>> in review. If you are referring to the {ARM: OMAP: timer: allow gp
>>> timer clock-event to be
>>> used on both cpus} which does have SOB from me and Colin. The very first version
>>> of this version I picked was from product tree in which it was
>>> commited on Coiln's name.
>>> Later I updated that forf the multi-omap and the new timer code and
>>> hence the update
>>> in Author.
>>
>> I have no problem with the authorship on these two patches.
>
> Santosh, Colin,
>
> Ok, fair enough -- I just want to make sure attribution happens
> appropriately, and it's a red flag when there's a S-o-b by someone not
> at your company before yours without explanation.
>
Sure. No problem with that.

Regards
Santosh
