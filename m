From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/9] ARM: qcom: remove unnecessary boot_lock
Date: Thu, 10 Jan 2019 14:05:27 -0800
Message-ID: <154715792793.19284.6256735661009793613@swboyd.mtv.corp.google.com>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVHy-00088e-JK@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1gXVHy-00088e-JK@rmk-PC.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-oxnas@groups.io, linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-omap@vger.kernel.org

Quoting Russell King (2018-12-13 10:00:46)
> The boot_lock is something that was required for ARM development
> platforms to ensure that the delay calibration worked properly.  This
> is not necessary for modern platforms that have better bus bandwidth
> and do not need to calibrate the delay loop for secondary cores.
> Remove the boot_lock entirely.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
