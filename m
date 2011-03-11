From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/2] omap: iovmm: Fix IOVMM check for fixed 'da'
Date: Fri, 11 Mar 2011 12:37:57 -0800
Message-ID: <20110311203757.GI10079@atomide.com>
References: <1299662253-29817-1-git-send-email-dacohen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1299662253-29817-1-git-send-email-dacohen@gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: Hiroshi.DOYU@nokia.com, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com, sakari.ailus@maxwell.research.nokia.com, fernando.lugo@ti.com
List-Id: linux-omap@vger.kernel.org

* David Cohen <dacohen@gmail.com> [110309 01:16]:
> Hi,
> 
> Previous patch 2/3 was dropped in this new version. Patch 1 was updated
> according to a comment it got.
> 
> ---
> IOVMM driver checks input 'da == 0' when mapping address to determine whether
> user wants fixed 'da' or not. At the same time, it doesn't disallow address
> 0x0 to be used, what creates an ambiguous situation. This patch set moves
> fixed 'da' check to the input flags.

Applying these.

Tony
