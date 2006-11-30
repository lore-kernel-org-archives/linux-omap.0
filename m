From: <Toshihiro.Kobayashi@nokia.com>
Subject: [PATCH] ARM: OMAP: fix for mailbox queue status detection
Date: Thu, 30 Nov 2006 20:09:01 +0900
Message-ID: <7AF192DA69C59243838FF62851F64F55033BEEC1@toebe101.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, hiroshi.doyu@nokia.com
List-Id: linux-omap@vger.kernel.org

detect 'full' and 'empty' correctly and simply.

Signed-off-by: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>

---

 arch/arm/plat-omap/mailbox.h |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

927a857c6e44fd508562d9d8c5654b9159449abc
diff --git a/arch/arm/plat-omap/mailbox.h b/arch/arm/plat-omap/mailbox.h
index f8b87a1..c3f8f2c 100644
--- a/arch/arm/plat-omap/mailbox.h
+++ b/arch/arm/plat-omap/mailbox.h
@@ -21,6 +21,7 @@ struct omap_mbq {
 	rwlock_t lock;
 	mbox_msg_t msg[MBQ_DEPTH];
 	mbox_msg_t *rp, *wp;
+	int cnt;
 };
=20
 static inline int mbq_init(struct omap_mbq **addr)
@@ -33,6 +34,7 @@ static inline int mbq_init(struct omap_m
=20
 	write_lock_irq(&m->lock);
 	m->rp =3D m->wp =3D &m->msg[0];
+	m->cnt =3D 0;
 	write_unlock_irq(&m->lock);
=20
 	*addr =3D m;
@@ -45,7 +47,7 @@ static inline int mbq_empty(struct omap_
 	int ret;
=20
 	read_lock_irq(&mbq->lock);
-	ret =3D (mbq->rp =3D=3D mbq->wp);
+	ret =3D (mbq->cnt =3D=3D 0);
 	read_unlock_irq(&mbq->lock);
=20
 	return ret;
@@ -54,16 +56,9 @@ static inline int mbq_empty(struct omap_
 static inline int mbq_full(struct omap_mbq *mbq)
 {
 	int ret;
-	mbox_msg_t *p;
=20
 	read_lock_irq(&mbq->lock);
-	p =3D mbq->wp;
-
-	if (++p =3D=3D &mbq->msg[MBQ_DEPTH])
-		p =3D &mbq->msg[0];
-
-	ret =3D (p =3D=3D mbq->rp);
-
+	ret =3D (mbq->cnt =3D=3D MBQ_DEPTH);
 	read_unlock_irq(&mbq->lock);
=20
 	return ret;
@@ -79,8 +74,8 @@ static inline int mbq_add(struct omap_mb
 	if (++mbq->wp =3D=3D &mbq->msg[MBQ_DEPTH])
 		mbq->wp =3D &mbq->msg[0];
=20
-	if (mbq->wp =3D=3D mbq->rp)	/* full */
-		ret =3D -1;;
+	if (++mbq->cnt =3D=3D MBQ_DEPTH)	/* full */
+		ret =3D -1;
=20
 	write_unlock_irq(&mbq->lock);
=20
@@ -97,6 +92,7 @@ static inline mbox_msg_t mbq_get(struct=20
=20
 	if (++mbq->rp =3D=3D &mbq->msg[MBQ_DEPTH])
 		mbq->rp =3D &mbq->msg[0];
+	mbq->cnt--;
=20
 	write_unlock_irq(&mbq->lock);
=20
--=20
1.3.3
