From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [GIT PULL] omap fixes against v4.6-rc2
Date: Fri, 22 Apr 2016 08:38:37 -0700
Message-ID: <7hinz94ps2.fsf@baylibre.com>
References: <20160408191854.GZ16484@atomide.com>
 <20160419145400.GC5995@atomide.com>
 <20160419195147.GE5973@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160419195147.GE5973@atomide.com> (Tony Lindgren's message of
 "Tue, 19 Apr 2016 12:51:47 -0700")
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

Tony Lindgren <tony@atomide.com> writes:

> * Tony Lindgren <tony@atomide.com> [160419 07:55]:
>> * Tony Lindgren <tony@atomide.com> [160408 12:22]:
>> >       ARM: OMAP: Catch callers of revision information prior to it being populated
>> 
>> And this one causes bogus runtime warnings with other SoCs
>> as reported by Guenter Roeck. I'll revert this and post
>> an updated pull request shortly.
>
> And below is the updated pull request with just the above
> commit reverted.
>
> Regards,
>
> Tony
>
> 8< -------------------
> The following changes since commit 9735a22799b9214d17d3c231fe377fc852f042e9:
>
>   Linux 4.6-rc2 (2016-04-03 09:09:40 -0500)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.6/fixes-rc2-v2-signed
>
> for you to fetch changes up to 3d51ae172d759198b2e47e104c31a92d20d17927:
>
>   Revert "ARM: OMAP: Catch callers of revision information prior to it being populated" (2016-04-19 08:01:05 -0700)
>
> ----------------------------------------------------------------
> Fixes for omaps against v4.6-rc2, mostly to fix suspend for beagle-x15
> that broke when we added runtime based SoC revision detection earlier.
>
> It seems suspend worked earlier as things were only partially initialized,
> while now we initialize things properly for dra7.
>
> Note that the "ARM: OMAP: Catch callers of revision information prior
> to it being populated" had to be reverted as it caused bogus warnings
> for other SoCs because omap initcalls bail out based on revision being
> set to 0 for other SoCs. These initcalls will mostly just disappear
> when we drop support for omap3 legacy booting.
>
> Also included is a fix for dra7 sys_32k_ck clock source that is not
> enabled on boot making system fall back to using emulated clock.
>
> ----------------------------------------------------------------

Applied to fixes,

Kevin
