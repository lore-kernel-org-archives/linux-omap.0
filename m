From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Broken N770, was: I2C zero length transfers and SMBUS_QUICK
Date: Mon, 06 Nov 2006 19:33:03 +0100
Message-ID: <454F7FDF.1080101@gmail.com>
References: <20061105194915.12776.qmail@web37903.mail.mud.yahoo.com>
	<85d580lv53.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <85d580lv53.fsf@orfeo.duckcorp.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Seems that this is the month of mail subject change ;)

Arnaud Patard (Rtp) wrote:
> Komal Shah <komal_shah802003@yahoo.com> writes:
>>Yes, we need working OMAPs and I don't know if it already broke n770
>>too. ...
>>
...
> the current kernel is broken on the n770. It won't even build.

Thanks for the hint! With patch previously sent
n770_defconfig should compile again.

However, still some warnings in omap-hw.c (unused
omap_nand_write_byte), retu-user.c, tahvo-user.c,
tahvo-usb.c (all my new friend "ignoring return value") and
sti-console.c ("value computed is not used").

> Long explanation :
> There are some obvious breakages that are not fixed. For instance, look
> at the omap-hw patch I sent. 

It is already applied.

> I have some other patches for the build but
> the kernel is oopsing later in the boot stage when udev plays with the
> uevents in the spi layer... And there are probably more breakages :(

Is there any way to test self compiled kernel on N770
without breaking flashed SW/image? Anything like download to
RAM, e.g. used by uboots TFTP download on OSK?

Regards

Dirk
