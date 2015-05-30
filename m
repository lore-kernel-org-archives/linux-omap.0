From: Jeroen Hofstee <linux-arm@myspectrum.nl>
Subject: Re: OMAP baseline test results for v4.1-rc5
Date: Sat, 30 May 2015 17:56:35 +0200
Message-ID: <5569DDB3.2040802@myspectrum.nl>
References: <alpine.DEB.2.02.1505301534250.26925@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.02.1505301534250.26925@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org
List-Id: linux-omap@vger.kernel.org

Hello Paul,

On 30-05-15 17:50, Paul Walmsley wrote:
> Here are some basic OMAP test results for Linux v4.1-rc5.
> Logs and other details at:
>
>      http://www.pwsan.com/omap/testlogs/test_v4.1-rc5/20150529162206/
>

The cmt3517 seems to have these some In-Band errors.
Do you happen to know where these are coming from?

Regards,
Jeroen

[    0.476773] In-band Error seen by MPU  at address 0
[    0.476802] ------------[ cut here ]------------
[    0.476848] WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_smx.c:166 
omap3_l3_app_irq+0xcc/0x124()
[    0.476865] Modules linked in:
[    0.476899] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
4.1.0-rc5-143184-gba155e2 #1
[    0.476916] Hardware name: Generic AM3517 (Flattened Device Tree)
[    0.476964] [<c0016504>] (unwind_backtrace) from [<c0012a44>] 
(show_stack+0x10/0x14)
[    0.476997] [<c0012a44>] (show_stack) from [<c05ddbd4>] 
(dump_stack+0x80/0x9c)
[    0.477028] [<c05ddbd4>] (dump_stack) from [<c004000c>] 
(warn_slowpath_common+0x78/0xb4)
[    0.477056] [<c004000c>] (warn_slowpath_common) from [<c0040064>] 
(warn_slowpath_null+0x1c/0x24)
[    0.477083] [<c0040064>] (warn_slowpath_null) from [<c0370ed0>] 
(omap3_l3_app_irq+0xcc/0x124)
[    0.477121] [<c0370ed0>] (omap3_l3_app_irq) from [<c009804c>] 
(handle_irq_event_percpu+0x64/0x204)
[    0.477150] [<c009804c>] (handle_irq_event_percpu) from [<c0098228>] 
(handle_irq_event+0x3c/0x5c)
[    0.477181] [<c0098228>] (handle_irq_event) from [<c009b09c>] 
(handle_level_irq+0xb4/0x13c)
[    0.477209] [<c009b09c>] (handle_level_irq) from [<c00978f0>] 
(generic_handle_irq+0x20/0x30)
[    0.477235] [<c00978f0>] (generic_handle_irq) from [<c0097a08>] 
(__handle_domain_irq+0x68/0xdc)
[    0.477263] [<c0097a08>] (__handle_domain_irq) from [<c0009480>] 
(omap_intc_handle_irq+0xb4/0xc4)
[    0.477299] [<c0009480>] (omap_intc_handle_irq) from [<c05e48a4>] 
(__irq_svc+0x44/0x5c)
[    0.477317] Exception stack(0xce0a3d00 to 0xce0a3d48)
[    0.477342] 3d00: 00000001 ce0a1138 00000000 ce0a0b80 60000153 
ce013c60 ce013c60 00000000
[    0.477365] 3d20: 0000001a 60000153 ce013c38 00000000 00000000 
ce0a3d48 c008dde8 c05e4424
[    0.477382] 3d40: 20000153 ffffffff
