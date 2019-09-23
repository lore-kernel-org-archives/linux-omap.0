From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 linux-next 1/4] arm: configs: omap2plus_defconfig:
 Change CONFIG_REMOTEPROC from m to y
Date: Mon, 23 Sep 2019 10:56:53 -0700
Message-ID: <20190923175653.GZ5610@atomide.com>
References: <20190920075946.13282-1-j-keerthy@ti.com>
 <20190920075946.13282-2-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190920075946.13282-2-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org, t-kristo@ti.com, olof@lixom.net, will@kernel.org, hch@lst.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [190920 08:00]:
> Commit 6334150e9a36 ("remoteproc: don't allow modular build")
> changes CONFIG_REMOTEPROC to a boolean from a tristate config
> option which inhibits all defconfigs marking CONFIG_REMOTEPROC as
> a module in compiling the remoteproc and dependent config options.
> 
> So fix the omap2plus_defconfig to have CONFIG_REMOTEPROC built in.

Acked-by: Tony Lindgren <tony@atomide.com>
