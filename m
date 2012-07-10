From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] rpmsg bus subsys_initcall initialization ordering
Date: Tue, 10 Jul 2012 19:22:36 +0300
Message-ID: <CAK=Wgbaf0On3teqOw1myqkS4Dei3Vw2Zn=0xfOv-YiNUjFr0fg@mail.gmail.com>
References: <1341936444-3094-1-git-send-email-fuga@studiofuga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1341936444-3094-1-git-send-email-fuga@studiofuga.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Federico Fuga <fuga@studiofuga.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Federico,

On Tue, Jul 10, 2012 at 7:07 PM, Federico Fuga <fuga@studiofuga.com> wrote:
> omaprpc depends on the rpmsg bus.

Sorry for the ignorance, but what's omaprpc ? :)

I guess it's some out-of-tree module (which I've never seen) so I'm
not sure we want change mainline code to fix issues with it.

If your code is anyway out-of-tree, it'd probably make more sense if
this patch stays out of tree too (plus I have no way to review this
patch, and understand the issue it fixes, without seeing the relevant
code).

If this really is about mainline kernel, let me know.

Thanks,
Ohad.
