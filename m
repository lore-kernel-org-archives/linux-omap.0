From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: OMAP3: fix boot regression for N9
Date: Mon, 30 Oct 2017 09:19:50 -0700
Message-ID: <20171030161950.GA7339@atomide.com>
References: <1509354664-27694-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1509354664-27694-1-git-send-email-t-kristo@ti.com>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [171030 02:13]:
> Hi,
> 
> N9 boot is apparently broken with mainline, caused by some recent
> changes to TI clock drivers. The reason for failing boot is effectively
> missing hwmod data piece for MMC3, so add this in place. The CM
> related fix is also needed to properly handle idlest functionality
> on OMAP3; currently this is mostly masked but will cause issues in
> some places.

Thanks applying both into omap-for-v4.14/fixes. If these don't make
it to v4.14, these can always be requested for stable releases as
needed as specified in Documentation/process/stable-kernel-rules.rst.

Regards,

Tony
