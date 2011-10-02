From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/30] ARM: omap/iommu: always provide iommu debug code
Date: Sun, 02 Oct 2011 20:01:30 +0200
Message-ID: <1377050.B9gMvYWCVB@wuerfel>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-11-git-send-email-arnd@arndb.de>
	<CAK=WgbY-1VU5tJNxaJmP+8xqxV+XHjFeV=hjmxpZNuQJdKg=BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK=WgbY-1VU5tJNxaJmP+8xqxV+XHjFeV=hjmxpZNuQJdKg=BQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Tony Lindgren <tony@atomide.com>, "Roedel,
	Joerg" <Joerg.Roedel@amd.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sunday 02 October 2011 18:34:52 Ohad Ben-Cohen wrote:
> 
> The driver has moved to drivers/iommu/ and changed a bit, but this
> patch is still relevant.
> 
> The merge conflict will be trivial to resolve, but if you prefer, we
> can prevent it by taking this patch via the iommu tree.

Yes, please take it into the iommu tree, so I don't have to track
the conflict.

Thanks,

	Arnd
