From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/2] ARM: OMAP2+: Fix device node reference counts
Date: Sat, 4 Mar 2017 08:29:00 -0800
Message-ID: <20170304162900.GA20572@atomide.com>
References: <1488639731-8047-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1488639731-8047-1-git-send-email-linux@roeck-us.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>, Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org, Qi Hou <qi.hou@windriver.com>, linux-omap@vger.kernel.org, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [170304 07:04]:
> After commit 0549bde0fcb1 ("of: fix of_node leak caused in
> of_find_node_opts_by_path"), the following error may be
> reported when running omap images.
> 
> OF: ERROR: Bad of_node_put() on /ocp@68000000
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.10.0-rc7-next-20170210 #1
> Hardware name: Generic OMAP3-GP (Flattened Device Tree)
> [<c0310604>] (unwind_backtrace) from [<c030bbf4>] (show_stack+0x10/0x14)
> [<c030bbf4>] (show_stack) from [<c05add8c>] (dump_stack+0x98/0xac)
> [<c05add8c>] (dump_stack) from [<c05af1b0>] (kobject_release+0x48/0x7c)
> [<c05af1b0>] (kobject_release)
> 	from [<c0ad1aa4>] (of_find_node_by_name+0x74/0x94)
> [<c0ad1aa4>] (of_find_node_by_name)
> 	from [<c1215bd4>] (omap3xxx_hwmod_is_hs_ip_block_usable+0x24/0x2c)
> [<c1215bd4>] (omap3xxx_hwmod_is_hs_ip_block_usable) from
> [<c1215d5c>] (omap3xxx_hwmod_init+0x180/0x274)
> [<c1215d5c>] (omap3xxx_hwmod_init)
> 	from [<c120faa8>] (omap3_init_early+0xa0/0x11c)
> [<c120faa8>] (omap3_init_early)
> 	from [<c120fb2c>] (omap3430_init_early+0x8/0x30)
> [<c120fb2c>] (omap3430_init_early)
> 	from [<c1204710>] (setup_arch+0xc04/0xc34)
> [<c1204710>] (setup_arch) from [<c1200948>] (start_kernel+0x68/0x38c)
> [<c1200948>] (start_kernel) from [<8020807c>] (0x8020807c)
> 
> of_find_node_by_name() drops the reference to the passed device node.
> The commit referenced above exposes this problem.
> 
> To fix the problem, use of_get_child_by_name() instead of
> of_find_node_by_name(); of_get_child_by_name() does not drop
> the reference count of passed device nodes. While semantically
> different, we only look for immediate children of the passed
> device node, so of_get_child_by_name() is a more appropriate
> function to use anyway.
> 
> Release the reference to the device node obtained with
> of_get_child_by_name() after it is no longer needed to avoid
> another device node leak.
> 
> While at it, clean up the code and change the return type of
> omap3xxx_hwmod_is_hs_ip_block_usable() to bool to match its use
> and the return type of of_device_is_available().
> 
> Cc: Qi Hou <qi.hou@windriver.com>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3: Add commit SHA of patch exposing the problem
>     Clarify that it does not cause the problem but exposes it
>     Split into two patches
> v2: Change subject ('Grab reference to device nodes where needed'
>     didn't really cover all the changes made)
>     Use of_get_child_by_name() instead of of_find_node_by_name()
>     Drop references to device nodes as needed
>     Change return type of omap3xxx_hwmod_is_hs_ip_block_usable()
>     to bool

Thanks for the updates, applying both into omap-for-v4.11/fixes.

Regards,

Tony
