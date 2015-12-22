From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/4] omap changes for ti81xx devices and minimal
 dra62x j5eco-evm support
Date: Tue, 22 Dec 2015 14:53:31 -0800
Message-ID: <20151222225331.GI30172@localhost>
References: <pull-1450731519-787330>
 <567869f7.9440620a.dbdb.65d1SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <567869f7.9440620a.dbdb.65d1SMTPIN_ADDED_BROKEN@mx.google.com>
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

Hi Tony,

On Mon, Dec 21, 2015 at 01:06:35PM -0800, Tony Lindgren wrote:
> The following changes since commit d893656e61040f3ff7b5f72a986052a348f3c94e:
> 
>   ARM: OMAP2+: Remove useless check for legacy booting for dm814x (2015-12-09 16:53:46 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.5/81xx-devices
> 
> for you to fetch changes up to 8f2cf92a912ca7173d29c045d225588c9630ed94:
> 
>   ARM: dts: Add usb support for j5-eco evm (2015-12-21 10:43:29 -0800)
> 
> ----------------------------------------------------------------
> Now with dm814x support fixed up enough where we can make use of some clocks,
> we can adds some more basic devices for dm814x. And we can also add minimal
> support for dra62x j5eco-evm that is another ti81xx variant related to dm814x.
> 
> I would have rather merged this series toghether with the ADPLL clock driver,
> and was waiting for that to get merged before sending out these patches. But
> the ADPLL clock driver can be merged separately, and at least dm814x-evm,
> dra62x-j5eco-evm, and t410 all boot with this series alone. So let's merge
> these patches separately as that allows people to do development on these
> platforms for other device drivers using the mainline kernel.
> 
> Note that this series depends on the earlier 81xx-fixes and omap initcall
> changes. It also depends on the DMA commit ae0add740cd0 that's already in
> mainline. As this series is mostly DTS changes with a few related hwmod
> changes, it's probably best merged along with the other DTS changes.

I'm a little puzzled by how you chose to organize this branch. We usually
ask for SoC enablement and new DT files separately. Is there a reason you
couldn't split out the SoC pieces and include those in the soc branch, and
leave the DT contents for this one?


-Olof
