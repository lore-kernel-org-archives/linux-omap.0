From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] ARM: OMAP3: hwmod data: Remove legacy mailbox data
 and addrs
Date: Thu, 22 Oct 2015 16:44:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1510221644130.15693@utopia.booyaka.com>
References: <1442273833-25013-1-git-send-email-s-anna@ti.com>
 <1442273833-25013-3-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1442273833-25013-3-git-send-email-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, 14 Sep 2015, Suman Anna wrote:

> Remove the mailbox attribute data, irq info and hwmod addr space
> data that are used for creating the legacy-style mailbox devices,
> there is no need for these as the support for legacy-mode for this
> IP is being dropped.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

Thanks, queued.


- Paul
