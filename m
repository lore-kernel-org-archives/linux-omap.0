From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v7 0/4] hwspinlock core & omap dt support
Date: Thu, 15 Jan 2015 12:13:34 +0200
Message-ID: <CAK=Wgba1S58OMs=FTfv=UraU_3EZn_eOLmADtCjrvJkDSGw8WA@mail.gmail.com>
References: <1421269101-51105-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421269101-51105-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Bjorn Andersson <bjorn@kryo.se>, Josh Cartwright <joshc@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Suman,

On Wed, Jan 14, 2015 at 10:58 PM, Suman Anna <s-anna@ti.com> wrote:
> This is an updated version of the hwspinlock dt support series,
> rebased onto v3.19-rc3 and mainly addresses the continued discussion
> on the need to maintain a list of registered spinlock banks [1].
> I have removed this patch as per your wish, and as a result the
> burden of the spinlock validation and deferred probing is pushed
> onto the hwspinlock clients. Sorry for the delay in refreshing this
> series, hopefully this can be the last revision.
>
> Following are the main changes in v7 w.r.t v6:
> - Dropped the patch "hwspinlock/core: maintain a list of registered
>   hwspinlock banks"
> - Updated generic hwspinlock bindings to make hwlock-base-id property
>   mandatory.
> - Updated the OMAP hwspinlock binding and DT support patches to correct
>   for the mandatory hwlock-base-id property.
> - Updated the common OF helpers patch to move the of_hwspin_lock_get_base_id()
>   and of_hwspin_lock_get_num_locks() functions into the internal header,
>   these are no longer exported, but available for platform implementations.
>   of_hwspin_lock_get_id() is also simplified now.

This looks good, thanks.

Please try to get an ACK from a DT maintainer on the first two dt
patches, and then I can take the patches to Linus.

Thanks,
Ohad.
