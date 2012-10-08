From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: sort select statements alphanumerically
Date: Mon, 8 Oct 2012 08:53:08 +0100
Message-ID: <20121008075308.GF28061@n2100.arm.linux.org.uk>
References: <E1TKX8k-0006QP-M5@rmk-PC.arm.linux.org.uk>
 <CAMPhdO-SuJwz4uN=1sQWtr3WOn656_M9iEGkMDjtOKTrsMUDpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAMPhdO-SuJwz4uN=1sQWtr3WOn656_M9iEGkMDjtOKTrsMUDpg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-sh@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Daniel Walker <dwalker@fifo99.com>, Kevin Hilman <khilman@ti.com>, linux-samsung-soc@vger.kernel.org, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, David Brown <davidb@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alessandro Rubini <rubini@unipv.it>, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org, spear-devel@list.st.com, Sekhar Nori <nsekhar@ti.com>, Shiraz Hashim <shiraz.hashim@st.com>, Kukjin Kim <kgene.kim@samsung.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Barry Song <baohua.song@csr.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kern
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 08, 2012 at 10:50:00AM +0800, Eric Miao wrote:
> BTW, maybe we also need to sort the ARCH_XXX in alphanumeric order, so
> new ARCH will find a better place to live?

They should be sorted according to option text already - this is to
allow people using the configuration tool to easily find the right
option to select in that long list.  That's something I did well
before arm-soc.

It looks pretty good at the moment, except for the following two:

        bool "Cavium Networks CNS3XXX family"
        bool "NXP LPC32XX"
