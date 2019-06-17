From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 3/4] ti-sysc driver changes for v5.3
Date: Mon, 17 Jun 2019 04:53:52 -0700
Message-ID: <20190617115352.enwk67aca57fm3im@localhost>
References: <pull-1560399818-512977@atomide.com>
 <pull-1560399818-512977@atomide.com-3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1560399818-512977@atomide.com-3>
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

On Thu, Jun 13, 2019 at 12:10:52AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 4ee23cd76c0ce8622976b3da0e2bc89e6d94f6d4:
> 
>   Merge branch 'omap-for-v5.2/ti-sysc' into fixes (2019-05-20 08:33:03 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.3/ti-sysc-signed
> 
> for you to fetch changes up to 4e23be473e3063a9d3bc06bb0aee89885fffab0e:
> 
>   bus: ti-sysc: Add support for module specific reset quirks (2019-06-10 04:52:22 -0700)
> 
> ----------------------------------------------------------------
> ti-sysc interconnect target module driver changes for v5.3
> 
> This series of changes improves probing devices with ti-sysc to the
> point where we can now probe most devices without the custom dts
> property "ti,hwmods" and no legacy platform data :)
> 
> We add support for platform data callbacks for idling and unidling the
> clockdomain the module belongs to. The rest of the series mostly adds
> handling for the various quirks needed by old legacy modules such as
> i2c and watchdog. Some quirk handling is still missing for few modules,
> but those will be added as they get tested.
> 
> The related platform data and dts changes will be sent separately.

Merged, thanks!


-Olof
