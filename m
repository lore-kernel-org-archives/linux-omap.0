From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP5: id: Remove ES1.0 support
Date: Wed, 18 Sep 2013 10:07:45 -0400
Message-ID: <5239B3B1.5000004@ti.com>
References: <5239AE35.8030406@ti.com>
 <1379513142-11125-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1379513142-11125-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 18 September 2013 10:05 AM, Nishanth Menon wrote:
> OMAP5 ES1.0 was intended as a test chip and has major register level
> differences w.r.t ES2.0 revision of the chip. All register defines,
> dts support has been solely added for ES2.0 version of the chip.
> Further, all ES1.0 chips and platforms are supposed to have been
> removed from circulation. Hence, there is no need to further retain
> any resemblence of ES1.0 support in id detection code.
> 
> Remove the omap_revision handling and BUG() instead to prevent folks
> who mistakenly try an older unsupported chip and report bogus errors.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> ref: http://marc.info/?l=linux-omap&m=137951198232339&w=2
> based on 3.12-rc1 tag
> 
That was quick ...
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
