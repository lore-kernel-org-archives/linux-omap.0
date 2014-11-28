From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC] i2c: omap: TEST: do IP reset during probe.
Date: Fri, 28 Nov 2014 14:13:51 -0800
Message-ID: <20141128221350.GW2817@atomide.com>
References: <1416685634-5864-3-git-send-email-al.kochet@gmail.com>
 <1417028722-29306-1-git-send-email-al.kochet@gmail.com>
 <7hzjbdd57j.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7hzjbdd57j.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [141126 13:27]:
> Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> 
> > NOT FOR UPSTREAM
> >
> > The patch checks if IP reset during probe could bring I2C bus
> > to a free state on omap2430 - omap3530 boards.
> >
> > I guess, IP hold one of I2C lines in a low state.
> > I guess, u-boot haven't sent a stop condition.
> >
> > The patch is rebased on branch 'i2c/for-next' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
> > (6e79807443cba7397cd855ed29d6faba51d4c893)
> >
> > Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Reported-by: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Tested-by: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> 
> Built for omap2plus_defconfig and tested on all my OMAP boards.  Results
> here:
> 
> http://people.linaro.org/~khilman/tmp/next-20141126-1-g760388ee02e4/arm-omap2plus_defconfig/

And below is the output from 2430sdp with linux next plus Alexander's
test patch. Looks like for some time 2430 i2c has not been behaving
reliably unless I force compatible to ti,omap2420-i2c instead of
ti,omap2430-i2c.. The output below is with ti,omap2430-i2c.

Regards,

Tony

8< -------------
[    0.913574] omap_i2c 48070000.i2c: init0: STAT=0x0000; IE=0x601f; CON=0x8000; SYSTEST=0x0000; SDA=00 [OI]; SCL=00 [OI] (omap_i2c_init:493)
[    1.931365] omap_i2c 48070000.i2c: timeout waiting for bus ready
[    1.931457] omap_i2c 48070000.i2c: init1: STAT=0x0000; IE=0x601f; CON=0x8000; SYSTEST=0x0000; SDA=00 [OI]; SCL=00 [OI] (omap_i2c_init:497)
[    1.931518] omap_i2c 48070000.i2c: init1: bb_valid=0
[    2.949249] omap_i2c 48070000.i2c: timeout waiting for bus ready
[    2.949340] omap_i2c 48070000.i2c: init2: STAT=0x0000; IE=0x601f; CON=0x8000; SYSTEST=0x0000; SDA=00 [OI]; SCL=00 [OI] (omap_i2c_init:504)
[    2.949401] omap_i2c 48070000.i2c: init2: bb_valid=0
[    2.952941] omap_i2c 48070000.i2c: bus 0 rev3.3 at 100 kHz (rev 00000036)
[    2.969299] omap_i2c 48072000.i2c: init0: STAT=0x0000; IE=0x601f; CON=0x8000; SYSTEST=0x0000; SDA=00 [OI]; SCL=00 [OI] (omap_i2c_init:493)
[    3.987091] omap_i2c 48072000.i2c: timeout waiting for bus ready
[    3.987182] omap_i2c 48072000.i2c: init1: STAT=0x0000; IE=0x601f; CON=0x8000; SYSTEST=0x0000; SDA=00 [OI]; SCL=00 [OI] (omap_i2c_init:497)
[    3.987243] omap_i2c 48072000.i2c: init1: bb_valid=0
[    5.004974] omap_i2c 48072000.i2c: timeout waiting for bus ready
[    5.005096] omap_i2c 48072000.i2c: init2: STAT=0x0000; IE=0x601f; CON=0x8000; SYSTEST=0x0000; SDA=00 [OI]; SCL=00 [OI] (omap_i2c_init:504)
[    5.005126] omap_i2c 48072000.i2c: init2: bb_valid=0
[    5.017517] omap_i2c 48072000.i2c: bus 1 rev3.3 at 100 kHz (rev 00000036)
[    7.555419] twl4030_keypad 48072000.i2c:twl@48:keypad: OF: linux,keymap property not defined in /ocp/i2c@48072000/twl@48/keypad
[    7.567626] twl4030_keypad 48072000.i2c:twl@48:keypad: Failed to build keymap
[    7.575439] twl4030_keypad: probe of 48072000.i2c:twl@48:keypad failed with error -2
[    7.599639] input: twl4030_pwrbutton as /devices/platform/ocp/48072000.i2c/i2c-1/1-0048/48072000.i2c:twl@48:pwrbutton/input/input1
[    7.624450] twl_rtc 48072000.i2c:twl@48:rtc: Power up reset detected.
[    7.631988] twl_rtc 48072000.i2c:twl@48:rtc: Enabling TWL-RTC
[    7.655456] twl_rtc 48072000.i2c:twl@48:rtc: rtc core: registered 48072000.i2c:twl@48 as rtc0
[    7.923187] i2c /dev entries driver
[    8.246795] twl_rtc 48072000.i2c:twl@48:rtc: hctosys: unable to read the hardware clock
[    9.675994] omap_i2c 48072000.i2c: controller timed out
[   10.704010] omap_i2c 48072000.i2c: controller timed out
[   11.734069] omap_i2c 48072000.i2c: controller timed out
root@omap2430sdp:/# [   12.823638] omap_i2c 48072000.i2c: controller timed out
[   12.834747] twl4030: I2C error -110 reading PIH ISR
