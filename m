From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 1/2] omap2plus_defconfig changes for v5.5
Date: Wed, 23 Oct 2019 13:22:47 -0700
Message-ID: <20191023202247.wb2jzwvek7u5korx@localhost>
References: <pull-1571853258-16998@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1571853258-16998@atomide.com>
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
Cc: soc@kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 23, 2019 at 10:54:48AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 96d49bbfe6c1a6bb43ccd00fb87aca100e32e5e2:
> 
>   ARM: omap2plus_defconfig: Fix selected panels after generic panel changes (2019-10-03 09:44:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.5/defconfig-signed
> 
> for you to fetch changes up to ec2b31267263cd7d5a7567d315f839796c2a8c87:
> 
>   configs: omap2plus: Enable VIDEO_MT9P031 module (2019-10-22 09:11:03 -0700)
> 
> ----------------------------------------------------------------
> Defconfig changes for omap2plus_defconfig for v5.5
> 
> A series of changes from Adam Ford to update for removed and moved items,
> and then enable crypto devices and MT9P031 video as loadable modules.
> 
> Looks like I missed unifying the subject line for one commit, but I did
> not want to mess with the commit after pushing it out.
> 
> ----------------------------------------------------------------
> Adam Ford (4):
>       ARM: omap2plus_defconfig: Update for removed items
>       ARM: omap2plus_defconfig: Update for moved item
>       ARM: omap2plus_defconfig: Enable HW Crypto engine modules
>       configs: omap2plus: Enable VIDEO_MT9P031 module

Looks like this branch had a minor conflict with one of your fixes branches.
Easy to patch up, but feel free to use your fixes as a base for the topics if
needed.


-Olof
