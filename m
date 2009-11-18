From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/4] OMAP3 hwmod: drop most of the OCP_SYSCONFIG.CLOCKACTIVITY
	code
Date: Wed, 18 Nov 2009 04:34:40 -0700
Message-ID: <20091118113439.8617.6899.stgit@localhost.localdomain>
References: <20091118113212.8617.3864.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51194 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbZKRLgh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 06:36:37 -0500
In-Reply-To: <20091118113212.8617.3864.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Sebastien Sabatier <s-sabatier1@ti.com>

Earlier, the hwmod code had considered the OCP_SYSCONFIG.CLOCKACTIVITY
bits to be incremental power saving bits, controlling internal IP
block clock gates.  This was a misapprehension.  The CLOCKACTIVITY
bits are used to indicate, in advance, which clocks will be cut when
the module acknowledges an idle request.  This enables the IP block to
take whatever action is necessary to complete any in-progress work
before asserting its IdleAck.

In the current Linux-OMAP code, this implies that the clock framework
should be changing module CLOCKACTIVITY bits as module clocks are enabl=
ed
and disabled.  We don't do that yet, but in the future, we should.
This must wait until the clock tree is annotated with omap_hwmod pointe=
rs
(or vice-versa).  In the meantime, drop most of the hwmod code that
controls CLOCKACTIVITY bits to avoid confusion.

This patch has benefited from many illuminating discussions with (in
alphabetical order) Beno=C3=AEt Cousson <b-cousson@ti.com>, Rajendra Na=
yak
<rnayak@ti.com>, and Sebastien Sabatier <s-sabatier1@ti.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Sebastien Sabatier <s-sabatier1@ti.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   88 ++----------------------------=
--------
 1 files changed, 5 insertions(+), 83 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 234567b..eedcc5f 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -591,6 +591,11 @@ static void _sysc_enable(struct omap_hwmod *oh)
=20
 	/* XXX OCP ENAWAKEUP bit? */
=20
+	/*=20
+	 * XXX The clock framework should handle this, by=20
+	 * calling into this code.  But this must wait until the
+	 * clock structures are tagged with omap_hwmod entries
+	 */
 	if (oh->flags & HWMOD_SET_DEFAULT_CLOCKACT &&
 	    oh->sysconfig->sysc_flags & SYSC_HAS_CLOCKACTIVITY)
 		_set_clockactivity(oh, oh->sysconfig->clockact, &v);
@@ -917,33 +922,6 @@ static int _shutdown(struct omap_hwmod *oh)
 }
=20
 /**
- * _write_clockact_lock - set the module's clockactivity bits
- * @oh: struct omap_hwmod *
- * @clockact: CLOCKACTIVITY field bits
- *
- * Writes the CLOCKACTIVITY bits @clockact to the hwmod @oh
- * OCP_SYSCONFIG register.  Returns -EINVAL if the hwmod is in the
- * wrong state or returns 0.
- */
-static int _write_clockact_lock(struct omap_hwmod *oh, u8 clockact)
-{
-	u32 v;
-
-	if (!oh->sysconfig ||
-	    !(oh->sysconfig->sysc_flags & SYSC_HAS_CLOCKACTIVITY))
-		return -EINVAL;
-
-	mutex_lock(&omap_hwmod_mutex);
-	v =3D oh->_sysc_cache;
-	_set_clockactivity(oh, clockact, &v);
-	_write_sysconfig(v, oh);
-	mutex_unlock(&omap_hwmod_mutex);
-
-	return 0;
-}
-
-
-/**
  * _setup - do initial configuration of omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -1496,62 +1474,6 @@ int omap_hwmod_del_initiator_dep(struct omap_hwm=
od *oh,
 }
=20
 /**
- * omap_hwmod_set_clockact_none - set clockactivity test to BOTH
- * @oh: struct omap_hwmod *
- *
- * On some modules, this function can affect the wakeup latency vs.
- * power consumption balance.  Intended to be called by the
- * omap_device layer.  Passes along the return value from
- * _write_clockact_lock().
- */
-int omap_hwmod_set_clockact_both(struct omap_hwmod *oh)
-{
-	return _write_clockact_lock(oh, CLOCKACT_TEST_BOTH);
-}
-
-/**
- * omap_hwmod_set_clockact_none - set clockactivity test to MAIN
- * @oh: struct omap_hwmod *
- *
- * On some modules, this function can affect the wakeup latency vs.
- * power consumption balance.  Intended to be called by the
- * omap_device layer.  Passes along the return value from
- * _write_clockact_lock().
- */
-int omap_hwmod_set_clockact_main(struct omap_hwmod *oh)
-{
-	return _write_clockact_lock(oh, CLOCKACT_TEST_MAIN);
-}
-
-/**
- * omap_hwmod_set_clockact_none - set clockactivity test to ICLK
- * @oh: struct omap_hwmod *
- *
- * On some modules, this function can affect the wakeup latency vs.
- * power consumption balance.  Intended to be called by the
- * omap_device layer.  Passes along the return value from
- * _write_clockact_lock().
- */
-int omap_hwmod_set_clockact_iclk(struct omap_hwmod *oh)
-{
-	return _write_clockact_lock(oh, CLOCKACT_TEST_ICLK);
-}
-
-/**
- * omap_hwmod_set_clockact_none - set clockactivity test to NONE
- * @oh: struct omap_hwmod *
- *
- * On some modules, this function can affect the wakeup latency vs.
- * power consumption balance.  Intended to be called by the
- * omap_device layer.  Passes along the return value from
- * _write_clockact_lock().
- */
-int omap_hwmod_set_clockact_none(struct omap_hwmod *oh)
-{
-	return _write_clockact_lock(oh, CLOCKACT_TEST_NONE);
-}
-
-/**
  * omap_hwmod_enable_wakeup - allow device to wake up the system
  * @oh: struct omap_hwmod *
  *


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
