From: Tony Lindgren <tony@atomide.com>
Subject: Regression in next-20181219 with iommu
Date: Wed, 19 Dec 2018 10:09:28 -0800
Message-ID: <20181219180928.GF6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Joerg Roedel <jroedel@suse.de>
List-Id: linux-omap@vger.kernel.org

Hi all,

FYI, looks like there's an iommu regression in next-20181219
caused by commit 641fb0efbff0 ("iommu/of: Don't call
iommu_ops->add_device directly").

There's a fix being discussed at:

https://lore.kernel.org/patchwork/patch/1023860/

Regards,

Tony
