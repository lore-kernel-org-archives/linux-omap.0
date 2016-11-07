From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: avoid NULL pointer dereference
Date: Mon, 7 Nov 2016 16:25:06 -0700
Message-ID: <20161107232505.GG2428@atomide.com>
References: <1477993765-9980-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1477993765-9980-1-git-send-email-Nicolae_Rosia@mentor.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Nicolae Rosia <Nicolae_Rosia@mentor.com> [161101 02:50]:
> For OMAP4, volt_data is set in omap44xx_voltagedomains_init.
> If the SoC is neither OMAP443X or OMAP446X, we end up with a
> NULL in volt_data which causes a kernel oops.
> This is the case when booting OMAP4470.

Thanks applying into omap-for-v4.9/fixes.

Tony
