From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 3/5] ARM: OMAP2+: hwmod: Extract no-idle and no-reset
 info from DT
Date: Wed, 9 Oct 2013 14:55:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310091455300.30199@utopia.booyaka.com>
References: <1381313521-10422-1-git-send-email-rnayak@ti.com> <1381313521-10422-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1381313521-10422-4-git-send-email-rnayak@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: bcousson@baylibre.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 9 Oct 2013, Rajendra Nayak wrote:

> Now that we have DT bindings to specify which devices should not
> be reset and idled during init, make hwmod extract the information
> (and store them in internal flags) from Device tree.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, queued.

- Paul
