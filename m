From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 2/5] ARM: OMAP2+: hwmod: fetch main_clk based on hwmod
 name
Date: Mon, 4 Jul 2016 07:32:48 -0700
Message-ID: <20160704143248.GU28140@atomide.com>
References: <20160704065428.GS28140@atomide.com>
 <1467630708-28498-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1467630708-28498-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [160704 04:14]:
> With the transition to hwmod module clocks, all hwmods will have
> their main clocks named <hwmod_name>_mod_ck. Use this info to
> fetch main_clk, and use it if found.
> 
> Also, if a main_clk is found based on the hwmod name, disable
> the direct PRCM modulemode access from hwmod.

Thanks for updating this, applying all into omap-for-v4.8/soc.

Regards,

Tony
