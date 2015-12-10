From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] pinctrl:Convert the composition of
 devm_request_mem_region and devm_ioremap to a single call
Date: Thu, 10 Dec 2015 14:31:42 -0800
Message-ID: <20151210223142.GH23396@atomide.com>
References: <1446191478-22714-1-git-send-email-sanjeev_sharma@mentor.com>
 <CACRpkdZFhseQDbXvJg1CP3+WRsw_dPivx0w8730-9FV3fwjUGQ@mail.gmail.com>
 <20151203214415.GC23396@atomide.com>
 <CACRpkdZFw=tbRmh1_qUeRvVKokMqYd35FEO+NPbp+=gwSE6yDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZFw=tbRmh1_qUeRvVKokMqYd35FEO+NPbp+=gwSE6yDA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sanjeev Sharma <sanjeev_sharma@mentor.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [151210 10:18]:
> On Thu, Dec 3, 2015 at 10:44 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Linus Walleij <linus.walleij@linaro.org> [151030 12:54]:
> >> Please run posts like this by the maintainers. Tony Lindgren is one
> >> user, Haojian is another.
> >
> > I think we need to add ourselves to MAINTAINERS for this driver,
> > otherwise we'll keep on missing emails.
> 
> Good idea! Patches accepted.

How about this one below?

Regards,

Tony

8< -----------------------
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 10 Dec 2015 14:27:32 -0800
Subject: [PATCH] MAINTAINERS: pinctrl: Add maintainers for pinctrl-single

Otherwise we keep missing patches related to this driver.

Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8379,6 +8379,14 @@ L:	linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/pinctrl/samsung/
 
+PIN CONTROLLER - SINGLE
+M:	Tony Lindgren <tony@atomide.com>
+M:	Haojian Zhuang <haojian.zhuang@linaro.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-omap@vger.kernel.org
+S:	Maintained
+F:	drivers/pinctrl/pinctrl-single.c
+
 PIN CONTROLLER - ST SPEAR
 M:	Viresh Kumar <vireshk@kernel.org>
 L:	spear-devel@list.st.com
