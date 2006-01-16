From: <Toshihiro.Kobayashi@nokia.com>
Subject: RE: Speex encoder running on DSP through DSP Gateway
Date: Mon, 16 Jan 2006 22:53:08 +0900
Message-ID: <7AF192DA69C59243838FF62851F64F5501B31F2A@toebe101.NOE.Nokia.com>
References: <a0580c510601131225h6f4a0d02r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <a0580c510601131225h6f4a0d02r@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: edubezval@gmail.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

>From: ext Eduardo Bezerra [mailto:edubezval@gmail.com]=20
>Sent: Saturday, January 14, 2006 5:26 AM

>> Can you show me how you use bksnd() in your DSP task?
>
>Ok. Here is it (just a piece of the tk_rcv_bkreq(), the function that
>I point to in rcv_req field of my dsptast  struct):
>/* Sending data in blocks */
>static Uns tk_rcv_bkreq(struct dsptask *task, Uns cnt)
>.
>.
>.
>	bid =3D get_free_ipbuf(task);
>	if (bid =3D=3D MBCMD_BID_NULL)
>		return MBCMD_EID_STVBUF;
>=09
>	dbg(task, "11. preparing the buf\n");
>	ipbuf_d[bid][0] =3D nbBytes;
>
>	memcpy(ipbuf_d[bid]+1, cbits, nbBytes);
>	dbg(task, "12. sending data: %d words\n", nbBytes);
>=09
>	bksnd(task, bid, cnt);
>
>	dbg(task, "13. releasing\n");
>
>	speex_encoder_destroy(enc);
>	speex_bits_destroy(&bits);
>
>	dbg(task, "14. done\n");
>        return 0;
>}
>
>    Is there any problem in using dbg after sending the block (after
>the bksnd call)?

No, it's OK at all.

>> Also the dump list of /sys/devices/platform/dsp/mblog may be some
help.
>
>here is my mblog, after the user space applications ends:
>log count:35 / ARM->DSP:10, DSP->ARM:25
>          ARM -> DSP   ARM <- DSP
>jiffies  q cmd  data q cmd  data
>ffff9fcb 0 7000 0000             DSPCFG:REQ
>ffff9fcb             0 7070 0019 DSPCFG:PROTREV
>ffff9fcb             1 f028 007f DSPCFG:SYSADRH
>ffff9fcb             0 70a9 fe88 DSPCFG:SYSADRL
>ffff9fcd             1 a300 0003 BKYLD
>ffff9fcd             0 2300 0004 BKYLD
>ffff9fcd             1 a300 0005 BKYLD
>ffff9fce 0 6000 0000             TCFG:task 0
>ffff9fcf             0 6000 0000 TCFG:task 0
>ffff9fd8 1 b000 0000             TCTL:task 0
>ffff9fd9 0 7500 ffff             SETVAR:ICRMASK
>ffff9fd9             1 f900 0020 DBG
>ffffa05b 1 d200 0002             PM:DISABLE
>ffffe653 0 3000 8101             TCTL:task 0
>ffffe653 1 d201 0002             PM:ENABLE
>ffffe653 0 2000 0003             BKSND:task 0
>ffffe653             0 7900 0027 DBG
>ffffe655             1 f900 0014 DBG
>ffffe655 1 a100 0065             BKREQ:task 0
>ffffe656             0 7900 0017 DBG
>ffffe657             1 f900 0010 DBG
>ffffe65a             0 7900 0013 DBG
>ffffe65b             1 f900 0016 DBG
>ffffe65d             0 7900 0012 DBG
>ffffe65e             1 f900 0012 DBG
>ffffe663             0 7900 0018 DBG
>ffffe664             1 f900 0015 DBG
>ffffe665             0 7900 0015 DBG
>ffffe665             1 f900 0016 DBG
>ffffe666             0 7900 001b DBG
>ffffe667             1 a000 0000 BKSND:task 0
>ffffe667             0 7900 000e DBG
>ffffe668             1 f900 0009 DBG
>ffffe668             0 7810 0000 ERR:BADTID
>ffffe6d5 0 5200 0002             PM:DISABLE

And this looks fine too, except for the BADTID error...

Unfortunately I have no idea at the moment.
Could you find out which routine in tokliBIOS returns
BADTID error, by replacing MBCMD_EID_BADTID with other values?

for example,

-------------------------------------------------
diff -urN 1/supertask.c 2/supertask.c
--- 1/supertask.c	2006-01-16 22:52:31 +09:00
+++ 2/supertask.c	2006-01-16 22:53:28 +09:00
@@ -346,7 +346,7 @@
 	Uns ret;
=20
 	if ((tid < n_task) || (tid >=3D N_TASK_MAX) || (task_prop[tid] =3D=3D
NULL)) {
-		ret =3D MBCMD_EID_BADTID;
+		ret =3D 0x83;	// test value
 		goto fail;
 	}
 	if (how =3D=3D MBCMD_TDEL_KILL) {
diff -urN 1/tokliBIOS.c 2/tokliBIOS.c
--- 1/tokliBIOS.c	2006-01-16 22:52:41 +09:00
+++ 2/tokliBIOS.c	2006-01-16 22:53:05 +09:00
@@ -182,7 +182,7 @@
 	if (bid >=3D _ipbuf_lines)
 		return MBCMD_EID_BADBID;
 	if ((tid >=3D N_TASK_MAX) || (task_prop[tid] =3D=3D NULL))
-		return MBCMD_EID_BADTID;
+		return 0x82;	// test value
 	sync_with_arm(&ipbuf[bid]->sa, tid);
=20
 	return 0;
diff -urN 1/usertask.c 2/usertask.c
--- 1/usertask.c	2006-01-16 22:48:59 +09:00
+++ 2/usertask.c	2006-01-16 22:49:37 +09:00
@@ -301,7 +301,7 @@
 	Uns wp, newwp;
=20
 	if ((tid >=3D N_TASK_MAX) || (task_prop[tid] =3D=3D NULL))
-		return MBCMD_EID_BADTID;
+		return 0x80;	// test value
=20
 	prop =3D task_prop[tid];
 	if (prop->stat =3D=3D TASK_STAT_STOP)
@@ -389,7 +389,7 @@
 	struct TSK_Attrs *attrs;
=20
 	if (task->tid !=3D TID_MAGIC)
-		return MBCMD_EID_BADTID;
+		return 0x81;	// test value
=20
 	task_prop[tid] =3D prop;
 	prop->dsptask =3D task;
-------------------------------------------------

BR,
Toshihiro Kobayashi
