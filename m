From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [RESEND PATCH v3 2/2] phy: Group vendor specific phy drivers
Date: Wed, 15 Mar 2017 09:08:44 +0100
Message-ID: <2492681.1VCl1nfEs0@diego>
References: <1489472080-23711-2-git-send-email-vivek.gautam@codeaurora.org>
 <1489472570-26434-1-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1489472570-26434-1-git-send-email-vivek.gautam@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Viresh Kumar <viresh.kumar@linaro.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, kishon@ti.com, Jaehoon Chung <jh80.chung@samsung.com>, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-msm@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-omap@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org

Am Dienstag, 14. M=E4rz 2017, 11:52:50 CET schrieb Vivek Gautam:
> Adding vendor specific directories in phy to group
> phy drivers under their respective vendor umbrella.
> =

> Also updated the MAINTAINERS file to reflect the correct
> directory structure for phy drivers.
> =

> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> ---
> =

> Corrected Krzysztof's email-id. Added linux-arm-msm.
> =

> Hi Heiko, Viresh,
> It's been a year since the last version of this patch was posted.
> Kishon has agreed to pull this change now. I am carrying forward
> your Acks since there are no functional changes.
> I have taken care of the drivers that were added/removed since
> the last version.
> Please feel free to jump in if you have any concerns.

still looks all good and I gave that a try on 4.11-rc2 yesterday as well.


Heiko
