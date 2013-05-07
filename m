From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [GIT PULL] hwspinlock for 3.10
Date: Tue, 7 May 2013 15:04:27 +0300
Message-ID: <CAK=WgbbLUya4MQeh3h6v3a8LcTryJ8H4P7uLK3u9vKBvQey=ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?ISO-8859-1?Q?Vincent_Stehl=E9?= <v-stehle@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b=
6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/hwspinlock.git
tags/hwspinlock-3.10

for you to fetch changes up to 8ae053d62e88c400330ebaf27558bf02dde5a1fa=
:

  hwspinlock/omap: support OMAP5 as well (2013-04-05 09:11:17 +0300)

----------------------------------------------------------------
A single patch from Vincent extending OMAP's hwspinlock support to OMAP=
5.

----------------------------------------------------------------
Vincent Stehl=E9 (1):
      hwspinlock/omap: support OMAP5 as well

 drivers/hwspinlock/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
