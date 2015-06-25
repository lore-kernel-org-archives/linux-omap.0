From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] ARM-OMAP2+: Deletion of unnecessary checks before two
 function calls
Date: Thu, 25 Jun 2015 13:33:39 +0200
Message-ID: <558BE713.1020409@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.so
 urceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jun 2015 13:24:35 +0200

Some functions which release a system resource tolerate the passing
of a null pointer. I do not see a need because of this fact
that a function caller repeats a corresponding check.

Markus Elfring (2):
  Delete a check before the function call "omap_device_delete"
  Delete a check before the function call "of_node_put"

 arch/arm/mach-omap2/omap_device.c | 3 +--
 arch/arm/mach-omap2/timer.c       | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.4.4
