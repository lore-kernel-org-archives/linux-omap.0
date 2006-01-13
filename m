From: Eduardo Bezerra <edubezval@gmail.com>
Subject: Re: Speex encoder running on DSP through DSP Gateway
Date: Fri, 13 Jan 2006 16:25:33 -0400
Message-ID: <a0580c510601131225h6f4a0d02r@mail.gmail.com>
References: <a0580c510601110718v4d6f1a74r@mail.gmail.com>
	<20060114.010053.846937934.toshihiro.kobayashi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060114.010053.846937934.toshihiro.kobayashi@nokia.com>
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
To: "toshihiro.kobayashi@nokia.com" <toshihiro.kobayashi@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,


2006/1/13, toshihiro.kobayashi@nokia.com <toshihiro.kobayashi@nokia.com>:
> Hi,
>
> From: Eduardo Bezerra <edubezval@gmail.com>
> Subject: Speex encoder running on DSP through DSP Gateway
> Date: Wed, 11 Jan 2006 11:18:39 -0400
>
> >   I know that the issue below is related more to the DSP-GW community a=
s
> > opposed to Linux-OMAP and I do apologise for posting it here, but DSP-G=
W
> > list seems to be populated sparringly and responses are really slow or
> > long term.
>
> However, eventually I'm answering in any ways. :)
> I've been on the business trip followed by the vacation.
> Sorry for slow replies.
>
> >   I'm trying to run a speex encoder on the OSK 5912 DSP using
> > DSP Gateway.  This enconder is based on the speex library
> > that can be found in www.speex.org.
> >
> >   The whole code to produce a single encoder using this library
> > plus the tokliBIOS library code resulted in a binary with
> > 200KB of size. A simple frame coding step also requires
> > a stack size of 4K words. It also does about 12K words
> > of allocation (using malloc). These memory requirements
> > were analysed using valgrind tools.
> >
> >   Because of these memory requirements, the DSP task needed some shared
> > memory. So, I added one memory space to put some data. The .cmd
> > of the DSP Task is:
> >
> > /*
> >  * Data sections
> >  * */
> >
> > -l tokliBIOScfg.cmd
> > -l tokliBIOS.cmd
> >
> > MEMORY {
> >         PAGE 0: SARAM_D:     origin =3D 0x30000, len =3D 0x5000
> > }
> > SECTIONS {
> >         shared_data:    {} > SARAM_D PAGE 0
> > }
> >
> >   However, as the application also needs more memory to
> > stack and heap, I also modified the tokliBIOScfg.tcf:
> >
> > .
> > .
> > .
> >
> > var myHeap =3D bios.MEM.create("MYHEAP");
> > myHeap.comment =3D "Speex Heap";
> > myHeap.base =3D 0x1a800;
> > myHeap.len =3D 0x8000;
> > myHeap.createHeap =3D true;
> > myHeap.space =3D "data";
> > myHeap.heapSize =3D 0x4000;
> >
> > bios.MEM.MALLOCSEG =3D prog.get("MYHEAP");
> > bios.MEM.BIOSOBJSEG =3D prog.get("DARAM");
> > bios.MEM.STACKSEG =3D prog.get("MYHEAP");
> > bios.MEM.SYSSTACKSEG =3D prog.get("MYHEAP");
> >
> > .
> > .
> > .
> > /*
> >  * TSK
> >  */
> > bios.TSK.ENABLETSK =3D true;
> > bios.TSK.STACKSEG =3D prog.get("MYHEAP");
> >
> >   I did a static compilation of this task and it was fine. Before the
> > loading of the resulted binary, I executed the following commands on th=
e
> > OSK board:
> >
> > # dspctl kmem_reserve 0x20000
> >
> > As in the .cmd file, it needs a TLB entry pointing to 0x30000, size
> > 0x5000
> > # dspctl exmap 0x30000 0x5000
> >
> > As in the .tcf file, it needs a TLB entry pointing to 0x35000, size
> > 0x10000
> > # dspctl exmap 0x35000 0x10000
> >
> >
> >   So, I did the loading:
> >
> > # dspctl start speex.out
> >
> >
> >   The loading was fine also. But when I run a user space program to
> > communicate to the DSP task through the DSP gateway device file, it
> > gets an error. The user space program only sends a ipbuffer a requests
> > another one. It sends and receives the ipbuffer without any problem.
> > And the user space application ends. The data produced by the encoder i=
s
> > correct. The problem is that the kernel prints out a message indicating
> > that there is a mailbox message from a non-existing DSP task. After
> > that, the DSP task hangs out. The message error code is: BADTID.
>
> Can you show me how you use bksnd() in your DSP task?

Ok. Here is it (just a piece of the tk_rcv_bkreq(), the function that
I point to in rcv_req field of my dsptast  struct):
/* Sending data in blocks */
static Uns tk_rcv_bkreq(struct dsptask *task, Uns cnt)
.
.
.
=09bid =3D get_free_ipbuf(task);
=09if (bid =3D=3D MBCMD_BID_NULL)
=09=09return MBCMD_EID_STVBUF;
=09
=09dbg(task, "11. preparing the buf\n");
=09ipbuf_d[bid][0] =3D nbBytes;

=09memcpy(ipbuf_d[bid]+1, cbits, nbBytes);
=09dbg(task, "12. sending data: %d words\n", nbBytes);
=09
=09bksnd(task, bid, cnt);

=09dbg(task, "13. releasing\n");

=09speex_encoder_destroy(enc);
=09speex_bits_destroy(&bits);

=09dbg(task, "14. done\n");
        return 0;
}

    Is there any problem in using dbg after sending the block (after
the bksnd call)?

> Because the TID used in the mailbox command is extracted from the "task"
> argument passed with the bksnd().
> Also the dump list of /sys/devices/platform/dsp/mblog may be some help.

here is my mblog, after the user space applications ends:
log count:35 / ARM->DSP:10, DSP->ARM:25
          ARM -> DSP   ARM <- DSP
jiffies  q cmd  data q cmd  data
ffff9fcb 0 7000 0000             DSPCFG:REQ
ffff9fcb             0 7070 0019 DSPCFG:PROTREV
ffff9fcb             1 f028 007f DSPCFG:SYSADRH
ffff9fcb             0 70a9 fe88 DSPCFG:SYSADRL
ffff9fcd             1 a300 0003 BKYLD
ffff9fcd             0 2300 0004 BKYLD
ffff9fcd             1 a300 0005 BKYLD
ffff9fce 0 6000 0000             TCFG:task 0
ffff9fcf             0 6000 0000 TCFG:task 0
ffff9fd8 1 b000 0000             TCTL:task 0
ffff9fd9 0 7500 ffff             SETVAR:ICRMASK
ffff9fd9             1 f900 0020 DBG
ffffa05b 1 d200 0002             PM:DISABLE
ffffe653 0 3000 8101             TCTL:task 0
ffffe653 1 d201 0002             PM:ENABLE
ffffe653 0 2000 0003             BKSND:task 0
ffffe653             0 7900 0027 DBG
ffffe655             1 f900 0014 DBG
ffffe655 1 a100 0065             BKREQ:task 0
ffffe656             0 7900 0017 DBG
ffffe657             1 f900 0010 DBG
ffffe65a             0 7900 0013 DBG
ffffe65b             1 f900 0016 DBG
ffffe65d             0 7900 0012 DBG
ffffe65e             1 f900 0012 DBG
ffffe663             0 7900 0018 DBG
ffffe664             1 f900 0015 DBG
ffffe665             0 7900 0015 DBG
ffffe665             1 f900 0016 DBG
ffffe666             0 7900 001b DBG
ffffe667             1 a000 0000 BKSND:task 0
ffffe667             0 7900 000e DBG
ffffe668             1 f900 0009 DBG
ffffe668             0 7810 0000 ERR:BADTID
ffffe6d5 0 5200 0002             PM:DISABLE



>
> BR,
> Toshihiro Kobayashi
>

BR,
--
Eduardo Bezerra Valentin
