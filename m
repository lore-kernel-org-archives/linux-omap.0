From: "Gutierrez, Juan" <jgutierrez@ti.com>
Subject: [PATCH 1/3] omap: mailbox: enable mailbox irq per instance
Date: Fri, 13 Apr 2012 16:53:15 -0500
Message-ID: <CADVn9RHhA8ywkLaHDqsTWVDaUkY-kM3GqrCa4pVx=17gBrZFSQ@mail.gmail.com>
References: <1334352255-48584-1-git-send-email-jgutierrez@ti.com> <1334352255-48584-2-git-send-email-jgutierrez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:45890 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932217Ab2DMVxh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 17:53:37 -0400
Received: by yhjj63 with SMTP id j63so2242618yhj.23
        for <linux-omap@vger.kernel.org>; Fri, 13 Apr 2012 14:53:36 -0700 (PDT)
In-Reply-To: <1334352255-48584-2-git-send-email-jgutierrez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ohad@wizery.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: jgutierrez@ti.com, s-anna@ti.com

The machine-specific omap2_mbox_startup is called only once
to initialize the whole mbox module. Enabling mbox irq at
startup is only enabling the irq of the very first mailbox
instance created.

The enable_irq function should be called every time a
new mbox instance is created, in the generic platform
mailbox layer.

Signed-off-by: Juan Gutierrez <jgutierrez@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
=C2=A0arch/arm/mach-omap2/mailbox.c | =C2=A0 =C2=A02 --
=C2=A0arch/arm/plat-omap/mailbox.c =C2=A0| =C2=A0 =C2=A03 +++
=C2=A02 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbo=
x.c
index 415a6f1..f727034 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -83,8 +83,6 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
=C2=A0 =C2=A0 =C2=A0 =C2=A0l =3D mbox_read_reg(MAILBOX_REVISION);
=C2=A0 =C2=A0 =C2=A0 =C2=A0pr_debug("omap mailbox rev %d.%d\n", (l & 0x=
f0) >> 4, (l & 0x0f));

- =C2=A0 =C2=A0 =C2=A0 omap2_mbox_enable_irq(mbox, IRQ_RX);
-
=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
=C2=A0}

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.=
c
index ad32621..ebc1ba5 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -282,6 +282,8 @@ static int omap_mbox_startup(struct omap_mbox *mbox=
)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mbox->rxq =3D mq=
;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mq->mbox =3D mbo=
x;
+
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mbox->ops->enable_ir=
q(mbox, IRQ_RX);
=C2=A0 =C2=A0 =C2=A0 =C2=A0}
=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&mbox_configured_lock);
=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
@@ -305,6 +307,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&mbox_configured_lock);

=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!--mbox->use_count) {
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mbox->ops->disable_i=
rq(mbox, IRQ_RX);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_irq(mbox->i=
rq, mbox);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tasklet_kill(&mb=
ox->txq->tasklet);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flush_work_sync(=
&mbox->rxq->work);
--
1.7.5.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
