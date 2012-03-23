From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/9] omap: fix visibility of omap2_mbox_iva_priv
Date: Fri, 23 Mar 2012 11:30:59 -0700
Message-ID: <20120323183057.GG9859@atomide.com>
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
 <1332522836-29517-3-git-send-email-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1332522836-29517-3-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

* mathieu.poirier@linaro.org <mathieu.poirier@linaro.org> [120323 10:16]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> map2_mbox_iva_priv is used on multiple omap2 socs but is hidden
> in an outdated #ifdef that is specific to a single soc.

I think this got fixed with 655850ed (ARM: OMAP2: fix mailbox init code).

Tony
