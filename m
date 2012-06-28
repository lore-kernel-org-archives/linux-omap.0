From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] arm: omap3: am35x: Fix clockdomain dependencies
Date: Thu, 28 Jun 2012 00:08:13 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206280007420.2338@utopia.booyaka.com>
References: <1334866606-8291-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1334866606-8291-1-git-send-email-mgreer@animalcreek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, 19 Apr 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> The am35x family of SoCs do not have an IVA so
> a parallel set of clockdomain dependencies are
> required that are simililar to OMAP3 but without
> any IVA dependencies.
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> ---
> 
> Paul, this is a respin of
> 	"[PATCH 08/12] arm: omap3: am35x: Fix clockdomain dependencies"
> 
> with your comments [hopefully] addressed.  I'm breaking that long series
> into smaller pieces because most of them really weren't related.

Thanks, queued for 3.6.


- Paul
