From: Eduardo Bezerra <edubezval@gmail.com>
Subject: Re: Speex encoder running on DSP through DSP Gateway
Date: Wed, 18 Jan 2006 08:52:29 -0400
Message-ID: <a0580c510601180452u6b247c64t@mail.gmail.com>
References: <a0580c510601131225h6f4a0d02r@mail.gmail.com>
	<7AF192DA69C59243838FF62851F64F5501B31F2A@toebe101.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <7AF192DA69C59243838FF62851F64F5501B31F2A@toebe101.NOE.Nokia.com>
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
To: "Toshihiro.Kobayashi@nokia.com" <Toshihiro.Kobayashi@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,


  I did your changes to find out what routine in tokliBIOS returns BADTID e=
rror.
And it returned 0x81, as you can see in the mailbox kernel message from my
dmesg:

mbx: receiving seq=3D0, cmd=3D78:81(ERR:Unknown), data=3D0000
mbx: ERR from DSP (unknown EID=3D81): 0000
mbx: sending seq=3D0, cmd=3D52:00(PM:DISABLE), data=3D0002

  and here is my mblog:

arm:~/dspgw# cat /sys/devices/platform/dsp/mblog
log count:47 / ARM->DSP:15, DSP->ARM:32
          ARM -> DSP   ARM <- DSP
jiffies  q cmd  data q cmd  data
0066e9b3 0 7000 0000             DSPCFG:REQ
0066e9b3             0 7070 0019 DSPCFG:PROTREV
0066e9b3             1 f028 007f DSPCFG:SYSADRH
0066e9b3             0 70a9 fe88 DSPCFG:SYSADRL
0066e9b6             1 a300 0003 BKYLD
0066e9b6             0 2300 0004 BKYLD
0066e9b6             1 a300 0005 BKYLD
0066e9b7 0 6000 0000             TCFG:task 0
0066e9b7             0 6000 0000 TCFG:task 0
0066e9c1 1 b000 0000             TCTL:task 0
0066e9c3 0 7500 ffff             SETVAR:ICRMASK
0066ea43 1 d200 0002             PM:DISABLE
00670d32 0 7000 0000             DSPCFG:REQ
00670d32             0 7070 0019 DSPCFG:PROTREV
00670d32             1 f028 007f DSPCFG:SYSADRH
00670d32             0 70a9 fe88 DSPCFG:SYSADRL
00670d34             1 a300 0003 BKYLD
00670d34             0 2300 0004 BKYLD
00670d34             1 a300 0005 BKYLD
00670d36 0 6000 0000             TCFG:task 0
00670d36             0 6000 0000 TCFG:task 0
00670d3e 1 b000 0000             TCTL:task 0
00670d40 0 7500 ffff             SETVAR:ICRMASK
00670d40             1 f900 0020 DBG
00670dc2 1 d200 0002             PM:DISABLE
006720a7 0 3000 8101             TCTL:task 0
006720a7             0 7900 0027 DBG
006720a7 1 d201 0002             PM:ENABLE
006720a9 0 2000 0003             BKSND:task 0
006720a9             1 f900 0014 DBG
006720ab 1 a100 0065             BKREQ:task 0
006720ab             0 7900 0017 DBG
006720ac             1 f900 0010 DBG
006720af             0 7900 0013 DBG
006720b0             1 f900 0016 DBG
006720b2             0 7900 0012 DBG
006720b3             1 f900 0012 DBG
006720b7             0 7900 0018 DBG
006720b8             1 f900 0015 DBG
006720b9             0 7900 0015 DBG
006720ba             1 f900 0016 DBG
006720bb             0 7900 001b DBG
006720bb             1 a000 0000 BKSND:task 0
006720bc             0 7900 000e DBG
006720bc             1 f900 0009 DBG
006720bd             0 7881 0000 ERR:Unknown
0067213c 0 5200 0002             PM:DISABLE

   As I can see in your patch, 0x81 is returned by task_config, when
it checks the
dsp task struct looking for a  TID_MAGIC flag. However, my dsp task struct =
is:

#pragma DATA_SECTION(task_test, "dspgw_task")

struct dsptask task_test =3D {
        TID_MAGIC,              /*tid*/
        "task_speex",
        MBCMD_TTYP_GBDM | MBCMD_TTYP_GBMD |
        MBCMD_TTYP_BKDM | MBCMD_TTYP_BKMD |
        MBCMD_TTYP_PSND | MBCMD_TTYP_PRCV,      /* ttyp: passive block
sender, passive block receiver */
        tk_rcv_bksnd, /* rcv_snd */
        tk_rcv_bkreq, /* rcv_req */
        tk_rcv_tctl, /* rcv_tctl */
        NULL, /* tsk_attrs */
        NULL, /* mmap_info */
        &queue/* udata */
};

   I didn't forget to put the TID_MAGIC, as you can see. Nevertheless,
the problem
occurs after the end of the user space application. What do you think?
Do I need to
set TID_MAGIC again, after sending blocks to the ARM side?


2006/1/16, Toshihiro.Kobayashi@nokia.com <Toshihiro.Kobayashi@nokia.com>:
> Hi,
>
> >From: ext Eduardo Bezerra [mailto:edubezval@gmail.com]
> >Sent: Saturday, January 14, 2006 5:26 AM
>
> >> Can you show me how you use bksnd() in your DSP task?
> >
> >Ok. Here is it (just a piece of the tk_rcv_bkreq(), the function that
> >I point to in rcv_req field of my dsptast  struct):
> >/* Sending data in blocks */
> >static Uns tk_rcv_bkreq(struct dsptask *task, Uns cnt)
> >.
> >.
> >.
> >       bid =3D get_free_ipbuf(task);
> >       if (bid =3D=3D MBCMD_BID_NULL)
> >               return MBCMD_EID_STVBUF;
> >
> >       dbg(task, "11. preparing the buf\n");
> >       ipbuf_d[bid][0] =3D nbBytes;
> >
> >       memcpy(ipbuf_d[bid]+1, cbits, nbBytes);
> >       dbg(task, "12. sending data: %d words\n", nbBytes);
> >
> >       bksnd(task, bid, cnt);
> >
> >       dbg(task, "13. releasing\n");
> >
> >       speex_encoder_destroy(enc);
> >       speex_bits_destroy(&bits);
> >
> >       dbg(task, "14. done\n");
> >        return 0;
> >}
> >
> >    Is there any problem in using dbg after sending the block (after
> >the bksnd call)?
>
> No, it's OK at all.
>
> >> Also the dump list of /sys/devices/platform/dsp/mblog may be some
> help.
> >
> >here is my mblog, after the user space applications ends:
> >log count:35 / ARM->DSP:10, DSP->ARM:25
> >          ARM -> DSP   ARM <- DSP
> >jiffies  q cmd  data q cmd  data
> >ffff9fcb 0 7000 0000             DSPCFG:REQ
> >ffff9fcb             0 7070 0019 DSPCFG:PROTREV
> >ffff9fcb             1 f028 007f DSPCFG:SYSADRH
> >ffff9fcb             0 70a9 fe88 DSPCFG:SYSADRL
> >ffff9fcd             1 a300 0003 BKYLD
> >ffff9fcd             0 2300 0004 BKYLD
> >ffff9fcd             1 a300 0005 BKYLD
> >ffff9fce 0 6000 0000             TCFG:task 0
> >ffff9fcf             0 6000 0000 TCFG:task 0
> >ffff9fd8 1 b000 0000             TCTL:task 0
> >ffff9fd9 0 7500 ffff             SETVAR:ICRMASK
> >ffff9fd9             1 f900 0020 DBG
> >ffffa05b 1 d200 0002             PM:DISABLE
> >ffffe653 0 3000 8101             TCTL:task 0
> >ffffe653 1 d201 0002             PM:ENABLE
> >ffffe653 0 2000 0003             BKSND:task 0
> >ffffe653             0 7900 0027 DBG
> >ffffe655             1 f900 0014 DBG
> >ffffe655 1 a100 0065             BKREQ:task 0
> >ffffe656             0 7900 0017 DBG
> >ffffe657             1 f900 0010 DBG
> >ffffe65a             0 7900 0013 DBG
> >ffffe65b             1 f900 0016 DBG
> >ffffe65d             0 7900 0012 DBG
> >ffffe65e             1 f900 0012 DBG
> >ffffe663             0 7900 0018 DBG
> >ffffe664             1 f900 0015 DBG
> >ffffe665             0 7900 0015 DBG
> >ffffe665             1 f900 0016 DBG
> >ffffe666             0 7900 001b DBG
> >ffffe667             1 a000 0000 BKSND:task 0
> >ffffe667             0 7900 000e DBG
> >ffffe668             1 f900 0009 DBG
> >ffffe668             0 7810 0000 ERR:BADTID
> >ffffe6d5 0 5200 0002             PM:DISABLE
>
> And this looks fine too, except for the BADTID error...
>
> Unfortunately I have no idea at the moment.
> Could you find out which routine in tokliBIOS returns
> BADTID error, by replacing MBCMD_EID_BADTID with other values?
>
> for example,
>
> -------------------------------------------------
> diff -urN 1/supertask.c 2/supertask.c
> --- 1/supertask.c       2006-01-16 22:52:31 +09:00
> +++ 2/supertask.c       2006-01-16 22:53:28 +09:00
> @@ -346,7 +346,7 @@
>         Uns ret;
>
>         if ((tid < n_task) || (tid >=3D N_TASK_MAX) || (task_prop[tid] =
=3D=3D
> NULL)) {
> -               ret =3D MBCMD_EID_BADTID;
> +               ret =3D 0x83;     // test value
>                 goto fail;
>         }
>         if (how =3D=3D MBCMD_TDEL_KILL) {
> diff -urN 1/tokliBIOS.c 2/tokliBIOS.c
> --- 1/tokliBIOS.c       2006-01-16 22:52:41 +09:00
> +++ 2/tokliBIOS.c       2006-01-16 22:53:05 +09:00
> @@ -182,7 +182,7 @@
>         if (bid >=3D _ipbuf_lines)
>                 return MBCMD_EID_BADBID;
>         if ((tid >=3D N_TASK_MAX) || (task_prop[tid] =3D=3D NULL))
> -               return MBCMD_EID_BADTID;
> +               return 0x82;    // test value
>         sync_with_arm(&ipbuf[bid]->sa, tid);
>
>         return 0;
> diff -urN 1/usertask.c 2/usertask.c
> --- 1/usertask.c        2006-01-16 22:48:59 +09:00
> +++ 2/usertask.c        2006-01-16 22:49:37 +09:00
> @@ -301,7 +301,7 @@
>         Uns wp, newwp;
>
>         if ((tid >=3D N_TASK_MAX) || (task_prop[tid] =3D=3D NULL))
> -               return MBCMD_EID_BADTID;
> +               return 0x80;    // test value
>
>         prop =3D task_prop[tid];
>         if (prop->stat =3D=3D TASK_STAT_STOP)
> @@ -389,7 +389,7 @@
>         struct TSK_Attrs *attrs;
>
>         if (task->tid !=3D TID_MAGIC)
> -               return MBCMD_EID_BADTID;
> +               return 0x81;    // test value
>
>         task_prop[tid] =3D prop;
>         prop->dsptask =3D task;
> -------------------------------------------------
>
> BR,
> Toshihiro Kobayashi
>


--
Eduardo Bezerra Valentin
