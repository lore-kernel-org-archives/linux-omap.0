From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/2] phy: Group vendor specific phy drivers
Date: Sun, 3 Apr 2016 15:05:27 +0900
Message-ID: <20160403060527.GA5034@kozik-lap>
References: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Vivek Gautam <gautam.vivek@samsung.com>
Cc: vireshk@kernel.org, shiraz.linux.kernel@gmail.com, kishon@ti.com, heiko@sntech.de, maxime.ripard@free-electrons.com, wens@csie.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, spear-devel@list.st.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, cpgs@samsung.com
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 01, 2016 at 04:59:15PM +0530, Vivek Gautam wrote:
> Adding vendor specific directories in phy to group
> phy drivers under their respective vendor umbrella.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
> 
> With growing number of phy drivers, it makes sense to
> group these drivers under their respective vendor/platform
> umbrella directory.
> 
> Build-tested 'multi_v7_defconfig'.

Please update also the MAINTAINERS file. For many entires the path won't
match anymore.

Best regards,
Krzysztof
