From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/17] ARM: OMAP2+: PRM: add support for reset controller
Date: Mon, 30 Nov 2015 09:09:22 -0800
Message-ID: <20151130170922.GE2517@atomide.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
 <1443104818-993-2-git-send-email-t-kristo@ti.com>
 <20151006120606.GP23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20151006120606.GP23801@atomide.com>
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

* Tony Lindgren <tony@atomide.com> [151006 05:12]:
> * Tero Kristo <t-kristo@ti.com> [150924 07:30]:
> > PRM driver now supports reset controller for the defined reset lines.
> > Reset configurations are provided through device tree. Later, functionality
> > like hwmod and system reboot will be changed to use the generic framework.
> 
> This approach seems good to me in general. This should have the related
> reset driver documentation too for the binding though.

Also, with the initcall changes I just posted, it seems this can become
just a regular device driver that gets initialized at core_initcall level.

Regards,

Tony
