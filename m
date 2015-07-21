From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am437x: add aliases for all UART instances
Date: Tue, 21 Jul 2015 04:01:50 -0700
Message-ID: <20150721110150.GC17550@atomide.com>
References: <b1af39962d1cae5c344e8593ca738c825af40955.1437390674.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <b1af39962d1cae5c344e8593ca738c825af40955.1437390674.git.nsekhar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Eyal Reizer <eyalr@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Sekhar Nori <nsekhar@ti.com> [150720 04:15]:
> Add serialN aliases for all 6 UART instances on
> the AM437x SoC so each board's .dts file does not
> have to define its own aliases.
> 
> Remove the alias added for am437x-gp-evm.dts now
> that we have the aliases defined in am4372.dtsi
> file.

Applying both into omap-for-v4.3/dt thanks.

Tony
