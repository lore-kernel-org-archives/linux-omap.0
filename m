From: Sean Young <sean@mess.org>
Subject: Re: [WARNING: A/V UNSCANNABLE][Merge tag 'media/v4.11-1' of git]
 ff58d005cd: BUG: unable to handle kernel NULL pointer dereference at
 0000039c
Date: Sat, 25 Feb 2017 11:14:25 +0000
Message-ID: <20170225111424.GA7659@gofer.mess.org>
References: <58b07b30.9XFLj9Hhl7F6HMc2%fengguang.wu@intel.com>
 <CA+55aFytXj+TZ_TanbxcY0KgRTrV7Vvr=fWON8tioUGmYHYiNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFytXj+TZ_TanbxcY0KgRTrV7Vvr=fWON8tioUGmYHYiNA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ruslan Ruslichenko <rruslich@cisco.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, kernel@stlinux.com, wfg@linux.intel.com, LKML <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-mediatek@lists.infradead.org, Linux LED Subsystem <linux-leds@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-amlogic@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, kernel test robot <fengguang.wu@intel.com>, LKP <lkp@01.org>, Ingo Molnar <mingo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 24, 2017 at 11:15:51AM -0800, Linus Torvalds wrote:
> Added more relevant people. I've debugged the immediate problem below,
> but I think there's another problem that actually triggered this.
> 
> On Fri, Feb 24, 2017 at 10:28 AM, kernel test robot
> <fengguang.wu@intel.com> wrote:
> >
> > 0day kernel testing robot got the below dmesg and the first bad commit is
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >
> > commit ff58d005cd10fcd372787cceac547e11cf706ff6
> > Merge: 5ab3566 9eeb0ed
> >
> >     Merge tag 'media/v4.11-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> [...]
> > [    4.664940] rc rc0: lirc_dev: driver ir-lirc-codec (rc-loopback) registered at minor = 0
> > [    4.666322] BUG: unable to handle kernel NULL pointer dereference at 0000039c
> > [    4.666675] IP: serial_ir_irq_handler+0x189/0x410
> 
> This merge being fingered ends up being a subtle interaction with other changes.
> 
> Those "other changes" are (again) the interrupt retrigger code that
> was reverted for 4.10, and then we tried to merge them again this
> merge window.
> 
> Because the immediate cause is:
> 
> > [    4.666675] EIP: serial_ir_irq_handler+0x189/0x410
> > [    4.666675] Call Trace:
> > [    4.666675]  <IRQ>
> > [    4.666675]  __handle_irq_event_percpu+0x57/0x100
> > [    4.666675]  handle_irq_event_percpu+0x1d/0x50
> > [    4.666675]  handle_irq_event+0x32/0x60
> > [    4.666675]  handle_edge_irq+0xa5/0x120
> > [    4.666675]  handle_irq+0x9d/0xd0
> > [    4.666675]  </IRQ>
> > [    4.666675]  do_IRQ+0x5f/0x130
> > [    4.666675]  common_interrupt+0x33/0x38
> > [    4.666675] EIP: hardware_init_port+0x3f/0x190
> > [    4.666675] EFLAGS: 00200246 CPU: 0
> > [    4.666675] EAX: c718990f EBX: 00000000 ECX: 00000000 EDX: 000003f9
> > [    4.666675] ESI: 000003f9 EDI: 000003f8 EBP: c0065d98 ESP: c0065d84
> > [    4.666675]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
> > [    4.666675]  serial_ir_probe+0xbb/0x300
> > [    4.666675]  platform_drv_probe+0x48/0xb0
> ...
> 
> ie an interrupt came in immediately after the request_irq(), before
> all the data was properly set up, which then causes the interrupt
> handler to take a fault because it tries to access some field that
> hasn't even been set up yet.

Oh dear. I've pointed out others making the same mistake when doing code
reviews, clearly I need review my own code better.

> 
> The code line is helpful, the faulting instruction is
> 
>       mov    0x39c(%rax),%eax   <--- fault
>       call ..
>       mov    someglobalvar,%edx
> 
> which together with the supplied config file makes me able to match it
> up with the assembly generation around it:
> 
>         inb %dx, %al    # tmp254, value
>         andb    $1, %al #, tmp255
>         testb   %al, %al        # tmp255
>         je      .L233   #,
>   .L215:
>         movl    serial_ir+8, %eax       # serial_ir.rcdev, serial_ir.rcdev
>         xorl    %edx, %edx      # _66->timeout
>         movl    924(%eax), %eax # _66->timeout, _66->timeout
>         call    nsecs_to_jiffies        #
>         movl    jiffies, %edx   # jiffies, jiffies.33_70
>         addl    %eax, %edx      # _69, tmp259
>         movl    $serial_ir+16, %eax     #,
>         call    mod_timer       #
>         movl    serial_ir+8, %eax       # serial_ir.rcdev,
>         call    ir_raw_event_handle     #
>         movl    $1, %eax        #, <retval>
> 
> so it's that "serial_ir.rcdev->timeout" access that faults. So this is
> the faulting source code:
> 
> drivers/media/rc/serial_ir.c: 402
> 
>         mod_timer(&serial_ir.timeout_timer,
>                   jiffies + nsecs_to_jiffies(serial_ir.rcdev->timeout));
> 
>         ir_raw_event_handle(serial_ir.rcdev);
> 
>         return IRQ_HANDLED;
> 
> and serial_ir.rcdev is NULL when ti tries to look up the timeout.

ir_raw_event_handle() call will also go bang if passed a null pointer, so
this problem existed before (since v4.10).

Thanks for debugging this, I'll send a patch as a reply to this email.


Sean
