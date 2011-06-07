From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 0/6] iommu: generic api migration and grouping
Date: Tue, 7 Jun 2011 12:22:11 +0300
Message-ID: <BANLkTimR3KofKA3LSKXdX8k1FGR0XUxu=Q@mail.gmail.com>
References: <1307053663-24572-1-git-send-email-ohad@wizery.com>
	<20110606100950.GC30762@amd.com>
	<BANLkTi=i2s-Ujiy4qn_XQv+9dMjUC9R66A@mail.gmail.com>
	<20110606153557.GE1953@amd.com>
	<BANLkTinwwVO4TmsxuTfSBf6jqYrEVV3b_A@mail.gmail.com>
	<20110606192030.GA4356@amd.com>
	<BANLkTinx21-E3DRe9D7LRB8e1aeOwv=-9A@mail.gmail.com>
	<20110607075221.GB4407@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110607075221.GB4407@amd.com>
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
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, "arnd@arndb.de" <arnd@arndb.de>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "davidb@codeaurora.org" <davidb@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 7, 2011 at 10:52 AM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> Yup. Btw, is there any IOMMU hardware which supports non-natural
> alignment? In this case we need to expose these requirements somehow.

Not sure there are. Let's start with natural alignment, and extend it
only if someone with additional requirements shows up.
