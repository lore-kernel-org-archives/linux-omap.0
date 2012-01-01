From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 REPOST 1/5] ARM: l2x0/pl310: Refactor Kconfig to be
 more maintainable
Date: Sun, 1 Jan 2012 14:44:51 +0100
Message-ID: <CACRpkdaZ8fph0tgQMceVKzSNo9gbsaRFrz9c2TKYqYZgtbgdbw@mail.gmail.com>
References: <1324053332-6431-1-git-send-email-dave.martin@linaro.org>
 <1324053332-6431-2-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1324053332-6431-2-git-send-email-dave.martin@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-sh@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Barry Song <baohua.song@csr.com>, Will Deacon <will.deacon@arm.com>, Daniel Walker <dwalker@fifo99.com>, John Linn <john.linn@xilinx.com>, Kukjin Kim <kgene.kim@samsung.com>, Magnus Damm <magnus.damm@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, David Brown <davidb@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, linux-arm-msm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, linux-samsung-soc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@freescale.com>, Colin Cross <ccross@google.com>B
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 16, 2011 at 5:35 PM, Dave Martin <dave.martin@linaro.org> wrote:

> Making CACHE_L2X0 depend on (huge list of MACH_ and ARCH_ configs)
> is bothersome to maintain and likely to lead to merge conflicts.
(...)
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
> =A0 =A0 =A0 =A0(for cns3xxx)
> Acked-by: Tony Lindgren <tony@atomide.com>
> =A0 =A0 =A0 =A0(for omap)
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> =A0 =A0 =A0 =A0(for imx)

Acked-by: Linus Walleij <linus.walleij@linaro.org>
(for ux500)

Yours,
Linus Walleij
