From: Nathan Ladd <nathanladd@gmail.com>
Subject: USB storage device
Date: Thu, 26 Jan 2006 12:44:54 -0600
Message-ID: <edea273a0601261044v43ee60f8nae64e05d7e28f76e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I'm having a problem with using a mass storage device with the OMAP.=20
I've encountered the same problem with both the newest 2.6.15-omap2
kernel, as well as a slightly older 2.6.14 which I've been using.  I
have indeed had to set that CONFIG_OMAP_RESET_CLOCKS to undefined.

I'm not using any of the DSP gateway devices, and haven't modified the
kernel at all.  I've used an arm-linux-* toolchain (3.4.4) I've
downloaded from the net (it's referred to in the OSK Newbie Guide), as
well as a root filesystem from the net.

The problem is that I can't *reliably* transfer files to and from the
USB storage device.  With 2-3 MB files, I can usually transfer at
least 20-30 files in a row (usually more), and then the whole system
just hangs (no backtrace, no "kernel badness," it simply stops doing
anything).  With 5-6 MB files, I'm lucky if I can get 3 transfers in.

The procedure is simply to mount the device, copy a file into /tmp
(tmpfs; I have verified that I can create 5 MB files and delete them
over and over without hanging), copy the file back to the usb device,
and then unmount it.  Then I repeat the procedure over and over.  If
the hang happens during the file copy, the activity led of the storage
device will keep blinking.

I've also reproduced this with DSP gateway and some simple DSP code
running a main loop, which simply sets some GPIO pins high and low.=20
After the mass storage transfers cause hanging, I notice the GPIO pins
stop changing state, indicating that the DSP is also hung.

I've tried swapping the OSK board, as well as the mass storage device.
 No change.  Has anyone here had success with getting mass storage to
work?  If so, could you tell me your exact kernel/toolchain versions?
