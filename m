From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2: Fix build when using split object directories
Date: Wed, 18 Apr 2018 10:09:03 -0700
Message-ID: <20180418170903.GG5671@atomide.com>
References: <20180411211543.7923-1-d-gerlach@ti.com>
 <20180412082157.GB4002@localhost.localdomain>
 <CAK7LNAQiq-4daX2K4dPyzN7zr+yfkQWSJ-yy9JHgacPpYFp94w@mail.gmail.com>
 <4343a047-18b1-409d-ccda-94e72ea63e2a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4343a047-18b1-409d-ccda-94e72ea63e2a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Anders Roxell <anders.roxell@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <michal.lkml@markovi.net>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [180413 14:08]:
> This is the version of this patch that we want to use, will this go through you?

Sorry for the delay, I just noticed this. Somehow I thought Santosh
would queue it, but as the regression was introduced by a commit in
my tree I'll pick this patch into omap-for-v4.17/fixes.

Thanks,

Tony
