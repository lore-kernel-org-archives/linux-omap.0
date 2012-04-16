From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [GIT PULL]: omap-serial updates for 3.4-rc
Date: Mon, 16 Apr 2012 16:10:29 +0530
Message-ID: <CAMrsUdJ9ehjC4-hChddQRnH0BtpFG3bVBTnm6zFZpU6F0za_bg@mail.gmail.com>
References: <1334052148-10385-1-git-send-email-govindraj.raja@ti.com>
 <CAMrsUdKDhuDLr2=0uiQtY=r4pvmJQo=pJgERRCXySLghO7yGXA@mail.gmail.com> <CAMrsUdJ7wzX+Hnx_wBWNnCQz__0sMw8ruFGVWH+x3NGWG0NVQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:56823 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752693Ab2DPKkw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 06:40:52 -0400
Received: by obbef5 with SMTP id ef5so7220390obb.38
        for <linux-omap@vger.kernel.org>; Mon, 16 Apr 2012 03:40:51 -0700 (PDT)
In-Reply-To: <CAMrsUdJ7wzX+Hnx_wBWNnCQz__0sMw8ruFGVWH+x3NGWG0NVQw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Balbi, Felipe" <balbi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On Mon, Apr 16, 2012 at 12:52 PM, Raja, Govindraj <govindraj.raja@ti.com> wrote:
> Hi Tony,
>
> On Tue, Apr 10, 2012 at 3:36 PM, Raja, Govindraj <govindraj.raja@ti.com> wrote:
>> CC'ing Linux-ARM
>>
>>
>> On Tue, Apr 10, 2012 at 3:32 PM, Govindraj.R <govindraj.raja@ti.com> wrote:
>>> Hi Tony,
>>>
>>> Please Pull the following omap uart changes.
>>> Changes basically involves getting rid of cpu checks
>>> for populating erratas and features and move the same
>>> from serial.c to omap-serial.c, MVR reg is used to find
>>> uart versions and errata flags are populated accordingly.
>
> here [1] is the updated pull request I have incorporated even the
> serial mux fixes done along with previous changes.
>

Updated request [1]

After adding Santosh's serial fix to use smartidle wakeup if available from
hwmod.

--
Thanks,
Govindraj.R

[1]:

The following changes since commit e816b57a337ea3b755de72bec38c10c864f23015:

  Linux 3.4-rc3 (2012-04-15 18:28:29 -0700)

are available in the git repository at:

  git://gitorious.org/linux-3-x/omap-serial.git for_3.4/uart_fixes

for you to fetch changes up to 381772fefe13e73fc3d01c462d401785767c3775:

  ARM: OMAP: serial: Fix the ocp smart idlemode handling bug
(2012-04-16 15:46:26 +0530)

----------------------------------------------------------------
Govindraj.R (5):
      OMAP2+: UART: Remove cpu checks for populating errata flags
      OMAP2+: UART: enable tx wakeup bit for wer reg
      OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap24xx
      OMAP2+: UART: Fix incorrect population of default uart pads
      OMAP2+: UART: Add mechanism to probe uart pins and configure rx wakeup

Santosh Shilimkar (1):
      ARM: OMAP: serial: Fix the ocp smart idlemode handling bug

 arch/arm/mach-omap2/mux.c                     |    3 +-
 arch/arm/mach-omap2/mux.h                     |   10 ++
 arch/arm/mach-omap2/serial.c                  |  198 +++++++++----------------
 arch/arm/plat-omap/include/plat/omap-serial.h |    9 +-
 drivers/tty/serial/omap-serial.c              |   83 ++++++++++-
 5 files changed, 172 insertions(+), 131 deletions(-)
