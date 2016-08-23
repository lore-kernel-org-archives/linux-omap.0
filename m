From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH v4 5/5] net: ethernet: ti: cpsw: add ethtool channels
 support
Date: Tue, 23 Aug 2016 11:09:45 +0530
Message-ID: <28a8a12e-bae5-86fc-ffca-5f40b7965ee8@ti.com>
References: <1471889908-29983-1-git-send-email-ivan.khoronzhuk@linaro.org>
 <1471889908-29983-6-git-send-email-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1471889908-29983-6-git-send-email-ivan.khoronzhuk@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net, netdev@vger.kernel.org, grygorii.strashko@ti.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, dlide@ti.com
List-Id: linux-omap@vger.kernel.org

On Monday 22 August 2016 11:48 PM, Ivan Khoronzhuk wrote:
> These ops allow to control number of channels driver is allowed to
> work with at cpdma level. The maximum number of channels is 8 for
> rx and 8 for tx. In dual_emac mode the h/w channels are shared
> between two interfaces and changing number on one interface changes
> number of channels on another.
> 
> How many channels are supported and enabled:
> $ ethtool -l ethX
> 
> Change number of channels (up to 8)
> $ ethtool -L ethX rx 6 tx 6
> 
> Per-channel statistic:
> $ ethtool -S ethX
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

Reviewed-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N
