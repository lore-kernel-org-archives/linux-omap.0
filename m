From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
	supported by the hardware
Date: Mon, 10 Oct 2011 09:40:11 +0200
Message-ID: <CAK=WgbZmmPo=n=LMdTnXrb93GHkGLrJTHYqoCvN8_pUgEyo8_g@mail.gmail.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
	<1316195506-9777-2-git-send-email-ohad@wizery.com>
	<20110927100505.GH2138@amd.com>
	<CAK=WgbahwY+7Ux-RjW2Tw9WBSwZnYuTMZ2NQASWyOXQ3zF6qFg@mail.gmail.com>
	<20110927131222.GL2138@amd.com>
	<CAK=WgbYG2tpMJ2SikZhm=R9j5kQ6Hm8CGg=q1bko3idzF53Q3Q@mail.gmail.com>
	<20110927181438.GM2138@amd.com>
	<CAK=WgbbNs5fWHDEputZ=jzU5YN0sn0tf6AETkcsoq_Jbvc2XgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK=WgbbNs5fWHDEputZ=jzU5YN0sn0tf6AETkcsoq_Jbvc2XgQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Brown <davidb@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stepan Moskovchenko <stepanm@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Oct 2, 2011 at 5:58 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Ok, fair enough. I've revised the patches and attached the main one
> below; please tell me if it looks ok, and then I'll resubmit the
> entire patch set.

Ping ?
