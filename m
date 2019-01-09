From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Date: Wed, 9 Jan 2019 19:04:48 +0100
Message-ID: <CAKfTPtBGh+ShbNCZLiYr4PZJooun7uctuQaomc40czvAk5Yizg@mail.gmail.com>
References: <20190108213743.GN5544@atomide.com> <20190109014218.GA8363@linaro.org>
 <20190109111703.GA28605@lenoch> <CAKfTPtBvzZvJNxBRMbGbNFBYG0-pAR-P7X2=KrBWH01OMWvJYA@mail.gmail.com>
 <20190109115824.GA1353@lenoch> <CAKfTPtAAgYYW8A1LDg18bM=5vCAMDbQ05APp9QWSaifW=F0SgQ@mail.gmail.com>
 <20190109133337.GA13579@lenoch> <CAKfTPtAsENRKh_wTFXCLW2_MdMBug+tV2KtjC7x6RigN7hgPmw@mail.gmail.com>
 <20190109160736.GA7416@lenoch> <CAKfTPtBnNA6knrsHsZXeaotBSn5mS12xNWNUKdSwZ1EUvueQkA@mail.gmail.com>
 <20190109172623.GB1711@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109172623.GB1711@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 9 Jan 2019 at 18:26, Ladislav Michl <ladis@linux-mips.org> wrote:
>
> On Wed, Jan 09, 2019 at 05:32:31PM +0100, Vincent Guittot wrote:
> > On Wed, 9 Jan 2019 at 17:07, Ladislav Michl <ladis@linux-mips.org> wrote:
> > >
> > > On Wed, Jan 09, 2019 at 03:12:25PM +0100, Vincent Guittot wrote:
> > > > Please keep all thread list when replying :-)
> > >
> > > Ahh, sorry for that...
> > > [snip]
> > > > On Wed, 9 Jan 2019 at 14:33, Ladislav Michl <ladis@linux-mips.org> wrote:
> > > > > I agree, but it doea all the magic correctly, so you won't need
> > > > > to touch that code is ktime_t changes (I know, unlikely..)
> > > >
> > > > But the current implementation doesn't care of any changes in ktime_t
> > > > as it uses raw ns
> > >
> > > Fair enough, so let's go back to:
> >
> > This one looks good for me
>
> Lets split is for 'comments fix' patch, which was just send and 'the rest'.
> Now, 'the rest' can either be v2 of your "PM/runtime: Fix autosuspend_delay on
> 32bits arch" or will wait for 5.1. You decide :)

I don't really mind.

Rafael,
Do you prefer to only take the fix for u64 casting problem or do you
prefer to also take the optimization below in one single patch ?


>
> > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > index 70624695b6d5..e61ee9b47a26 100644
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -121,7 +121,7 @@ static void pm_runtime_cancel_pending(struct device *dev)
> > >   * Compute the autosuspend-delay expiration time based on the device's
> > >   * power.last_busy time.  If the delay has already expired or is disabled
> > >   * (negative) or the power.use_autosuspend flag isn't set, return 0.
> > > - * Otherwise return the expiration time in jiffies (adjusted to be nonzero).
> > > + * Otherwise return the expiration time in nanoseconds (adjusted to be nonzero).
> > >   *
> > >   * This function may be called either with or without dev->power.lock held.
> > >   * Either way it can be racy, since power.last_busy may be updated at any time.
> > > @@ -129,24 +129,21 @@ static void pm_runtime_cancel_pending(struct device *dev)
> > >  u64 pm_runtime_autosuspend_expiration(struct device *dev)
> > >  {
> > >         int autosuspend_delay;
> > > -       u64 last_busy, expires = 0;
> > > -       u64 now = ktime_to_ns(ktime_get());
> > > +       u64 expires;
> > >
> > >         if (!dev->power.use_autosuspend)
> > > -               goto out;
> > > +               return 0;
> > >
> > >         autosuspend_delay = READ_ONCE(dev->power.autosuspend_delay);
> > >         if (autosuspend_delay < 0)
> > > -               goto out;
> > > -
> > > -       last_busy = READ_ONCE(dev->power.last_busy);
> > > +               return 0;
> > >
> > > -       expires = last_busy + autosuspend_delay * NSEC_PER_MSEC;
> > > -       if (expires <= now)
> > > -               expires = 0;    /* Already expired. */
> > > +       expires  = READ_ONCE(dev->power.last_busy);
> > > +       expires += NSEC_PER_MSEC * (u64)autosuspend_delay;
> > > +       if (expires > ktime_to_ns(ktime_get()))
> > > +               return expires; /* Expires in the future */
> > >
> > > - out:
> > > -       return expires;
> > > +       return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(pm_runtime_autosuspend_expiration);
> > >
> > > Which gives for arm:
> > > 00000480 <pm_runtime_autosuspend_expiration>:
> > >      480:       e92d41f0        push    {r4, r5, r6, r7, r8, lr}
> > >      484:       e5d030d1        ldrb    r3, [r0, #209]  ; 0xd1
> > >      488:       e3130004        tst     r3, #4
> > >      48c:       0a00000c        beq     4c4 <pm_runtime_autosuspend_expiration+0x44>
> > >      490:       e59030e4        ldr     r3, [r0, #228]  ; 0xe4
> > >      494:       e3530000        cmp     r3, #0
> > >      498:       ba000009        blt     4c4 <pm_runtime_autosuspend_expiration+0x44>
> > >      49c:       e28050e8        add     r5, r0, #232    ; 0xe8
> > >      4a0:       e8950030        ldm     r5, {r4, r5}
> > >      4a4:       e59f2030        ldr     r2, [pc, #48]   ; 4dc <pm_runtime_autosuspend_expiration+0x5c>
> > >      4a8:       e0e54392        smlal   r4, r5, r2, r3
> > >      4ac:       ebfffffe        bl      0 <ktime_get>
> > >      4b0:       e1550001        cmp     r5, r1
> > >      4b4:       01540000        cmpeq   r4, r0
> > >      4b8:       e1a06004        mov     r6, r4
> > >      4bc:       e1a07005        mov     r7, r5
> > >      4c0:       8a000001        bhi     4cc <pm_runtime_autosuspend_expiration+0x4c>
> > >      4c4:       e3a06000        mov     r6, #0
> > >      4c8:       e3a07000        mov     r7, #0
> > >      4cc:       e1a00006        mov     r0, r6
> > >      4d0:       e1a01007        mov     r1, r7
> > >      4d4:       e8bd41f0        pop     {r4, r5, r6, r7, r8, lr}
> > >      4d8:       e12fff1e        bx      lr
> > >      4dc:       000f4240        .word   0x000f4240
> > >
> > > And x86:
> > > 0000000000000230 <pm_runtime_autosuspend_expiration.part.0>:
> > >      230:       8b 87 a4 01 00 00       mov    0x1a4(%rdi),%eax
> > >      236:       53                      push   %rbx
> > >      237:       85 c0                   test   %eax,%eax
> > >      239:       78 1e                   js     259 <pm_runtime_autosuspend_expiration.part.0+0x29>
> > >      23b:       48 63 d8                movslq %eax,%rbx
> > >      23e:       48 8b 97 a8 01 00 00    mov    0x1a8(%rdi),%rdx
> > >      245:       48 69 db 40 42 0f 00    imul   $0xf4240,%rbx,%rbx
> > >      24c:       48 01 d3                add    %rdx,%rbx
> > >      24f:       e8 00 00 00 00          callq  254 <pm_runtime_autosuspend_expiration.part.0+0x24>
> > >      254:       48 39 c3                cmp    %rax,%rbx
> > >      257:       77 02                   ja     25b <pm_runtime_autosuspend_expiration.part.0+0x2b>
> > >      259:       31 db                   xor    %ebx,%ebx
> > >      25b:       48 89 d8                mov    %rbx,%rax
> > >      25e:       5b                      pop    %rbx
> > >      25f:       c3                      retq
> > >
> > > 00000000000002a0 <pm_runtime_autosuspend_expiration>:
> > >      2a0:       f6 87 91 01 00 00 04    testb  $0x4,0x191(%rdi)
> > >      2a7:       74 02                   je     2ab <pm_runtime_autosuspend_expiration+0xb>
> > >      2a9:       eb 85                   jmp    230 <pm_runtime_autosuspend_expiration.part.0>
> > >      2ab:       31 c0                   xor    %eax,%eax
> > >      2ad:       c3                      retq
> > >      2ae:       66 90                   xchg   %ax,%ax
> > >
> > >
> > > [snip]
> > > > > Well, main concern was not to call ktime_get at the beginning of function
> > > > > as it is not too cheap.
> > > >
> > > > Doesn't the compiler optimize that to just before the test ?
> > >
> > > No (compare with above). And it is also almost certain that someone will run
> > > script and send "...do not needlesly initialize..." patch :)
> > >
> > > gcc version 8.2.1 20181130 (OSELAS.Toolchain-2018.12.0 8-20181130)
> > >
> > > 00000110 <pm_runtime_autosuspend_expiration>:
> > >      110:       e92d41f0        push    {r4, r5, r6, r7, r8, lr}
> > >      114:       e1a06000        mov     r6, r0
> > >      118:       ebfffffe        bl      0 <ktime_get>
> > >      11c:       e5d630d1        ldrb    r3, [r6, #209]  ; 0xd1
> > >      120:       e3130004        tst     r3, #4
> > >      124:       0a00000d        beq     160 <pm_runtime_autosuspend_expiration+0x50>
> > >      128:       e596c0e4        ldr     ip, [r6, #228]  ; 0xe4
> > >      12c:       e35c0000        cmp     ip, #0
> > >      130:       ba00000a        blt     160 <pm_runtime_autosuspend_expiration+0x50>
> > >      134:       e28630e8        add     r3, r6, #232    ; 0xe8
> > >      138:       e893000c        ldm     r3, {r2, r3}
> > >      13c:       e1a05001        mov     r5, r1
> > >      140:       e1a04000        mov     r4, r0
> > >      144:       e59f002c        ldr     r0, [pc, #44]   ; 178 <pm_runtime_autosuspend_expiration+0x68>
> > >      148:       e0010c90        mul     r1, r0, ip
> > >      14c:       e0926001        adds    r6, r2, r1
> > >      150:       e0a37fc1        adc     r7, r3, r1, asr #31
> > >      154:       e1550007        cmp     r5, r7
> > >      158:       01540006        cmpeq   r4, r6
> > >      15c:       3a000001        bcc     168 <pm_runtime_autosuspend_expiration+0x58>
> > >      160:       e3a06000        mov     r6, #0
> > >      164:       e3a07000        mov     r7, #0
> > >      168:       e1a00006        mov     r0, r6
> > >      16c:       e1a01007        mov     r1, r7
> > >      170:       e8bd41f0        pop     {r4, r5, r6, r7, r8, lr}
> > >      174:       e12fff1e        bx      lr
> > >      178:       000f4240        .word   0x000f4240
