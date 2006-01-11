From: Eduardo Bezerra <edubezval@gmail.com>
Subject: Speex encoder running on DSP through DSP Gateway
Date: Wed, 11 Jan 2006 11:18:39 -0400
Message-ID: <a0580c510601110718v4d6f1a74r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi all,


  I know that the issue below is related more to the DSP-GW community as
opposed to Linux-OMAP and I do apologise for posting it here, but DSP-GW
list seems to be populated sparringly and responses are really slow or
long term. I would therefore appreciate if someone has already seen this
issue and could give me a hint or two.

  I'm trying to run a speex encoder on the OSK 5912 DSP using
DSP Gateway.  This enconder is based on the speex library
that can be found in www.speex.org.

  The whole code to produce a single encoder using this library
plus the tokliBIOS library code resulted in a binary with
200KB of size. A simple frame coding step also requires
a stack size of 4K words. It also does about 12K words
of allocation (using malloc). These memory requirements
were analysed using valgrind tools.

  Because of these memory requirements, the DSP task needed some shared
memory. So, I added one memory space to put some data. The .cmd
of the DSP Task is:

/*
 * Data sections
 * */

-l tokliBIOScfg.cmd
-l tokliBIOS.cmd

MEMORY {
        PAGE 0: SARAM_D:     origin =3D 0x30000, len =3D 0x5000
}
SECTIONS {
        shared_data:    {} > SARAM_D PAGE 0
}

  However, as the application also needs more memory to
stack and heap, I also modified the tokliBIOScfg.tcf:

.
.
.

var myHeap =3D bios.MEM.create("MYHEAP");
myHeap.comment =3D "Speex Heap";
myHeap.base =3D 0x1a800;
myHeap.len =3D 0x8000;
myHeap.createHeap =3D true;
myHeap.space =3D "data";
myHeap.heapSize =3D 0x4000;

bios.MEM.MALLOCSEG =3D prog.get("MYHEAP");
bios.MEM.BIOSOBJSEG =3D prog.get("DARAM");
bios.MEM.STACKSEG =3D prog.get("MYHEAP");
bios.MEM.SYSSTACKSEG =3D prog.get("MYHEAP");

.
.
.
/*
 * TSK
 */
bios.TSK.ENABLETSK =3D true;
bios.TSK.STACKSEG =3D prog.get("MYHEAP");

  I did a static compilation of this task and it was fine. Before the
loading of the resulted binary, I executed the following commands on the
OSK board:

# dspctl kmem_reserve 0x20000

As in the .cmd file, it needs a TLB entry pointing to 0x30000, size
0x5000
# dspctl exmap 0x30000 0x5000

As in the .tcf file, it needs a TLB entry pointing to 0x35000, size
0x10000
# dspctl exmap 0x35000 0x10000


  So, I did the loading:

# dspctl start speex.out


  The loading was fine also. But when I run a user space program to
communicate to the DSP task through the DSP gateway device file, it
gets an error. The user space program only sends a ipbuffer a requests
another one. It sends and receives the ipbuffer without any problem.
And the user space application ends. The data produced by the encoder is
correct. The problem is that the kernel prints out a message indicating
that there is a mailbox message from a non-existing DSP task. After
that, the DSP task hangs out. The message error code is: BADTID.

  Any suggestion?

BR,

Eduardo Bezerra Valentin
