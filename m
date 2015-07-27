From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/2] omap dts changes for dm814x for v4.3
Date: Mon, 27 Jul 2015 14:48:32 +0200
Message-ID: <20150727124832.GJ14224@localhost>
References: <pull-1437718313-185670>
 <55b22a44.4b226b0a.bc37c.ffffce74SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <55b22a44.4b226b0a.bc37c.ffffce74SMTPIN_ADDED_BROKEN@mx.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 24, 2015 at 05:06:11AM -0700, Tony Lindgren wrote:
> The following changes since commit f9d50fef4b6447527c2be1ad07499221c2511391:
> 
>   ARM: OMAP2+: omap3-pandora: add wifi support (2015-07-21 04:07:42 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/dt-dm814x
> 
> for you to fetch changes up to f5887fe5d14181aef0653ab04f60988252d42461:
> 
>   ARM: OMAP2+: Add custom abort handler for t410 (2015-07-23 22:33:19 -0700)
> 
> ----------------------------------------------------------------
> omap dts changes for minimal dm814x support for v4.3 merge window.
> 
> These changes make dm814x boot and adds minimal board support for
> dm814x-evm and hp t410.
> 
> Note that to boot these depend on omap-for-v4.3/soc-signed branch,
> but as dm814x support is currently broken, these can be merged
> separately with the other dts changes.
> 
> ----------------------------------------------------------------
> Tony Lindgren (5):
>       ARM: dts: Add minimal dm814x support
>       ARM: dts: Add minimal clocks for dm814x
>       ARM: dts: Add minimal dts support for dm8148-evm
>       ARM: dts: Add minimal support for HP T410
>       ARM: OMAP2+: Add custom abort handler for t410

Thanks, merged.


-Olof
