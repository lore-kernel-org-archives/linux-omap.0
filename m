From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2+: Drop mmc platform data for am330x and
 am43xx
Date: Mon, 22 Jul 2019 23:40:38 -0700
Message-ID: <20190723064038.GP5447@atomide.com>
References: <20190326181324.32140-1-tony@atomide.com>
 <20190326181324.32140-2-tony@atomide.com>
 <0af63198-5a68-2f0d-f14e-2b514580d2d5@lechnology.com>
 <20190722060951.GL5447@atomide.com>
 <20190722075411.GM5447@atomide.com>
 <8427af44-2e28-7e13-3841-15c89d60f6dd@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <8427af44-2e28-7e13-3841-15c89d60f6dd@lechnology.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Lechner <david@lechnology.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* David Lechner <david@lechnology.com> [190722 14:27]:
> On 7/22/19 2:54 AM, Tony Lindgren wrote:
> > Oh I just noticed this needs to be fixed in v5.2, not in v5.3-rc
> > series. It's best to keep the "ti,hwmods" property still around
> > as there may be dependencies to ti-sysc driver changes in v5.3-rc
> > series for dropping it. Below is a more minimal fix to try.
...

> This fixes wifi on BeagleBone Blue for me in v5.2.
> 
> Tested-by: David Lechner <david@lechnology.com>

OK great, thanks for testing.

Regards,

Tony
