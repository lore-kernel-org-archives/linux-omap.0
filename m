From: Adam Ford <aford173@gmail.com>
Subject: davinci_emac failures in 4.18-rc1 on AM3517-EVM
Date: Tue, 19 Jun 2018 18:11:59 -0500
Message-ID: <CAHCN7xJo426dfUr4ZoYa859TBpS_XLDYu4JO7oO+qsWvWrzQ_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, netdev <netdev@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

I am not sure if anyone else has seen this.  If not, I'll bisect, but
the AM3517 ethernet seems to have died, and it's throwing some errors

[    2.708933] davinci_mdio davinci_mdio.0: failed to get device clock
[    2.715363] davinci_mdio: probe of davinci_mdio.0 failed with error -2

[snip]

[    3.054552] davinci_emac davinci_emac.0: failed to get EMAC clock
[    3.061195] davinci_emac: probe of davinci_emac.0 failed with error -16


If no one has seen this, I'll look into it, but I didn't want to waste
time if someone is already aware of it.

adam
