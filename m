From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH 1/3] iommu/core: add fault reporting mechanism
Date: Tue, 13 Sep 2011 12:00:34 +0200
Message-ID: <20110913100034.GJ11701@amd.com>
References: <1315421604-12286-1-git-send-email-ohad@wizery.com>
	<20110912160252.GE11701@amd.com>
	<CAK=WgbZCDsBk+dueKfAX3ewsvqEnVDN+jW_ftW+BDKnayunOwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAK=WgbZCDsBk+dueKfAX3ewsvqEnVDN+jW_ftW+BDKnayunOwA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Brown <davidb@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 12, 2011 at 12:21:13PM -0400, Ohad Ben-Cohen wrote:
> On Mon, Sep 12, 2011 at 7:02 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> > I still don't get the need for this. It would make sense to encode
> > different types of faults, like page-faults or interrupt-faults.
> 
> Right.
> 
> > When I read the comment above it sounds more like you want to encode
> > different error-levels, like recoverable and unrecoverable error.
> > The exact meaning of these values need to be clarified.
> 
> Well, we currently only need to say "something bad has happened".
> 
> We don't need at this point to tell whether it's a hardware bug,
> inconsistent data, missing page-table entries or whatnot, because we
> don't expect the user (or the iommu core itself) to do anything about
> it. Not that it's not possible though: a valid response one day would
> be to fix the page-table or add a missing TLB (depending on the mode
> the hardware is configured to) but this is not (yet?) implemented. So
> a "general unrecoverable error" is enough at this point, but it's
> certainly makes sense to allow drivers to provide additional types of
> errors/faults - once they are implemented.

But besides real faults all this can be handled in the iommu-driver
itself, right? So there is no need to communicate other errors than
page-faults up to the driver.

For now I think it is the best to remove this IOMMU_ERROR thing. It is
inherent to the function call already. When a real use-case comes up we
can easily add it later.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
