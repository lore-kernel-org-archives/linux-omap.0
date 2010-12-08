From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/14] OMAP: PRCM/powerdomain/clockdomain patches for
	2.6.38, part one
Date: Tue, 07 Dec 2010 16:16:46 -0800
Message-ID: <87wrnli0ep.fsf@deeprootsystems.com>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20101207012242.3708.45451.stgit@twilight.localdomain> (Paul
	Walmsley's message of "Mon, 06 Dec 2010 18:24:58 -0700")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> This patch series, intended for 2.6.38:

[...]

> Kevin, I'd appreciate review and acks, if appropriate, on the patches
> that touch code that you maintain.  

Reviewed-by: Kevin Hilman <khilman@deeprootsystems.com>
Tested-by: Kevin Hilman <khilman@deeprootsystems.com>

I did some PM testing of this series on 34xx/n900 and 35xx/beagle using
retention idle & sususpend and off-idle and suspend.

For testing with other PM features that are targetted for 2.6.38, I've
included it as part of my pm-core branch (which also includes your
previous hwmod series and the watchdog series, among other things.)

Kevin
