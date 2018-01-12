From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PM regression in next
Date: Thu, 11 Jan 2018 16:45:37 -0800
Message-ID: <20180111164537.79165ac8918e6d38e1837062@linux-foundation.org>
References: <20180112000037.GA3875@atomide.com>
 <20180111161837.f1c1d891a1b80d97e30a9b1b@linux-foundation.org>
 <20180112002322.GB3875@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180112002322.GB3875@atomide.com>
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
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, 11 Jan 2018 16:23:22 -0800 Tony Lindgren <tony@atomide.com> wrote:

> * Andrew Morton <akpm@linux-foundation.org> [180112 00:18]:
> > On Thu, 11 Jan 2018 16:01:13 -0800 Tony Lindgren <tony@atomide.com> wrote:
> > 
> > > Hi all,
> > > 
> > > I'm seeing a considerable idle power consumption regression in
> > > Linux next, with power consumption for my idle test system going
> > > to 17.5mW compared to the usual 8mW on my test device.
> > > 
> > > Git bisect points to merge commit e130bc1d00a4 ("Merge branch
> > > 'akpm-current/current'") being the first bad commit.
> > > 
> > > I have also verified that commit 70286688e5ad ("ipc/mqueue.c:
> > > have RT tasks queue in by priority in wq_add()") is good, and
> > > commit e2d7fe89e8ae ("Merge remote-tracking branch
> > > 'init_task/init_task'") is good.
> > 
> > Do you mean that everything up to and including 70286688e5ad
> > ("ipc/mqueue.c: have RT tasks queue in by priority in wq_add()") is
> > good?
> 
> Yes I'm not seeing the regression in your branch at commit
> 70286688e5ad. I'm seeing it only with the merge commit
> e130bc1d00a4.
> 

That's weird.  All I'm seeing between 70286688e5ad and end-of-mm is:

tools-objtool-makefile-dont-assume-sync-checksh-is-executable.patch
ipc-mqueue-add-missing-error-code-in-init_mqueue_fs.patch

vfs-remove-might_sleep-from-clear_inode.patch

mm-remove-duplicate-includes.patch

mm-remove-unneeded-kallsyms-include.patch
hrtimer-remove-unneeded-kallsyms-include.patch
genirq-remove-unneeded-kallsyms-include.patch

mm-memblock-memblock_is_map-region_memory-can-be-boolean.patch
lib-lockref-__lockref_is_dead-can-be-boolean.patch
kernel-cpuset-current_cpuset_is_being_rebound-can-be-boolean.patch
kernel-resource-iomem_is_exclusive-can-be-boolean.patch
kernel-module-module_is_live-can-be-boolean.patch
kernel-mutex-mutex_is_locked-can-be-boolean.patch
crash_dump-is_kdump_kernel-can-be-boolean.patch

fix-const-confusion-in-certs-blacklist.patch
fix-read-buffer-overflow-in-delta-ipc.patch

kasan-rework-kconfig-settings.patch

sparc64-ng4-memset-32-bits-overflow.patch

lib-crc-ccitt-add-ccitt-false-crc16-variant.patch


And I don't see how any of those can cause this.  Did anything else
change, like context switch rates, interrupt rates, etc?
