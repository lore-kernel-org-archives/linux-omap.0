From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: ARM: add __always_inline to functions called from __get_user_check()
Date: Fri, 18 Oct 2019 12:06:23 +0200
Message-ID: <1823C41A-3296-4DEA-B71F-5AD548335F8B@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,
I wonder what happened to your patch. We were "hit" by it in v5.4-rc1 and
after finding, it made our OMAP based device bootable again (using our
own defconfig which optimizes for SIZE).

But it does not seem to have arrived in linux-next and should IMHO
be fixed during the v5.4 release candidate cycle.

BR and thanks,
Nikolaus Schaller
