From: Vovan <vovan888@gmail.com>
Subject: Re: sx1 alsa build failure
Date: Sun, 03 Dec 2006 21:20:50 +0300
Message-ID: <op.tjzw80b2dbah4f@localhost>
References: <3a5b1be00612031013v14ca1789ge5c58d125733e675@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3a5b1be00612031013v14ca1789ge5c58d125733e675@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal.shah802003@gmail.com>, linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

03.12.06 =E2 21:13 Komal Shah =E2 =F1=E2=EE=B8=EC =EF=E8=F1=FC=EC=E5 =EF=E8=
=F1=E0=EB(=E0):

> Hi Vladimir Ananiev,
>
> Could you please send a patch to fix this build error.?
>
> sound/arm/omap/omap-alsa-sx1.c:32: error: `CN_IDX_SX1SND' undeclared
> here (not in a function)
> sound/arm/omap/omap-alsa-sx1.c:32: error: initializer element is not =20
> constant
> sound/arm/omap/omap-alsa-sx1.c:32: error: (near initialization for
> `cn_sx1snd_id.idx')
> sound/arm/omap/omap-alsa-sx1.c:32: error: `CN_VAL_SX1SND' undeclared
> here (not in a function)
> sound/arm/omap/omap-alsa-sx1.c:32: error: initializer element is not =20
> constant
> sound/arm/omap/omap-alsa-sx1.c:32: error: (near initialization for
> `cn_sx1snd_id.val')
>
>

Sure, here it is:

diff --git a/include/linux/connector.h b/include/linux/connector.h
index 4c02119..0e2cbf1 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -36,9 +36,13 @@ #define CN_IDX_CIFS                  0x2
  #define CN_VAL_CIFS                     0x1
  #define CN_W1_IDX                      0x3     /* w1 communication */
  #define CN_W1_VAL                      0x1
+#define CN_IDX_SX1SND          0x4
+#define CN_VAL_SX1SND          0x1
+#define CN_IDX_SX1PM           0x5
+#define CN_VAL_SX1PM           0x1


-#define CN_NETLINK_USERS               4
+#define CN_NETLINK_USERS               6

  /*
   * Maximum connector's message size.


--=20
Vladimir Ananiev
