From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: Remove unused legacy code for device
 init
Date: Thu, 8 Jun 2017 01:28:25 -0700
Message-ID: <20170608082825.GG3730@atomide.com>
References: <20170531225139.30723-1-tony@atomide.com>
 <20170531225139.30723-5-tony@atomide.com>
 <20170607222711.6kdhuvkymiseootn@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170607222711.6kdhuvkymiseootn@earth>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [170607 15:30]:
> I guess you can drop omap2_init_devices() completly?

We still have omap_init_sti() left there, but it's
just static inline void omap_init_sti(void) {} :)

So yeah will remove that too.

Regards,

Tony
