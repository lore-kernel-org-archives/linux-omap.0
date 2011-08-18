From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 5/7] omap: iovmm: remove unused functionality
Date: Thu, 18 Aug 2011 13:23:44 +0300
Message-ID: <CAK=WgbYr+pRqZPLSigyN0SNq9g0NPU2WkdWfVOW931hhQwGmiw@mail.gmail.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-6-git-send-email-ohad@wizery.com>
	<20110818.131928.751866371806910622.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110818.131928.751866371806910622.Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: arnd@arndb.de, tony@atomide.com, Joerg.Roedel@amd.com, iommu@lists.linux-foundation.org, laurent.pinchart@ideasonboard.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 18, 2011 at 1:19 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> Maybe it's better to remove the comments explaining unnecessary
> functions too. Now the function comparison table doesn't make sense....

Sure, will do.

> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Date: Thu, 18 Aug 2011 13:13:53 +0300
> Subject: [PATCH 1/1] omap: iommu: remove obsolete comments
>
> Remove ones referring to non-existing functions.

I think it might be better to squash it with the original patch though
- are you ok with it ?

Thanks,
Ohad.
