From: Tony Lindgren <tony@atomide.com>
Subject: Regression in v4.20 with net phy soft reset changes
Date: Wed, 9 Jan 2019 11:06:50 -0800
Message-ID: <20190109190650.GT5544@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chris Healy <cphealy@gmail.com>, Clemens Gruber <clemens.gruber@pqgruber.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Keerthy <j-keerthy@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, Rex Chang <rchang@ti.com>, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>, WingMan Kwok <w-kwok2@ti.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Commit 6e2d85ec0559 ("net: phy: Stop with excessive soft reset") caused
a regression where suspend resume cycle fails to bring up Ethernet on at
least cpsw on am437x-sk-evm.

Keerthy noticed this may not happen on the first resume, but usually
happens after few suspend resume cycles. The most working suspend resume
cycles I've seen with the commit above is three.

Any ideas what might be going wrong?

Note that unrelated to the commit above, there may be other issues too
as the cpsw phy LED seems to come on only after about five seconds with
about total of 10 seconds before the Ethernet is up again.

Regards,

Tony
