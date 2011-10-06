From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2: Devkit8000: Remove double omap_mux_init_gpio
Date: Thu, 6 Oct 2011 12:51:34 -0700
Message-ID: <20111006195134.GN6324@atomide.com>
References: <1315321909-5593-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1315321909-5593-1-git-send-email-weber@corscience.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Weber <weber@corscience.de>
Cc: linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, open list <linux-kernel@vger.kernel.org>, "open list:ARM PORT" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Thomas Weber <weber@corscience.de> [110906 07:38]:
> Remove the init of card detect pin because
> omap_mux_init_gpio() is called during hsmmc initialization
> for the write protect and card detect pin.

Thanks, adding this into fixes-part2 branch.

Tony
