From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 0/2] ARM: sort configuration files
Date: Fri, 12 Oct 2012 14:25:53 +0100
Message-ID: <20121012132553.GK28061@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, spear-devel@list.st.com
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Sekhar Nori <nsekhar@ti.com>, Daniel Walker <dwalker@fifo99.com>, Kevin Hilman <khilman@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Magnus Damm <magnus.damm@gmail.com>, David Brown <davidb@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alessandro Rubini <rubini@unipv.it>, Stephen Warren <swarren@wwwdotorg.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, Ben Dooks <ben-linux@fluff.org>, Barry Song <baohua.song@csr.com>, Andrew Victor <linux@maxim.org.za>, Eric Miao <eric.y.miao@gmail.com>, Bryan Huntsman <bryanh@codeaurora.org>, Paul Mundt <lethal@linux-sh.org>, Viresh Kumar <viresh.linux@gmail.com>, Sascha Hauer <kernel@pengutronix.de>S
List-Id: linux-omap@vger.kernel.org

Here's a version updated to the kernel as of 7am UTC today.  Two patches
follow, the second fixes the order of the platform choice.
