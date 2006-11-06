From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: Broken N770, was: I2C zero length transfers and SMBUS_QUICK
Date: Mon, 06 Nov 2006 20:49:11 +0100
Message-ID: <85zmb4iceg.fsf@orfeo.duckcorp.org>
References: <20061105194915.12776.qmail@web37903.mail.mud.yahoo.com>
	<85d580lv53.fsf@orfeo.duckcorp.org> <454F7FDF.1080101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <454F7FDF.1080101@gmail.com> (Dirk Behme's message of "Mon, 06
	Nov 2006 19:33:03 +0100")
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dirk Behme <dirk.behme@googlemail.com> writes:

> Seems that this is the month of mail subject change ;)

hehe :)

>
> Arnaud Patard (Rtp) wrote:
>> Komal Shah <komal_shah802003@yahoo.com> writes:
>>>Yes, we need working OMAPs and I don't know if it already broke n770
>>>too. ...
>>>
> ...
>> the current kernel is broken on the n770. It won't even build.
>
> Thanks for the hint! With patch previously sent
> n770_defconfig should compile again.

Sorry, that's wrong. I'm using an up2date git tree with origin
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git/
and I still need patches.

For instance : 
- there are still some users of pt_regs (patch sent some time ago)
- drivers/cbus/tahvo-usb.c is still using usb_otg.h. Patch not sent but
trivial to write.


>
> However, still some warnings in omap-hw.c (unused
> omap_nand_write_byte),

hmm.. yeah. My fault :(

>  retu-user.c, tahvo-user.c,
> tahvo-usb.c (all my new friend "ignoring return value") and
> sti-console.c ("value computed is not used").
>
>> Long explanation :
>> There are some obvious breakages that are not fixed. For instance, look
>> at the omap-hw patch I sent.
>
> It is already applied.
>
>> I have some other patches for the build but
>> the kernel is oopsing later in the boot stage when udev plays with the
>> uevents in the spi layer... And there are probably more breakages :(
>
> Is there any way to test self compiled kernel on N770
> without breaking flashed SW/image? Anything like download to
> RAM, e.g. used by uboots TFTP download on OSK?

yes, there is. That's what I'm using ^^

./flasher-2.0 -l -b -k <my_kernel>

But if you want to go a little bit further than the first lines of the
linuxrc file, you have to reintroduce the ioctl MEMSETOOBSEL in
mtdchar.c because the dsme/bme/cal-tools/libcal and friends from nokia
are using it. Unfortunately, when they're failing, they reboot your
device.
[ Playing with the r&d flags from the flasher won't help as the tools are
 failing before reading them. ]

>
> Regards
>
> Dirk

Regards,
Arnaud
