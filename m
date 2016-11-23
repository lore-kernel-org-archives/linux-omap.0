From: Rami Rosen <roszenrami@gmail.com>
Subject: Re: [PATCH] cpsw: ethtool: add support for getting/setting EEE registers
Date: Wed, 23 Nov 2016 16:31:09 +0200
Message-ID: <CAKoUArn8ndLaaEEr55DNFOqJL1hcRvpZCZ1e7WqhWZiaAHBiNw@mail.gmail.com>
References: <1479897248-5923-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1479897248-5923-1-git-send-email-yegorslists@googlemail.com>
Sender: netdev-owner@vger.kernel.org
To: yegorslists@googlemail.com
Cc: Netdev <netdev@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, grygorii.strashko@ti.com, mugunthanvnm@ti.com
List-Id: linux-omap@vger.kernel.org

Hi, Yegor,

Minor comment: these methods should be static.

+int cpsw_get_eee(struct net_device *ndev, struct ethtool_eee *edata)
+{
...
...
+int cpsw_set_eee(struct net_device *ndev, struct ethtool_eee *edata)
...

Regards,
Rami Rosen
