From: "Will Deacon" <will.deacon@arm.com>
Subject: RE: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Mon, 23 Aug 2010 17:59:17 +0100
Message-ID: <8545.01283397458$1282582799@news.gmane.org>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100817104414.19061.38999.stgit@baageli.muru.com>
Content-Language: en-gb
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Tony Lindgren' <tony@atomide.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, bryan.wu@canonical.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,

> Hi all,
> 
> Here are some experimental patches to allow booting ARMv7 SMP
> kernel on UP to some extent. Posting these early in case it is
> of any help as I know at least Bryan Wu is working on similar
> issues.
> 
> The patches are very much work in progress, and does not quite
> boot to init yet so there's all kinds of things to fix. But at
> least these patches allow booting to the point where the fixing
> issues might be a bit easier.. Currently it boots to the point
> where there are tons of "WARNING: at mm/percpu-vm.c:320 pcpu_alloc"
> prints.

I've got some similar hacks for the RealView boards which I've used
to build a Kernel that can boot on the PB-A8 and PBX-A9. Whilst this
is the wrong way of going about solving the problem [Russell's code
patching is a lot neater and more scaleable] you might be interested
in looking at the code anyway:

http://www.linux-arm.org/git?p=linux-2.6-wd.git;a=shortlog;h=refs/heads/smp-up-hacks

Only v7 cores are supported and TEX remapping is used to avoid having
to worry about setting the shared attribute at runtime. Yuck!

Will
