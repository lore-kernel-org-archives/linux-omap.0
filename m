From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [GIT PULL] hwspinlock: a single fix for 3.6
Date: Tue, 18 Sep 2012 09:55:40 +0300
Message-ID: <CAK=WgbbGk1L9Jmh=XUc9U_D0B_-xrr2pm1quDtBFcKo2gvOuYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Wei Yongjun <yongjun_wei@trendmicro.com.cn>
List-Id: linux-omap@vger.kernel.org

Hi Linus,

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/hwspinlock.git
tags/hwspinlock-3.6-fix

for you to fetch changes up to e352614cd3e7a5f7af7cff894a3b5a705181de21:

  hwspinlock/core: move the dereference below the NULL test
(2012-09-10 13:19:25 +0300)

----------------------------------------------------------------
A single hwspinlock fix by Wei Yongjun, which prevents potential
NULL dereferences.

----------------------------------------------------------------
Wei Yongjun (1):
      hwspinlock/core: move the dereference below the NULL test

 drivers/hwspinlock/hwspinlock_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
