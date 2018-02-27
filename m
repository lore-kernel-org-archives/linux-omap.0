From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/9] ARM: dts: am33xx/am4372: Add suspend-resume support
Date: Tue, 27 Feb 2018 09:46:31 -0800
Message-ID: <20180227174631.GD5448@atomide.com>
References: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Johan Hovold <johan@kernel.org>, linux-arm-kernel@lists.infradead.org, Keerthy J <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [180218 19:35]:
> Hi,
> This series is the last needed to enable suspend/resume on am335x/am437x
> along with [1]. It adds required dt nodes for the emif and core PM code
> to find the needed sram nodes and marks key devices with ti,no-idle so
> that the kernel does not idle them. With this suspend to mem can be achieved
> by following the steps described in [1].

Applying all these into omap-for-v4.17/dt thanks.

Tony
