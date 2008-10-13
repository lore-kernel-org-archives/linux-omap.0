From: "TK, Pratheesh Gangadhar" <pratheesh@ti.com>
Subject: disable_irq is broken in linux-omap-git
Date: Mon, 13 Oct 2008 15:21:02 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B020CBE5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48491 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932205AbYJMJvM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Oct 2008 05:51:12 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9D9p48q032731
	for <linux-omap@vger.kernel.org>; Mon, 13 Oct 2008 04:51:10 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9D9p29o029537
	for <linux-omap@vger.kernel.org>; Mon, 13 Oct 2008 15:21:03 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

=46YI, this seems to be currently broken as default_disable in kernel/i=
rq/chip.c is defined to be an EMPTY function. It will affect drivers us=
ing disable_irq and following patch fixes it.

static void default_disable(unsigned int irq)
{
+          struct irq_desc *desc =3D irq_desc + irq;
+
+          desc->chip->mask(irq);
+          desc->status |=3D IRQ_MASKED;
+
}

Regards,
Pratheesh
=A0
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
