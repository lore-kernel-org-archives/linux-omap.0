From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] pinmux dts defines for am335x for v5.2
Date: Sun, 28 Apr 2019 12:39:02 -0700
Message-ID: <20190428193902.7tj2yyfcolk44crm@localhost>
References: <pull-1555431314-599391@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1555431314-599391@atomide.com>
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org, Christina Quast <cquast@hanoverdisplays.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 16, 2019 at 09:16:58AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.2/dt-am3-signed
> 
> for you to fetch changes up to e5b258e53e58a3afd228bbef4d376c7a470cfa58:
> 
>   ARM: dts: am335x: wega: Replaced register offsets with defines (2019-04-15 08:26:28 -0700)
> 
> ----------------------------------------------------------------
> Add am335x pinmux defines and start using them
> 
> This series of changes adds a new pinmux instance defines for am335x,
> and a new AM33XX_PADCONF macro. And then the rest of the series updates
> the dts files to use it.
> 
> The reasons for doing this is the pinmux configuration has been hard to
> use and read. And we need to do this for eventually for moving to use
> values.
> 
> This change is done one machine at a time, and can be easily reverted
> as needed in case of unexpected trouble. The old macro is still working,
> and we're planning to keep it around until we eventually change to use

Merged, thanks!


-Olof
